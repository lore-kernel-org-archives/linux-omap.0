From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Mon, 21 Feb 2011 14:08:15 -0800
Message-ID: <20110221220815.GG15225@atomide.com>
References: <20110217171747.GC14574@legolas.emea.dhcp.ti.com>
 <4D5D59E5.6020307@ti.com>
 <20110217173711.GF14574@legolas.emea.dhcp.ti.com>
 <4D5D5F13.2010602@ti.com>
 <20110217181849.GV20795@atomide.com>
 <4D5E7DFF.7020609@ti.com>
 <20110218154135.GF11151@legolas.emea.dhcp.ti.com>
 <4D5EA36A.4000903@ti.com>
 <20110221182213.GD15225@atomide.com>
 <4D62DAF0.9050301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:37062 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1BUWIT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 17:08:19 -0500
Content-Disposition: inline
In-Reply-To: <4D62DAF0.9050301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110221 13:35]:
> On 2/21/2011 7:22 PM, Tony Lindgren wrote:
> >* Cousson, Benoit<b-cousson@ti.com>  [110218 08:49]:
> >>---
> >> From b2190f0d339c9d843eb5e370d0db8b7090fbcfab Mon Sep 17 00:00:00 2001
> >>From: Benoit Cousson<b-cousson@ti.com>
> >>Date: Fri, 18 Feb 2011 14:01:06 +0100
> >>Subject: [PATCH] OMAP4: hwmod data: Add rev and dev_attr fields in McSPI
> >>
> >>- Add a rev attribute to identify various McSPI IP version.
> >>- Add a dev_attr structure to provide the number of chipselect
> >>   supported by the instance.
> >
> >Looks like one seems to be wrapped and does not apply even after unwapping..
> 
> #$*%&!@ Thunderbird...

:) The earlier one had double spaces in the beginning of each line in
addition to the line wrapping..
 
> Here is the same one without the "enable word wrap" and attached as well just in case.
> 
> It should apply on your omap-for-linus branch at commit df7ffd3.

Thanks, I'll apply it to omap-for-linus. The omap4 hang seems to be
caused by the timer patch, the following fixes it. How do you want
to deal with fixing this issue?

Tony


--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5094,7 +5094,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_spinlock_hwmod,
 
 	/* timer class */
-	&omap44xx_timer1_hwmod,
+/*	&omap44xx_timer1_hwmod, */
 	&omap44xx_timer2_hwmod,
 	&omap44xx_timer3_hwmod,
 	&omap44xx_timer4_hwmod,
