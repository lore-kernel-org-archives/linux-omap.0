From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM set
Date: Fri, 30 Oct 2009 00:47:17 +0100
Message-ID: <200910300047.20049.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:46961 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122AbZJ2XsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 19:48:17 -0400
In-Reply-To: <200910292339.48610.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, Paul Walmsley <paul@pwsan.com>

Thursday 29 October 2009 23:39:44 Janusz Krzysztofik napisa=C5=82(a):
>
> Since PM area is quite new to me, I am not sure if there may be a bet=
ter
> solution. AFAICS, the standard way to prevent an ARM_CLKCT1 bit being

s/ARM_CLKCT1/ARM_IDLECT1/

> switched to idle is to enable a clock that uses it (tipb_ck, dma_ck, =
or
> tc_ck or one of its children in this case, right?).

Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
