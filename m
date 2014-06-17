From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock
Date: Tue, 17 Jun 2014 14:08:39 -0700
Message-ID: <20140617210839.32686.27704@quantum>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com>
 <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
 <539FF81E.2020606@ti.com>
 <alpine.DEB.2.02.1406170815460.31106@utopia.booyaka.com>
 <539FFB03.6070407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:59901 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964856AbaFQVex convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 17:34:53 -0400
Received: by mail-pb0-f54.google.com with SMTP id un15so3047149pbc.13
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 14:34:53 -0700 (PDT)
In-Reply-To: <539FFB03.6070407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

Quoting Tero Kristo (2014-06-17 01:23:31)
> On 06/17/2014 11:19 AM, Paul Walmsley wrote:
> > On Tue, 17 Jun 2014, Tero Kristo wrote:
> >
> >> I am fine with this approach, as it seems pretty much all the other mux-clock
> >> users are setting this flag also. The TI clocks have had this way of using mux
> >> clocks from the legacy times... might just be a design flaw.
> >
> > The non-CCF clock framework never automatically switched parents on rate
> > changes, AFAIK.
> 
> That might be true yea, so this must have been introduced with CCF.

Correct, which is why the flag exists.

> 
> > The only case that approached this was with PLLs.  PLLs would
> > automatically be placed into bypass if the PLL rate was set to the bypass
> > rate.
> 
> Someone could argue that this is rather strange approach also and would 
> be better to use some other API for the purpose.

I have always liked this feature. I had a hack patch on the list a long
time ago for testing bypass mode on the OMAP4 MPU when set to 400MHZ or
something like that (and chained from dpll_core I think...).

The point is to get the rate you ask for when you call clk_set_rate. The
method by which the PLL achieves that rate isn't really important, so
long as you have glitchless clocks (which OMAP's PRCM does).

Regards,
Mike

> 
> .Tero
> 
