From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 13:37:40 +0000
Message-ID: <20120209133739.GB2590@sirena.org.uk>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:40031 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2BINhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 08:37:50 -0500
Content-Disposition: inline
In-Reply-To: <4F3374F0.3080002@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Thu, Feb 09, 2012 at 09:25:36AM +0200, Jarkko Nikula wrote:
> On 02/09/2012 02:47 AM, Greg KH wrote:
> > Show me an OMAP user that actually runs a mainline kernel :)

> I guess pretty much all these days? Most error reports what I recall
> seeing during past 2-3 years are from mainline kernel and not that much
> from linux-omap or some board support package kernel.

Most of the other guys are going in via the TI support channels rather
than asking on the public lists I expect (and remember that even if
people are basing their code on mainline the chances are they've still
got a bunch of out of tree changes on top for their own boards if
they're not directly using one of the reference boards).
