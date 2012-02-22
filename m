From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 12:01:18 +0200
Message-ID: <CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com>
References: <20120222085130.GE22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41103 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab2BVKBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 05:01:38 -0500
Received: by iacb35 with SMTP id b35so10114565iac.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 02:01:38 -0800 (PST)
In-Reply-To: <20120222085130.GE22675@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Anna, Suman" <s-anna@ti.com>

+ Tony, Suman

On Wed, Feb 22, 2012 at 10:51 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> arch/arm/mach-omap2/mailbox.c: In function 'omap2_mbox_probe':
> arch/arm/mach-omap2/mailbox.c:354: error: 'omap2_mboxes' undeclared (first use in this function)
> arch/arm/mach-omap2/mailbox.c:354: error: (Each undeclared identifier is reported only once
> arch/arm/mach-omap2/mailbox.c:354: error: for each function it appears in.)

The below should trivially solve this, but I wonder if there was any
other merit in explicitly using CONFIG_SOC_OMAP2420 there (any
different between 2420 and 2430 in that respect ?).

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 609ea2d..e61d275 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -258,7 +258,7 @@ struct omap_mbox mbox_dsp_info = {
 struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
 #endif

-#if defined(CONFIG_SOC_OMAP2420)
+#if defined(CONFIG_ARCH_OMAP2)
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
