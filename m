From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/omap2: Fix build failures
Date: Thu, 28 Feb 2013 13:51:39 -0800
Message-ID: <20130228215138.GJ1622@atomide.com>
References: <1362077583-11184-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40562 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760716Ab3B1Vvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Feb 2013 16:51:42 -0500
Content-Disposition: inline
In-Reply-To: <1362077583-11184-1-git-send-email-linux@roeck-us.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>

Hi,

* Guenter Roeck <linux@roeck-us.net> [130228 11:21]:
> Commit c1d1cd59 (omap_device: remove obsolete pm_lats and early_device code)
> changed the number of parameters to omap_device_build(), but did not fix all
> calling code correctly. This causes build failures with some configurations.
> 
> arch/arm/mach-omap2/devices.c: In function 'omap_init_hdmi_audio':
> arch/arm/mach-omap2/devices.c:429:2: error: too many arguments to function 'omap_device_build'
> arch/arm/mach-omap2/omap_device.h:74:25: note: declared here
> make[2]: [arch/arm/mach-omap2/devices.o] Error 1 (ignored)
> arch/arm/mach-omap2/sr_device.c: In function 'sr_dev_init':
> arch/arm/mach-omap2/sr_device.c:155:2: error: too many arguments to function 'omap_device_build'
> arch/arm/mach-omap2/omap_device.h:74:25: note: declared here
> make[2]: [arch/arm/mach-omap2/sr_device.o] Error 1 (ignored)
> arch/arm/mach-omap2/am35xx-emac.c: In function 'omap_davinci_emac_dev_init':
> arch/arm/mach-omap2/am35xx-emac.c:66:6: error: too many arguments to function 'omap_device_build'
> arch/arm/mach-omap2/omap_device.h:74:25: note: declared here

Thanks, we already have a fix for this in linux next as
commit 6efc3fe0 (ARM: OMAP2+: fix some omap_device_build() calls that
aren't compiled by default). It seems that it will get sent today as
part of the rest of the arm-soc late branches.

Regards,

Tony
