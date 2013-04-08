From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/8] staging: ti-soc-thermal: update TODO list
Date: Mon, 8 Apr 2013 08:19:07 -0400
Message-ID: <1365423555-2669-2-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch removes out of the TODO list those already completed.

Here is the status and why they are removed:
 on ti-bandgap.c:
-- Add support to hwmon: REMOVED, no need to have hwmon interfaces
as the control is done via thermal framework.
-- Test every exposed API to userland: DONE, via thermal fw APIs
By now, no specific API is exposed by this driver
-- Revisit data structures and simplify them: DONE, all
unused fields are flagged for future removal.
-- Once SCM-core api settles, update this driver accordingly: DONE,
the BG driver can exist without SCM driver by ioremapping its own
registers and doing its own locking.

 on ti-thermal-common.c/ti-thermal.h:
-- Revisit trips and its definitions: DONE, for now there is no
need to change current definition. Alert based policy will be add
in future.
-- Revisit trending: DONE, OMAP5 history buffer support has been
implemented. Devices without history buffer will use thermal fw
trending capability.

on omap5-thermal.c
-- Add support for GPU cooling: REMOVED: this will not be part
of this driver. Must be done in a separated cooling device.

 generally:
-- make checkpatch.pl and sparse happy: DONE, sparse remaining
warning is not an issue.
-- update documentation: DONE, kernel-doc for ti-bandgap is now
available.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/TODO |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/TODO b/drivers/staging/ti-soc-thermal/TODO
index 9b4c841..b320388 100644
--- a/drivers/staging/ti-soc-thermal/TODO
+++ b/drivers/staging/ti-soc-thermal/TODO
@@ -1,24 +1,13 @@
 List of TODOs (by Eduardo Valentin)
 
 on ti-bandgap.c:
-- Test every exposed API to userland
-- Add support to hwmon
 - Revisit PM support
-- Revisit data structures and simplify them
-- Once SCM-core api settles, update this driver accordingly
 
 on ti-thermal-common.c/ti-thermal.h:
 - Revisit extrapolation constants for O4/O5
 - Revisit need for locking
-- Revisit trips and its definitions
-- Revisit trending
-
-on omap5-thermal.c
-- Add support for GPU cooling
 
 generally:
-- make checkpatch.pl and sparse happy
 - make sure this code works on OMAP4430, OMAP4460 and OMAP5430
-- update documentation
 
 Copy patches to Eduardo Valentin <eduardo.valentin@ti.com>
-- 
1.7.7.1.488.ge8e1c

