From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 09/11] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
Date: Mon, 18 Jun 2012 11:41:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206070108540.6684@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061313.25532.84569.stgit@dusk> <4FD04C8D.50609@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51613 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2FRRlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 13:41:50 -0400
In-Reply-To: <4FD04C8D.50609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

On Thu, 7 Jun 2012, Rajendra Nayak wrote:

> On Thursday 07 June 2012 11:43 AM, Paul Walmsley wrote:
> > Until the OMAP4 code is converted to disable the use of the clock
> > framework-based clockdomain enable/disable sequence, any clock used as
> > a hwmod main_clk must have a clockdomain associated with it.  This
> > patch populates some clock structure clockdomain names to resolve the
> > following warnings during kernel init:
> 
> But these associations are useless if the clock is not a 'gate' clock, 
> except for getting rid of these warnings. Maybe we should make hwmod 
> understand that not all clocks need to have a clockdomain associated 
> with it and stop complaining.

In retrospect, I think I should have made clockdomains mandatory for all 
clocks for OMAP4 back then, rather than only allowing them for some 
clocks.  As I understand it, that would have saved a lot of time and 
debugging frustration on the bug fixed by commit 
6c4a057bffe9823221eab547e11fac181dc18a2b ("ARM: OMAP4: clock data: Force a 
DPLL clkdm/pwrdm ON before a relock").  Oh well.


- Paul
