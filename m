From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH 8/9] usb: otg-fsm: Remove unused members in struct otg_fsm
Date: Wed, 18 Mar 2015 15:56:02 +0200
Message-ID: <1426686963-11613-9-git-send-email-rogerq@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

These members are not used anywhere so remove them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/usb/otg-fsm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index b6ba1bf..176c4fc 100644
--- a/include/linux/usb/otg-fsm.h
+++ b/include/linux/usb/otg-fsm.h
@@ -95,11 +95,6 @@ struct otg_fsm {
 	int b_hnp_enable;
 	int a_clr_err;
 
-	/* Informative variables */
-	int a_bus_drop_inf;
-	int a_bus_req_inf;
-	int a_clr_err_inf;
-	int b_bus_req_inf;
 	/* Auxilary informative variables */
 	int a_suspend_req_inf;
 
-- 
2.1.0
