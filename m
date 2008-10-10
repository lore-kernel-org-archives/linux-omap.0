From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 6/7] Generic twl4030 power script for 3430 based boards.
Date: Fri, 10 Oct 2008 19:56:15 +0300
Message-ID: <1223657776-16544-7-git-send-email-peter.de-schrijver@nokia.com>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-3-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-6-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42991 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759508AbYJJQ4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 12:56:33 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9AGuJEj013184
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 19:56:31 +0300
In-Reply-To: <1223657776-16544-6-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This is a generic twl4030 power script for 3430 based boards. It handles
sleep and wakeup events. In case of a sleep event it will first put the
Reset and Control (RC) resources to sleep and then put the voltage regulators
to sleep. In case of a wakeup event, the system clock will be started first,
then the voltage regulators will be woken up and finally the RC resources will
be woken up.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/twl4030-generic-scripts.c |   78 +++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-generic-scripts.c

diff --git a/arch/arm/mach-omap2/twl4030-generic-scripts.c b/arch/arm/mach-omap2/twl4030-generic-scripts.c
new file mode 100644
index 0000000..f41c9ef
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030-generic-scripts.c
@@ -0,0 +1,78 @@
+/*
+ * arch/arm/mach-omap2/twl4030-generic-scripts.c
+ *
+ * Generic power control scripts for TWL4030
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2006 Texas Instruments, Inc
+ *
+ * Written by 	Kalle Jokiniemi
+ *		Peter De Schrijver <peter.de-schrijver@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/i2c/twl4030.h>
+
+/*
+ * This script instructs twl4030 to first put the Reset and Control (RC)
+ * resources to sleep and then all the other resources.
+ */
+
+static struct twl4030_ins sleep_on_seq[] __initdata = {
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
+			RES_STATE_SLEEP), 4},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
+			RES_STATE_SLEEP), 4},
+};
+
+static struct twl4030_script sleep_on_script __initdata = {
+	.script = sleep_on_seq,
+	.size   = ARRAY_SIZE(sleep_on_seq),
+	.flags  = TRITON_SLEEP_SCRIPT,
+};
+
+/*
+ * This script instructs twl4030 to first enable CLKEN, then wakeup the
+ * regulators and then all other resources.
+ */
+
+static struct twl4030_ins wakeup_seq[] __initdata = {
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x17, RES_STATE_ACTIVE), 0x30},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_PP_PR, RES_TYPE_ALL, RES_TYPE2_R0,
+			RES_STATE_ACTIVE), 0x37},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
+			RES_STATE_ACTIVE), 0x2},
+};
+
+static struct twl4030_script wakeup_script __initdata = {
+	.script = wakeup_seq,
+	.size   = ARRAY_SIZE(wakeup_seq),
+	.flags  = TRITON_WAKEUP12_SCRIPT | TRITON_WAKEUP3_SCRIPT,
+};
+
+static struct twl4030_script *twl4030_scripts[] __initdata = {
+	&sleep_on_script,
+	&wakeup_script,
+};
+
+struct twl4030_power_data generic3430_t2scripts_data __initdata = {
+	.scripts        = twl4030_scripts,
+	.size           = ARRAY_SIZE(twl4030_scripts),
+};
+
+
-- 
1.5.6.3

