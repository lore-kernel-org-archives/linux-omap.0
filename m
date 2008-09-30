From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 00/23] twl4030 patches (v4)
Date: Tue, 30 Sep 2008 20:37:11 +0300
Message-ID: <20080930173710.GN2445@frodo>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com> <20080930130511.GB15828@atomide.com> <5e088bd90809300926j6a980b92r71a5c2b215d9f104@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49777 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbYI3RhV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 13:37:21 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809300926j6a980b92r71a5c2b215d9f104@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>

On Tue, Sep 30, 2008 at 09:26:09AM -0700, Steve Sakoman wrote:
> On Tue, Sep 30, 2008 at 6:05 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Let's plan on applying these tomorrow unless there are more comments.
> 
> I'm seeing some issues on Overo when applying these patches.
> 
> On a cold boot everything proceeds normally (including devices being
> enumerated on the musb channel) until the kernel attempts to mount the
> rootfs from mmc.  At that point boot messages stop:
> 
> mmc0: new high speed SD card at address 55ce
> mmcblk0: mmc0:55ce SD02G 1921024KiB
>  mmcblk0:<7>mmc0: starting CMD18 arg 00000000 flags 000000b5
>  p1 p2
> 
> At first I thought mmc support was broken and the system was hung.
> But after a 10 - 20 second delay I noticed that approximately every 10
> seconds I get the following message:
> 
> musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 000a
> 
> After a few cycles of this the boot continues and completes normally,
> but the musb port is now non-functional.
> 
> If I do a reboot command or press the reset button, the overo reboots
> without the above delays or error messages, however the musb port is
> non-functional.
> 
> It seems that something has gone awry in the twl4030 usb section,
> since I get a functional system without these patches.  Any
> suggestions as to where I should begin looking to help debug this?

remove the devices you have attached to musb port for now. musb
shouldn't prevent these patches from being applied. As I said before,
musb otg-host mode is not quite ok for omap3.

I'm pretty sure we're gonna have a lot to patch in order to get it in
good shape. A few patches are already coming from mainline btw.

-- 
balbi
