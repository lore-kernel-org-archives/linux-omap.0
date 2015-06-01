From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Mon, 1 Jun 2015 10:31:27 -0700
Message-ID: <20150601173126.GY30984@atomide.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55103 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695AbbFARba (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 13:31:30 -0400
Content-Disposition: inline
In-Reply-To: <556C8ED5.5050000@myspectrum.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jeroen Hofstee <linux-arm@myspectrum.nl>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

* Jeroen Hofstee <linux-arm@myspectrum.nl> [150601 09:58]:
> Hello Tero,
> 
> On 01-06-15 17:30, Tero Kristo wrote:
> >New system control module layout for omap3 overlooked parts of the am35xx
> >configuration. Basically the am35xx clocks were not converted to use the
> >changed offsets, which caused weird boot warnings. The errors were not
> >fatal so far, so they were not caught earlier. Fixed by applying the
> >proper offsets for the AM35xx scm clocks.
> >
> >Fixes: b8845074cf ("ARM: dts: omap3: add minimal l4 bus layout with...")
> >
> >Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >Reported-by: Jeroen Hofstee <linux-arm@myspectrum.nl>
> >Cc: Paul Walmsley <paul@pwsan.com>
> >Cc: Tony Lindgren <tony@atomide.com>
> >---
> >  arch/arm/boot/dts/am35xx-clocks.dtsi |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> With this patch the error interrupt / stack dumps are no longer present.
> 
> Thanks,
> 
> Tested-by: Jeroen Hofstee <jeroen@myspectrum.nl>

Thanks, I'm suprised this was not caught earlier with all the automated
boot testing going on?

Anyways, applying into omap-for-v4.1/fixes.

Regards,

Tony
