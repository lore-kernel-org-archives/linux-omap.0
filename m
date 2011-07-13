From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: PM: fix watchdog boot when runtime PM is
 disabled
Date: Wed, 13 Jul 2011 01:54:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107130142470.30229@utopia.booyaka.com>
References: <1310426484-30083-1-git-send-email-khilman@ti.com> <4E1B8B47.3020904@ti.com> <878vs3v9a3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42353 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758672Ab1GMHym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 03:54:42 -0400
In-Reply-To: <878vs3v9a3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 12 Jul 2011, Kevin Hilman wrote:

> Paul's concern is valid, and could be addressed by making that init code
> actually check if the WDT is currently active (as suggested by the
> comment there.)
> 
> In the mean time, this simple fix should be applied to prevent a boot
> crash, IMO.

Thing is, applying this fix will cause crashes if the bootloader enables 
the watchdog, but the kernel does not.  It just trades one source of 
crashes for another.

The root cause of this problem is that the drivers are incorrectly relying 
on runtime PM to "enable" devices.  My personal opinion is that we should 
be doing what SSB, PCI, etc. do, and have a omap_device_enable() that is 
called by the driver.  Basically, we need a real omap_bus/omap_device.

Meanwhile, switching to lazy device reset as Tony suggested should mask 
the issue.  The patches for this are 95% done; the intention is to post 
them for early 3.2.  Or if people are really gung-ho, 3.1 rc.


- Paul
