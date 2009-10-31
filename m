From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2/2 v2] OMAP3:clk - introduce DPLL4 jtype support
Date: Sat, 31 Oct 2009 07:35:15 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B6CDD1F@dlee02.ent.ti.com>
References: <[PATCH 2/2] OMAP3:clk: introduce DPLL4 jtype support>
 <1256068968-16564-1-git-send-email-nm@ti.com>
 <alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51439 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757711AbZJaMfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 08:35:14 -0400
In-Reply-To: <alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>

Hi Paul,

> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, October 28, 2009 9:39 PM

> > +static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
> u8 n)
> > +{
> > +   unsigned long fint, clkinp, sd; /* watch out for overflow */
> > +   int mod1, mod2;
> > +
> > +   n++; /* always n+1 below */
>
> The N that's passed into lookup_dco_sddiv() is the real N -- that is, it's
> the register bitfield plus one.  That can be seen below in this line:
>
> >     v |= (n - 1) << __ffs(dd->div1_mask);
>
> Given this, is the "n++;" above correct?

Probably not...  Actually much of the original function path (setting dpll4) is a bit suspect.  Reprogramming of PER DPLL at kernel time would seem risky.  The service provided in this function maybe should only be available at early init time. There is no notification in clock receiving drivers.  For instance an active UART would crash.

> The rest of the code looks fine.  (Of course, I can't review the
> technical basis of the code since I don't have the 3630 docs yet, but I'm
> fine with taking it in the meantime.)
>
> I might change the 'u8 jtype;' field below into 'u8 flags;'; please let me
> know if you foresee a problem with that.

Don't care.  Jtype seemed description but flag |= jtype is just as descriptive and can hold a few more.

Thanks for looking over.

Regards,
Richard W.

