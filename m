From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: new PM branch available
Date: Wed, 4 Feb 2009 02:52:28 +0200
Message-ID: <20090204005228.GA30147@codecarver.research.nokia.com>
References: <87iqoij2me.fsf@deeprootsystems.com> <20090202174532.GJ4954@codecarver.research.nokia.com> <87wsc8bp79.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27708 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZBDAwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 19:52:42 -0500
Content-Disposition: inline
In-Reply-To: <87wsc8bp79.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

> Hi Peter,
> 
> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
> 
> 
> A first guess: this sounds like CONFIG_OMAP_RESET_CLOCKS=y is missing
> from your .config.
> 
> The MPU/NEON going active but not RET is an indication to me that some
> fclk is active so that the fclk check in omap3_can_sleep() fails, so a
> WFI is never attempted.  That's shy
> 

Ok. I did enable CONFIG_OMAP_RESET_CLOCKS. But with your config file
only PER and CORE did not go to retention. One difference is that I did
not enable smartreflex, but as B5 (and B4) are using OMAP3s without
proper efuse values, smartreflex shouldn't matter I assume ?

I upgrade my u-boot to the latest version, and then PER went to
retention as well. 

The only way to get core to retention was to force idle USBOTG and
disable the USBOTG driver.

Dynamic retention seems to work only once the system has been in static
retention once.

Static off mode seems to work, but resume from off kills the UART. The
system seems to run though, at least LED0 flickers as usual when the
system runs. Sometimes it hangs and I have seen one reboot.

> 
> > Which rootfs are you using, I'm using debian, so maybe something
> > keeps the CPU busy. Are you using NAND or MMC to store your rootfs ?
> 
> I'm using rootfs on MMC and have tested with busybox-only, debian and
> OE rootfs.  With debian and OE, I usually boot a minimal rootfs,
> before a full userland comes up.  With debian, I changed my
> /etc/init.d/rcS to start initlevel 1 instead of 'S'.
> 

Ok. I tried with both the small OE ramdisk image and rather minimal debian 
install. I didn't see a difference in behaviour between both.

> > And which u-boot are you using ?
> 
> I'm using the u-boot from Steve Sakoman's tree[1].  That helped a lot
> in my initial Beagle testing, but I think the kernel should reset the
> IVA and D2D now which is the domains that I was having problems with
> before, so I think that the out of the box u-boot should work fine.
> 

I upgraded to this u-boot and it resolved at least one issue. 

Cheers,

Peter.

-- 
goa is a state of mind
