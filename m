From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Mon, 1 Jun 2015 21:26:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506012122050.14902@utopia.booyaka.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com> <1433172627-28052-1-git-send-email-t-kristo@ti.com> <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com> <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <20150601180429.GA30984@atomide.com> <20150601180658.GB30984@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57838 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbbFAV0C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 17:26:02 -0400
In-Reply-To: <20150601180658.GB30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jeroen Hofstee <linux-arm@myspectrum.nl>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 1 Jun 2015, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [150601 11:06]:
> > * Paul Walmsley <paul@pwsan.com> [150601 10:45]:
> > > 
> > > See for example the "Build warnings from toolchain", "Kernel warnings 
> > > during boot to userspace", "Kernel warnings during PM test", and "Obsolete 
> > > Kconfig symbols" sections here:
> > > 
> > > http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/README.txt
> > 
> > OK somehow 3517evm is listed under "skip" there? 
> 
> Oh I see you have two 3517 devices there, never mind.
> 
> Hmm now I'm wondering what the panda es warnings listed there are..

http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/boot/4430es2panda/4430es2panda_log.txt

Looked to me like an OMAP4430 ES2.2 bug.  I recall discussing it with 
someone with an ES2.3 Pandaboard and they said it didn't show up.  So I 
asked TI at the time if there was an erratum for it; apparently not.  So I 
think we may need to add in another hardware bug workaround flag to the 
OMAP integration code...

- Paul
