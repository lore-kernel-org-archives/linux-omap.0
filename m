From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: usb_nop_xceiv_register() missing when OTG built as modules
Date: Wed, 26 May 2010 09:02:52 +0300
Message-ID: <20100526060252.GD3069@nokia.com>
References: <87635d54nn.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
 <87eik03scn.fsf@deeprootsystems.com>
 <20100305090426.GG12757@nokia.com>
 <871vfy3azr.fsf@deeprootsystems.com>
 <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
 <87y6i6zatj.fsf@deeprootsystems.com>
 <20100522235310.GA15859@matterhorn.lan>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47630 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab0EZGDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 02:03:18 -0400
Content-Disposition: inline
In-Reply-To: <20100522235310.GA15859@matterhorn.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, me@felipebalbi.com, felipe.balbi@nokia.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com

Hi,

On Sun, May 23, 2010 at 01:53:10AM +0200, ext Amit Kucheria wrote:
>From 3df714f995b0895e905090760482194233f66a1d Mon Sep 17 00:00:00 2001
>Message-Id: <3df714f995b0895e905090760482194233f66a1d.1274570700.git.amit.kucheria@canonical.com>
>From: Amit Kucheria <amit.kucheria@canonical.com>
>Date: Sun, 23 May 2010 01:35:00 +0300
>Subject: [PATCH] omap: remove calls to usb_nop_xceiv_register from board files
>
>This will allow the OMAP USB drivers to be compiled in as modules. At the
>moment, CONFIG_NOP_USB_XCEIV cannot be a module.
>
>Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
>---
> arch/arm/mach-omap2/board-4430sdp.c  |   10 ++++++++--
> arch/arm/mach-omap2/board-omap3evm.c |   11 ++++++++---
> 2 files changed, 16 insertions(+), 5 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
>index e4a5d66..131f0fd 100644
>--- a/arch/arm/mach-omap2/board-4430sdp.c
>+++ b/arch/arm/mach-omap2/board-4430sdp.c
>@@ -110,8 +110,16 @@ static struct platform_device sdp4430_lcd_device = {
> 	.id		= -1,
> };
> 
>+static struct platform_device sdp4430_nop_usb_device = {
>+	.name		= "nop_usb_xceiv",
>+	.id		= -1,
>+	.resource	= NULL,
>+	.num_resources	= 0,

you don't need to zero-initialize a static variable. So you can just 
drop .resource and .num_resources altogether.

-- 
balbi

DefectiveByDesign.org
