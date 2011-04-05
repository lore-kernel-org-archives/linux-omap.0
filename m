From: Felipe Balbi <balbi@ti.com>
Subject: Re: RX-51: Platform support for lp5523
Date: Tue, 5 Apr 2011 16:02:52 +0300
Message-ID: <20110405130250.GR30505@legolas.emea.dhcp.ti.com>
References: <20110329173647.GK4016@atomide.com>
 <20110329181615.GA20371@earth.universe>
 <20110329193301.GP4016@atomide.com>
 <4D9B06C1.1080306@nokia.com>
 <20110405121911.GJ30505@legolas.emea.dhcp.ti.com>
 <4D9B09B0.9020806@nokia.com>
 <20110405123015.GM30505@legolas.emea.dhcp.ti.com>
 <4D9B0C40.8080705@nokia.com>
 <20110405123841.GN30505@legolas.emea.dhcp.ti.com>
 <4D9B1234.7040605@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53505 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752415Ab1DENCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 09:02:55 -0400
Received: by mail-ew0-f48.google.com with SMTP id 22so120303ewy.35
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 06:02:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9B1234.7040605@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: balbi@ti.com, ext Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, linux-omap@vger.kernel.org

Hi,

On Tue, Apr 05, 2011 at 03:59:32PM +0300, Ameya Palande wrote:
> On 04/05/2011 03:38 PM, ext Felipe Balbi wrote:
> >Hi,
> >
> >On Tue, Apr 05, 2011 at 03:34:08PM +0300, Ameya Palande wrote:
> >>>Exactly, adding a new feature. Let me put it this way: which bug or
> >>>regression are you fixing with this patch ?
> >>
> >>I never claimed that it is fixing a bug/regression ;)
> >
> >but you want this go into the RC cycle, which is strictly bug fixing and
> >regression fixing :-)
> 
> How about following commits since v2.6.39-rc1?
> 
> 54a93b6 ARM: pxa: PalmZ72: Add OV9640 camera support
> 54d5710 ARM: PXA: Z2: Add default triggers for LEDs
> 7780c80 arm: mach-kirkwood: add led in sheevaplug-setup.c
> 14fb20c ARM: mx53_loco: Add GPIO Keypad support
> 1b6f1e8 ARM: mxs/mx23evk: add mmc device
> 4b2a58a libceph: Create a new key type "ceph"
> 6090912 powerpc: Implement dma_mmap_coherent()
> 57bd35d microblaze: Wire up new syscalls
> beb4727 drm/radeon/kms: Add support for tv-out dongle on G5 9600
> 758f231 drm/radeon/kms: add some new ontario pci ids
> 41c5789 kernel/signal.c: add kernel-doc notation to syscalls
> 9a684e1 Documentation: consolidate leds files to leds/ subdir
> 
> I agree that rc cycle is mostly about bug/regression fixing but there
> are definitely exceptions for borderline cases and I am trying to
> check if this patch is such a case ;)

Like I said: Tony is the final judge here. :-)

But the fact that Russell has already stated the next merge window is
strictly for code consolidation already puts a stop sign in front of
this patch :-) Still, Tony is the final judge.

-- 
balbi
