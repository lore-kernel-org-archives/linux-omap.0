From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Thu, 9 Sep 2010 20:58:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD17EDFA@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <87fwxjx7qj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47141 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab0IIP2I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 11:28:08 -0400
In-Reply-To: <87fwxjx7qj.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, September 09, 2010 8:52 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH 0/7] omap4: Fixes, hacks for es2.0
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
> > This series has few fixes, hacks to get omap4 es2.0 working
> > on mainline. The patches are generated against the mainline
> > 2.6.36-rc3.
> 
> Hi Santosh, thanks for this...
> 
> > The series is boot tested tested on 4430 SDP, Blaze with
> > omap_4430sdp_defconfig with file over NFS and MMC.
> >
> > Also boot tested omap3_defconfig with ramdisk on OMAP4 and OMAP3
> > SDPs. Same observation with Panda
> >
> > With omap3_defconfig, MMC while mounting the rootfs over MMC, the
> > boot hangs. Same observation with Panda
> 
> On my ES2.0 Panda, rootfs on MMC is now working with this series.
>
I observed the same with MMC. Ramdisk boot worked for me on PANDA.
 
> However, rootfs over NFS is not yet working, presumably because the
> OMAP4 EHCI support is needed for the USB-attached smsc95xx to work
> properly.
>
This is correct. We need to get the MMC fixed o.w panda is unusable in
it's current form.
 
> 
> > [    5.794616] regulator_init_complete: incomplete constraints, leaving
> VUSIM on
> > [    5.802764] regulator_init_complete: incomplete constraints, leaving
> VPP on
> > [    5.816131] twl_rtc twl_rtc: setting system clock to 2000-01-01
> 00:53:12 UTC (9      )
> > [    5.849304] mmc0: new high speed MMC card at address 0001
> > [    5.856323] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> > [    5.862091]  mmcblk0: unknown partition table
> > [    6.325500] omap_device: mmci-omap-hs.1: new worst case deactivate
> latency 0: 6
> 
> Based on this message, this is not a mainline kernel, but one where the
> omap_device conversion for MMC has been applied.
> 
This is mainline 2.6.36-rc3.... 
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=shortlog;h=refs/heads/omap4-for-tony



