From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: OMAP3: hwmod_data: Correct clock domains for
 USB modules
Date: Fri, 11 Apr 2014 17:58:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404111755450.14347@utopia.booyaka.com>
References: <1397056615-4503-1-git-send-email-rogerq@ti.com> <1397114297-4013-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59956 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbaDKR6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 13:58:15 -0400
In-Reply-To: <1397114297-4013-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, nm@ti.com
Cc: tony@atomide.com, Keshava Munegowda <keshava_mgowda@ti.com>, Partha Basak <parthab@india.ti.com>, balbi@ti.com, linux-omap@vger.kernel.org

On Thu, 10 Apr 2014, Roger Quadros wrote:

> OMAP3 doesn't contain "l3_init_clkdm" clock domain. Use the
> proper clock domains for USB Host and USB TLL modules.
> 
> Gets rid of the following warnings during boot
>  omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
>  omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Thanks.  Looks like this was added by commit 
de231388cb80a8ef3e779bbfa0564ba0157b7377 ("ARM: OMAP: USB: EHCI and OHCI 
hwmod structures for OMAP3").  Have queued the following patch for 
v3.15-rc.


- Paul

From: Roger Quadros <rogerq@ti.com>
Date: Thu, 10 Apr 2014 10:18:17 +0300
Subject: [PATCH] ARM: OMAP3: hwmod_data: Correct clock domains for USB modules

OMAP3 doesn't contain "l3_init_clkdm" clock domain. Use the
proper clock domains for USB Host and USB TLL modules.

Gets rid of the following warnings during boot
 omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
 omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm

Reported-by: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Fixes: de231388cb80a8ef3e779bbfa0564ba0157b7377 ("ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP3")
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Partha Basak <parthab@india.ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index a123ff0070bd..71ac7d5f3385 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1964,7 +1964,7 @@ static struct omap_hwmod_irq_info omap3xxx_usb_host_hs_irqs[] = {
 static struct omap_hwmod omap3xxx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
 	.class		= &omap3xxx_usb_host_hs_hwmod_class,
-	.clkdm_name	= "l3_init_clkdm",
+	.clkdm_name	= "usbhost_clkdm",
 	.mpu_irqs	= omap3xxx_usb_host_hs_irqs,
 	.main_clk	= "usbhost_48m_fck",
 	.prcm = {
@@ -2047,7 +2047,7 @@ static struct omap_hwmod_irq_info omap3xxx_usb_tll_hs_irqs[] = {
 static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap3xxx_usb_tll_hs_hwmod_class,
-	.clkdm_name	= "l3_init_clkdm",
+	.clkdm_name	= "core_l4_clkdm",
 	.mpu_irqs	= omap3xxx_usb_tll_hs_irqs,
 	.main_clk	= "usbtll_fck",
 	.prcm = {
-- 
1.9.1

