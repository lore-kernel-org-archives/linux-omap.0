From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 18:22:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202091821220.5059@utopia.booyaka.com>
References: <20120208231551.GA9009@kroah.com> <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com> <20120209004731.GA11343@kroah.com> <4F3374F0.3080002@bitmer.com> <20120209133739.GB2590@sirena.org.uk> <20120209183624.GJ1426@atomide.com>
 <20120209192643.GL1426@atomide.com> <alpine.DEB.2.00.1202091326500.6698@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53355 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235Ab2BJBWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 20:22:07 -0500
In-Reply-To: <alpine.DEB.2.00.1202091326500.6698@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Thu, 9 Feb 2012, Paul Walmsley wrote:

> Yeah, that one is PM related.  If mach-omap2/pm24xx.c is hacked to only 
> enter MPU retention, rather than full chip retention, it works (quick hack 
> below).  I suspect it is due to the lack of wakeup support in OMAP2 PM, 
> but of course it could be something else.

Tony and I tracked this one down to some old pm24xx.c code - patch 
forthcoming shortly.


- Paul
