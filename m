From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: [PATCH] OMAP3 Overo: add EXPORT_SYMBOLs for Overo ASoC audio to be
	built as a module.
Date: Tue, 2 Jun 2009 13:02:09 +1200
Message-ID: <5a7b8b7b0906011802y4abc5ba6m8813d6884825e805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:55409 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbZFBBCJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 21:02:09 -0400
Received: by gxk10 with SMTP id 10so13656369gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 01 Jun 2009 18:02:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm pretty new to kernel development, so I don't know any potential
problems with doing this, but without this, audio/ASoC support must be
built into the kernel (modpost fails when trying to build as modules),
whereas with this patch, it can be built and used as a module.

Comments?

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 5f3aad9..aa3d123 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -46,6 +46,7 @@ u32 omap_ctrl_readl(u16 offset)
 {
 	return __raw_readl(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readl);

 void omap_ctrl_writeb(u8 val, u16 offset)
 {
@@ -61,4 +62,5 @@ void omap_ctrl_writel(u32 val, u16 offset)
 {
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writel);
