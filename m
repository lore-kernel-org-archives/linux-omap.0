From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/15] omap: mailbox: mark some resources as __initdata
Date: Thu, 13 May 2010 20:47:36 +0300
Message-ID: <1273772856-10881-16-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:26527 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab0EMRtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:49:06 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1240391fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:49:04 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index b01d3c3..74d2677 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -144,7 +144,7 @@ struct omap_mbox mbox_dsp_info = {
 struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-static struct resource omap1_mbox_resources[] = {
+static struct resource __initdata omap1_mbox_resources[] = {
 	{
 		.start		= OMAP16XX_MAILBOX_BASE,
 		.end		= OMAP16XX_MAILBOX_BASE, /* to be updated */
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index b0d7740..a2fa784 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -368,7 +368,7 @@ struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2420
-static struct resource omap2_mbox_resources[] = {
+static struct resource __initdata omap2_mbox_resources[] = {
 	{
 		.start		= OMAP24XX_MAILBOX_BASE,
 		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -386,7 +386,7 @@ static struct resource omap2_mbox_resources[] = {
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3430
-static struct resource omap3_mbox_resources[] = {
+static struct resource __initdata omap3_mbox_resources[] = {
 	{
 		.start		= OMAP34XX_MAILBOX_BASE,
 		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -400,7 +400,7 @@ static struct resource omap3_mbox_resources[] = {
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-static struct resource omap4_mbox_resources[] = {
+static struct resource __initdata omap4_mbox_resources[] = {
 	{
 		.start          = OMAP44XX_MAILBOX_BASE,
 		.end            = OMAP44XX_MAILBOX_BASE + OMAP4_MBOX_REG_SIZE - 1,
-- 
1.7.1

