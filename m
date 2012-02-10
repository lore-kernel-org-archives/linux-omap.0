From: Matt Porter <mporter@ti.com>
Subject: Re: OMAP34xx
Date: Fri, 10 Feb 2012 09:37:36 -0500
Message-ID: <20120210143733.GA40045@h115-84.vpn.ti.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk>
 <20120209183624.GJ1426@atomide.com>
 <20120209193442.GA1767@rexfeany.com>
 <87hayzzjlv.fsf@ti.com>
 <alpine.DEB.2.00.1202091919200.12732@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A8317C957F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34567 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193Ab2BJOiC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 09:38:02 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317C957F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, Rex Feany <rfeany@laeos.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Fri, Feb 10, 2012 at 07:10:06AM +0000, Hiremath, Vaibhav wrote:
> On Fri, Feb 10, 2012 at 07:49:47, Paul Walmsley wrote:
> > 
> > Kevin and I just doublechecked OMAP37xx BeagleBoard xM here with Tony's 
> > testing branch; it works.
> > 
> 
> I tried it on AM37x EVM, it did worked for me but I have some observations,

...

> 2) Missing clockdomain in usb clock -
> 
> [root@arago /]# dmesg | grep -ir hwmod
> [    0.114868] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
> ...

I also see this on am37x evm, am35x evm, craneboard, and xM Rev B with an
omap2plus_defconfig build from the testing-omap-fixes branch.

> 3)  Not sure how this can be handled, since from TWL regulator output
> perspective it is NA. I enabled DUMMY_REGILATOR option and tried it,
> it works.
> 
> 
> [root@arago /]# dmesg | grep -ir fail
> [    0.166717] dpll3_m2_clk rate change failed: -22
> [    0.828521] sharp_ls_panel display0: failed to set lcd brightness
> [    1.672454] smsc911x smsc911x.0: Failed to get supply 'vdd33a': -19

I posted a patch to address the smsc911x issue. It's a board specific
fixed regulator that's controlled via a TWL GPIO but defaults to on.

See [PATCH] omap: board-omap3evm: add required smsc911x regulators

-Matt
