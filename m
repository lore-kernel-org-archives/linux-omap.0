From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V3 2/6] ARM: AM43xx: fix dpll init in bypass mode
Date: Fri, 11 Apr 2014 18:24:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404111823350.14347@utopia.booyaka.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com> <1395658916-9032-3-git-send-email-sathyap@ti.com> <5343CA69.1070209@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60226 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaDKSYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 14:24:15 -0400
In-Reply-To: <5343CA69.1070209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, linux-omap@vger.kernel.org

Hi Tomi.

On Tue, 8 Apr 2014, Tomi Valkeinen wrote:

> On 24/03/14 13:01, Sathya Prakash M R wrote:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > On AM43xx, if a PLL is in bypass at kernel init, the code in
> > omap2_get_dpll_rate() will not realize this and will try to calculate
> > the clock rate using the multiplier and the divider, resulting in
> > errors.
> > 
> > omap2_init_dpll_parent() has similar issue.
> > 
> > Add the missing soc_is_am43xx() check to make the code work on AM43xx.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> > ---
> >  arch/arm/mach-omap2/clkt_dpll.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Can you queue this for 3.15 fixes?

Done.  Thanks for pointing it out - I had missed the repost due to not 
being in the Cc:.


- Paul
