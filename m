From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Fri, 14 Jun 2013 02:57:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306140257270.5514@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com> <20130612174842.GQ8164@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52621 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab3FNC5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 22:57:47 -0400
In-Reply-To: <20130612174842.GQ8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 12 Jun 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130610 00:27]:
>
> > * 37xx EVM: boot fails
> >   - as of v3.10-rc1
> >   - Cause unknown
> 
> This one is probably because of broken GPIO numbering in
> the board file that uses hardcoded GPIOs for what are probably
> twl GPIOs.
> 
> Does commenting out omap3_evm_display_init() in the board file
> fix the booting for you?

Lokesh's patch fixes it here.


- Paul
