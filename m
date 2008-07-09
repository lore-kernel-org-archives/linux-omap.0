From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean up SDRC
Date: Wed, 9 Jul 2008 10:12:03 +0530
Message-ID: <03bf01c8e17e$2364da00$68bf18ac@ent.ti.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain> <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com> <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162035BD67429@dlee02.ent.ti.com> <alpine.DEB.1.00.0807081730590.12684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:46662 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbYGIEmT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 00:42:19 -0400
In-Reply-To: <alpine.DEB.1.00.0807081730590.12684@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>, "'Woodruff, Richard'" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org, 'Igor Stoppa' <igor.stoppa@nokia.com>

 

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Wednesday, July 09, 2008 5:17 AM
> To: Woodruff, Richard
> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org; 'Igor Stoppa'
> Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 
> divider, clean up SDRC
> 
> On Tue, 8 Jul 2008, Woodruff, Richard wrote:
> 
> > > > SRAM being mapped as cacheable could be a possible 
> reason for this.
> > 
> > Second this.
> 
> Yeah, agreed that it needs to be done, but SRAM in CDP 12.17 is still 
> marked cacheable too, right?  Did CORE M2 divider changes work in CDP 
> 12.17?
> 
> Also still curious why, if it's the cache line eviction 
> issue, it only 
> locks up on the low- to high-speed transition.

While we saw the issues due to cache line eviction, I remember it used 
to pop up both during a low-to-high and high-to-low transitions.
If you are seeing this only during a low-to-high, it probably could be something else.

> 
> > Can you ping the board by chance when you are locked?  Is only user 
> > space locked out or is the board dead. The SRAM thing 
> resulted in a dead 
> > lock where MPU was done.
> 
> The board doesn't respond to pings.
> 
> 
> - Paul
> 

