From: Scott Ellis <scott@jumpnowtek.com>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add max_clk_div field to
 mcspi platform config
Date: Fri, 19 Mar 2010 15:46:31 -0400
Message-ID: <1269027991.586.63.camel@quad>
References: <1268407307.14445.51.camel@quad>
	 <20100312172148.GG2900@atomide.com> <1268587548.30878.11.camel@quad>
	 <20100315163246.GT2900@atomide.com> <1268685022.8594.130.camel@quad>
	 <20100315210236.GE2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:3475 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab0CSTqi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 15:46:38 -0400
In-Reply-To: <20100315210236.GE2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: TonyLindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

> Only 3430 and 3630 TRMs says 0xd, 0xe, 0xf = Division not supported.
> 
I tested a 3503 with clock divider values of 0x0d, 0x0e and 0x0f.
It worked fine.
I collected data off the SPI bus successfully at the expected
frequencies of 5859 Hz, 2929 Hz and 1464 Hz.

> But then again, the TRMs can have errors.
> 
Looks like this is a case of that. 

My patches #2 and #3 are unnecessary then and #4 makes use of a new 
field added in #3.

I can resubmit #4, "Use transfer speed_hz if provided". That was the 
original problem I was working on. 

Should I leave the hard-coded 0x0f in the code or would you prefer a
named constant?



