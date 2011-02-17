From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 17:18:04 +0200
Message-ID: <20110217151804.GM22356@legolas.emea.dhcp.ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
 <1297946466-9565-7-git-send-email-balbi@ti.com>
 <4D5D25F9.8030907@ti.com>
 <20110217151527.GL22356@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54199 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862Ab1BQPSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 10:18:09 -0500
Received: by mail-ew0-f53.google.com with SMTP id 6so1090993ewy.26
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 07:18:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110217151527.GL22356@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 05:15:27PM +0200, Felipe Balbi wrote:
> On Thu, Feb 17, 2011 at 02:43:21PM +0100, Cousson, Benoit wrote:
> > Hi Felipe and Hema,
> > 
> > Sorry for this late review, but I have a couple of comments on this one.
> > 
> > Since I was planning to send usb hwmod data file to Tony directly
> > like I did for the other drivers, I can handle the update myself if
> > you want.
> 
> I'll change this particular patch to yours.

doesn't apply:

$ patch -p1 < ~/benoit.diff 
patching file arch/arm/mach-omap2/omap_hwmod_44xx_data.c
Hunk #1 succeeded at 55 with fuzz 1 (offset -7 lines).
patch: **** malformed patch at line 42: omap44xx_l4_cfg__l3_main_2 = {

could you base this off of v2.6.38-rc5 ?

-- 
balbi
