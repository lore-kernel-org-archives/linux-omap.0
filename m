From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 17:26:48 +0200
Message-ID: <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
 <1297946466-9565-7-git-send-email-balbi@ti.com>
 <4D5D25F9.8030907@ti.com>
 <20110217151527.GL22356@legolas.emea.dhcp.ti.com>
 <20110217151804.GM22356@legolas.emea.dhcp.ti.com>
 <4D5D3D0B.8090106@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:33707 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920Ab1BQP0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 10:26:55 -0500
Received: by bwz15 with SMTP id 15so2107841bwz.5
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 07:26:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5D3D0B.8090106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 04:21:47PM +0100, Cousson, Benoit wrote:
> On 2/17/2011 4:18 PM, Balbi, Felipe wrote:
> >On Thu, Feb 17, 2011 at 05:15:27PM +0200, Felipe Balbi wrote:
> >>On Thu, Feb 17, 2011 at 02:43:21PM +0100, Cousson, Benoit wrote:
> >>>Hi Felipe and Hema,
> >>>
> >>>Sorry for this late review, but I have a couple of comments on this one.
> >>>
> >>>Since I was planning to send usb hwmod data file to Tony directly
> >>>like I did for the other drivers, I can handle the update myself if
> >>>you want.
> >>
> >>I'll change this particular patch to yours.
> >
> >doesn't apply:
> >
> >$ patch -p1<  ~/benoit.diff
> >patching file arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >Hunk #1 succeeded at 55 with fuzz 1 (offset -7 lines).
> >patch: **** malformed patch at line 42: omap44xx_l4_cfg__l3_main_2 = {
> >
> >could you base this off of v2.6.38-rc5 ?
> 
> This is what I was about to say.
> You have a dependency with the for_2.6.39/omap4_hwmod_data branch
> in git://gitorious.org/omap-pm/linux.git.

I cannot have such a dependency and if you create that I can't send a
pull request to Tony otherwise we will have conflicts later. Either you
clear up that dependency or Tony will have to manually apply the patches
I have queued. It's only 7 of them anyway, so maybe not a big deal.

Tony, what do you prefer ? Do we clear out the dependency, or you queue
all the patches I have manually ??

A simple way to clear this out would be with a git rebase -i v2.6.38-rc5
and moving the MUSB HWMOD to be the first one in the series, then it
should apply cleanly on my tree.

-- 
balbi
