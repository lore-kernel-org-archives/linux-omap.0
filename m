From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.8 -> 3.9-rc1 upgrade: old configs broken
Date: Mon, 4 Mar 2013 16:35:28 -0800
Message-ID: <20130305003527.GK1622@atomide.com>
References: <20130304232252.GA14552@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42575 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932575Ab3CEAfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 19:35:31 -0500
Content-Disposition: inline
In-Reply-To: <20130304232252.GA14552@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130304 15:26]:
> Hi,
> 
> How should I upgrade my .config files when upgrading to 3.9-rc1?
> 
> So far I have been doing it like this:
> 
> 	cp <old config from previous kernel release> .config
> 	make ARCH=arm oldnoconfig
> 	<compile>
> 
> But now I see that none of my boards boot up... Except OMAP1 (well, after
> fixing the build issues). I believe this is because ARCH_MULTIPLATFORM
> changes. I can always redo my configs with menuconfig, it's a PITA job...
> 
> So I guess .config files are not supposed to be upwards compatible?

Well in this case you need to update your config files by adding
the following manually to your .config:

CONFIG_ARCH_MULTIPLATFORM=y
CONFIG_ARCH_MULTI_V7=y
CONFIG_ARCH_OMAP2PLUS=y

And maybe also:

CONFIG_ARCH_MULTI_V6=y

That's because after the multiplatform Kconfig changes we cannot
select omap2+ automatically as that would not be nice for the
other arm architectures.

Then if using uImage, you need to define LOADADDR in the
environment when building. Or run mkimage manually.

Regards,

Tony
