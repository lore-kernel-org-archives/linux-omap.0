From: Matt Porter <mporter@ti.com>
Subject: Re: OMAP34xx
Date: Fri, 10 Feb 2012 13:31:20 -0500
Message-ID: <20120210183117.GB40045@h115-84.vpn.ti.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk>
 <20120209183624.GJ1426@atomide.com>
 <20120209193442.GA1767@rexfeany.com>
 <87hayzzjlv.fsf@ti.com>
 <alpine.DEB.2.00.1202091919200.12732@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48051 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759554Ab2BJSbj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 13:31:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202091919200.12732@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Rex Feany <rfeany@laeos.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Thu, Feb 09, 2012 at 07:19:47PM -0700, Paul Walmsley wrote:
> 
> Kevin and I just doublechecked OMAP37xx BeagleBoard xM here with Tony's 
> testing branch; it works.

Regarding the issue that Vaibhav reported with:

"omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck"

I also see it on my xM Rev. B. I went back and doublechecked 3.2.5 and
this does not occur there. Enabled EHCI+SMSC95xx support on top of
omap2plus_defconfig and that works fine for nfsroot in 3.2.5.

-Matt
