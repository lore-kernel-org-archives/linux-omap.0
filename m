From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] HTC Herald various device support
Date: Mon, 2 Aug 2010 13:54:34 +0300
Message-ID: <20100802105434.GC12293@atomide.com>
References: <1279598741-18607-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54953 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab0HBKyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 06:54:09 -0400
Content-Disposition: inline
In-Reply-To: <1279598741-18607-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [100720 06:59]:
> This patch set is an updated version of a series of patches I submitted
> a while ago.  It's built against the latest linux-omap master branch, and
> removes all defconfig updates.  Other comments were put in place as well.
> 
> This patch set implements the following drivers and support for them into
> the HTC Herald:
> 
>  * MMC card support
>  * I2C and HTCPLD drivers
>  * TSC2046 touchscreen support
>  * Serial port fixes for omap7xx
>  * Bluetooth common code for HTC omap7xx smartphones
> 
> The bluetooth drivers are implemented with the expectation that they will
> be used by other devices once the board files are submitted (Elf/Elfin,
> Opal, etc).
> 
> Cory Maccarrone (7):
>   [OMAP] gpio: Allow for extended GPIO space
>   [OMAP] Add allowance for extra IRQ space

Let's drop these two for now, they will get solved in a generic way
hopefully quite soon.

>   [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related devices
>   [OMAP] htcherald: SPI register config, TSC2046 touchscreen
>   [omap1] omap7xx clocks, mux, serial fixes
>   [omap1] Bluetooth device code common to HTC smartphones
>   [htcherald] Add board support for UARTs, bluetooth

Please repost these one more time with linux-arm-kernel list Cc'd.
If no comments, we may be able to get these still into the current
merge window.

Sorry for the delay, I've been offline for past few weeks :)

Regards,

Tony
