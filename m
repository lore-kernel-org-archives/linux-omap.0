From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH 2/5] mfd: twl4030-power: Add comments for the register and bit layout
Date: Mon, 19 Oct 2009 15:10:48 +0300
Message-ID: <1255954248-28945-1-git-send-email-amit.kucheria@verdurent.com>
References: <1255954211-28496-1-git-send-email-amit.kucheria@verdurent.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755827AbZJSMKw@vger.kernel.org>
In-Reply-To: <1255954211-28496-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-kernel-owner@vger.kernel.org
To: List Linux Kernel <linux-kernel@vger.kernel.org>
Cc: sameo@linux.intel.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Describe how the resource registers are laid out and the various bit-fields in
them.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/twl4030-power.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 82e3bcb..2c38ac1 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -67,14 +67,22 @@ static u8 twl4030_start_script_address = 0x2b;
 #define R_KEY_1			0xC0
 #define R_KEY_2			0x0C
 
-/* resource configuration registers */
-
+/* resource configuration registers
+   <RESOURCE>_DEV_GRP   at address 'n+0'
+   <RESOURCE>_TYPE      at address 'n+1'
+   <RESOURCE>_REMAP     at address 'n+2'
+   <RESOURCE>_DEDICATED at address 'n+3'
+*/
 #define DEV_GRP_OFFSET		0
 #define TYPE_OFFSET		1
 
 /* Bit positions in the registers */
+
+/* <RESOURCE>_DEV_GRP */
 #define DEV_GRP_SHIFT		5
 #define DEV_GRP_MASK		(7 << DEV_GRP_SHIFT)
+
+/* <RESOURCE>_TYPE */
 #define TYPE_SHIFT		0
 #define TYPE_MASK		(7 << TYPE_SHIFT)
 #define TYPE2_SHIFT		3
-- 
1.6.3.3
