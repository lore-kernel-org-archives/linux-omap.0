From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 11:26:43 -0800
Message-ID: <20120209192643.GL1426@atomide.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk>
 <20120209183624.GJ1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57226 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256Ab2BIT0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 14:26:54 -0500
Content-Disposition: inline
In-Reply-To: <20120209183624.GJ1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Tony Lindgren <tony@atomide.com> [120209 10:05]:
> 
> This fixes the various build and boot issues with custom .configs
> that don't select CONFIG_MACH_OMAP_GENERIC. It should fix slow serial
> console issues. And it fixes booting with DT to minimal enviroment.

Looks like the serial console is still insanely slow on 2420 both
for dmesg.

On 2430, 3430, 3630 and 4430 it seems the problem with slow
console is now fixed.

So at least one more patch is needed for the 2420 PM/serial regression.

Regards,

Tony
