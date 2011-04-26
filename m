From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Tue, 26 Apr 2011 00:29:41 -0700
Message-ID: <20110426072941.GA3755@atomide.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
 <20110419062633.GA15620@atomide.com>
 <87r58w4gq3.fsf@ti.com>
 <20110421054221.GF5918@atomide.com>
 <BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53011 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757630Ab1DZH3t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Apr 2011 03:29:49 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>

* Linus Walleij <linus.walleij@linaro.org> [110423 01:32]:
> 2011/4/21 Tony Lindgren <tony@atomide.com>:
> > * Kevin Hilman <khilman@ti.com> [110421 02:56]:
>=20
> >> > - Move it to drivers/gpio
> >> >
> >> > - Further consolidate with whatever common GPIO code might
> >> > =C2=A0 be coming up.
> >>
> >> Is the above order required?
> >
> > Yes please. Otherwise we'll have more of the "crazy churn" in
> > arch/arm/*omap*/ and the runtime PM patches should apply easily
> > in drivers/gpio too.
>=20
> Since you'll probably be dependent on stuff happening in my patches
> to move stuff into drivers/gpio I'll be happy to carry the patches in=
 my
> gpio-consolidation branch with Tony's ACKs if need be.

Sounds good to me.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
