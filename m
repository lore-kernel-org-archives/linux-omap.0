From: Scott Ellis <scott@jumpnowtek.com>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add max_clk_div field to
 mcspi platform config
Date: Mon, 15 Mar 2010 16:30:22 -0400
Message-ID: <1268685022.8594.130.camel@quad>
References: <1268407307.14445.51.camel@quad>
	 <20100312172148.GG2900@atomide.com> <1268587548.30878.11.camel@quad>
	 <20100315163246.GT2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:4139 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936703Ab0COUa3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Mar 2010 16:30:29 -0400
In-Reply-To: <20100315163246.GT2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

> Hmm now it looks like you're missing 3630 handling?
> 
> If the max_clk_div is 0x0f for 2420 and 2430, then you
> can just check for cpu_is_omap24xx(). If it's only
> different for 2420, then you can check for cpu_is_omap2420().
> 
> That way it should be more future proof, and you don't
> need to change it for new processors.
> 
Anand Gadiyar <gadiyar <at> ti.com> verified 0x0f for the 2430.

I think SWPU177D is the correct TRM for the omap3630 and if so then 0x0c
is the correct value.

I did not verify the omap44xx value and just assumed similar to the
omap3's. My bad.

Can you or someone point me to links for the omap2420 and the omap44xx
TRMs? I'm not having any luck finding them.

Then it can be verified whether a cpu_is_omap24xx() check is sufficient.
It probably is.

Or if someone with access to those manuals could do a quick check...

It's the max value of the MCSPI_CHxCONF.CLKD register field.




