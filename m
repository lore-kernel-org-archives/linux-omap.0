From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM branch updated
Date: Tue, 30 Jun 2009 18:31:32 -0700
Message-ID: <87ocs51957.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:33180 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbZGABbe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jun 2009 21:31:34 -0400
Received: by pxi28 with SMTP id 28so477178pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2009 18:31:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I just pushed an updated PM branch to my linux-omap-pm repo[1], and it
will be sync'd to Tony's linux-omap tree shortly.

What's changed: Not many functional changes, but lots of restructuring
to organize/regroup patches into changesets for upstream.  In addition
to the various fixes coming in from the list, here are some other
user-visible changes:

- 600 MHz OPP (a.k.a. overdrive) allowed in CPUfreq
- default CPUfreq governor: userspace, so default OPP is determined
  by bootloader, and not changed during kernel boot
- UARTs obey /sys/devices/.../power/wakeup
- serial ports separated so each port can be controlled
  separately under /sys/devices

Basic retention/off while idle and suspend testing on the following
OMAP3 boards: 

- 3430SDP (NFS root)
- OMAP3EVM (NFS root)
- Beagle (MMC rootfs)
- RX51 (OneNAND rootfs)
- Overo (Water + Tobi)  (thanks to Gumstix for the hardware!)
  ** Known problems: retention during idle eventually hangs with what
     looks like memory corruption (not debugged further.)  Looks like
     Overo support in linux-omap needs some updates, including a 
     sanity check of the SDRC settings.

Upcoming changes:

The next PM branch will drop the current omapdev code and replace it
with the latest versions of omap_hwmod and omap_device code from Paul
Walmsely.

Kevin


