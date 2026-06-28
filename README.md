# Aquafarm Fish Pond Management System

## Project Overview

A comprehensive **relational database system** designed to help aquafarm operators manage their fish farming operations efficiently. This system tracks everything from pond conditions, fish batches, health status, feeding schedules, equipment usage, sales transactions, to inventory and cost management.

This project was completed as a group assignment for **Database System Fundamentals (UECS1203)** at UTAR.

---

## Project Objectives

- **Track fish batches** from stocking to harvest, including species, pond assignment, and health status.
- **Monitor water quality** parameters (temperature, pH, dissolved oxygen) for each batch.
- **Manage daily activities** such as feeding, water changes, cleaning, and health checks.
- **Record equipment usage** and analyze utilization patterns.
- **Handle sales transactions** and identify top customers.
- **Track inventory** with automatic reorder alerts for low stock items.
- **Calculate operational costs** per batch for profitability analysis.

---

## Database Schema

The database consists of **18+ interconnected tables** normalized up to **3NF (Third Normal Form)** .

### Core Tables

| Table Name | Description |
| :--- | :--- |
| `Pond` | Stores pond locations and sizes |
| `Batch` | Tracks fish batches and their pond assignments |
| `Species` | Lists fish species being farmed |
| `Health_Status` | Records health conditions, mortality rates, and treatments |
| `Water_Quality` | Logs temperature, pH, and dissolved oxygen readings |

### Operations Tables

| Table Name | Description |
| :--- | :--- |
| `Staff` | Employee information |
| `Role` | Staff roles (Manager, Operator) |
| `Feeding_Management` | Tracks feeding events |
| `Daily_Activity_Management` | Logs daily operational activities |
| `Activity_Type` | Categories of activities |
| `Equipment` | Farm equipment inventory |
| `Equipment_Usage` | Tracks when and how equipment is used |

### Business Tables

| Table Name | Description |
| :--- | :--- |
| `Customer` | Customer information |
| `Sales_Transaction` | Records fish sales |
| `Inventory_Item` | Tracks stock of feed, medicine, and equipment |
| `Category` | Item categories |
| `Supplier` | Supplier details |
| `Purchase_Order` | Purchase order tracking |
| `PO_Detail` | Line items for purchase orders |
| `Cost_Record` | Tracks operational costs |

---

