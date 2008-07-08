From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean
 up SDRC
Date: Tue, 8 Jul 2008 17:46:52 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807081730590.12684@utopia.booyaka.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain> <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com> <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162035BD67429@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44454 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbYGHXqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 19:46:53 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BD67429@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 'Igor Stoppa' <igor.stoppa@nokia.com>

On Tue, 8 Jul 2008, Woodruff, Richard wrote:

> > > SRAM being mapped as cacheable could be a possible reason for this.
> 
> Second this.

Yeah, agreed that it needs to be done, but SRAM in CDP 12.17 is still 
marked cacheable too, right?  Did CORE M2 divider changes work in CDP 
12.17?

Also still curious why, if it's the cache line eviction issue, it only 
locks up on the low- to high-speed transition.

> Can you ping the board by chance when you are locked?  Is only user 
> space locked out or is the board dead. The SRAM thing resulted in a dead 
> lock where MPU was done.

The board doesn't respond to pings.


- Paul
