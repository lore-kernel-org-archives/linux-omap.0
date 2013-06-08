From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 6/7] ARM: OMAP2+: add user and fifo info to mailbox platform data
Date: Fri, 7 Jun 2013 20:58:08 -0500
Message-ID: <1370656688-41390-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3FHCDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 22:03:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The different generations of OMAP2+ SoCs have almost the same
mailbox IP, but the IP has configurable parameters for number
of users (interrupts it can generate out towards processors)
and number of fifos (the base unidirectional h/w communication
channel). This data cannot be read from any registers, and so
has been added to the platform data.

This data together with the interrupt-type configuration can be
used in properly figuring out the number of registers to save
and restore in the OMAP mailbox driver code.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 2 ++
 include/linux/platform_data/mailbox-omap.h | 5 +++++
 5 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index dbcb928..d8b9d60 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -173,6 +173,8 @@ static struct omap_mbox_dev_info omap2420_mailbox_info[] = {
 };
 
 static struct omap_mbox_pdata omap2420_mailbox_attrs = {
+	.num_users	= 4,
+	.num_fifos	= 6,
 	.info_cnt	= ARRAY_SIZE(omap2420_mailbox_info),
 	.info		= omap2420_mailbox_info,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index df2f874..5b90834 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -176,6 +176,8 @@ static struct omap_mbox_dev_info omap2430_mailbox_info[] = {
 };
 
 static struct omap_mbox_pdata omap2430_mailbox_attrs = {
+	.num_users	= 4,
+	.num_fifos	= 6,
 	.info_cnt	= ARRAY_SIZE(omap2430_mailbox_info),
 	.info		= omap2430_mailbox_info,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9ac5122..8e4cbc9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1511,6 +1511,8 @@ static struct omap_mbox_dev_info omap3xxx_mailbox_info[] = {
 };
 
 static struct omap_mbox_pdata omap3xxx_mailbox_attrs = {
+	.num_users	= 2,
+	.num_fifos	= 2,
 	.info_cnt	= ARRAY_SIZE(omap3xxx_mailbox_info),
 	.info		= omap3xxx_mailbox_info,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4065962..6aafc9d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1869,6 +1869,8 @@ static struct omap_mbox_dev_info omap44xx_mailbox_info[] = {
 
 static struct omap_mbox_pdata omap44xx_mailbox_attrs = {
 	.intr_type	= MBOX_INTR_CFG_TYPE2,
+	.num_users	= 3,
+	.num_fifos	= 8,
 	.info_cnt	= ARRAY_SIZE(omap44xx_mailbox_info),
 	.info		= omap44xx_mailbox_info,
 };
diff --git a/include/linux/platform_data/mailbox-omap.h b/include/linux/platform_data/mailbox-omap.h
index 676cd64..4631dbb 100644
--- a/include/linux/platform_data/mailbox-omap.h
+++ b/include/linux/platform_data/mailbox-omap.h
@@ -41,11 +41,16 @@ struct omap_mbox_dev_info {
  * struct omap_mbox_pdata - OMAP mailbox platform data
  * @intr_type:	type of interrupt configuration registers used
 			while programming mailbox queue interrupts
+ * @num_users:	number of users (processor devices) that the mailbox
+ *			h/w block can interrupt
+ * @num_fifos:	number of h/w fifos within the mailbox h/w block
  * @info_cnt:	number of mailbox devices for the platform
  * @info:	array of mailbox device attributes
  */
 struct omap_mbox_pdata {
 	u32 intr_type;
+	u32 num_users;
+	u32 num_fifos;
 	u32 info_cnt;
 	struct omap_mbox_dev_info *info;
 };
-- 
1.8.2

