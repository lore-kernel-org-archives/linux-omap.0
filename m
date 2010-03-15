From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add max_clk_div field to
 mcspi platform config
Date: Mon, 15 Mar 2010 20:03:51 +0200
Message-ID: <20100315180351.GB3857@gandalf>
References: <1268407307.14445.51.camel@quad>
 <20100312172148.GG2900@atomide.com>
 <1268587548.30878.11.camel@quad>
 <20100315163246.GT2900@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35984 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933721Ab0COSDl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 14:03:41 -0400
Content-Disposition: inline
In-Reply-To: <20100315163246.GT2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Scott Ellis <scott@jumpnowtek.com>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,
 
On Mon, Mar 15, 2010 at 09:32:46AM -0700, Tony Lindgren wrote:
> Hmm now it looks like you're missing 3630 handling?

a bit unrelated but Tony, would you mind looking at patches splitting
devices.c into something like dev34xx.c dev24xx.c and dev44xx.c ??

personally I think we should have mach-omap3 and mach-omap4 directories
but that would be too intrusive IMO.

-- 
balbi
