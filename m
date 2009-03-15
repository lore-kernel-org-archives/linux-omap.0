From: David Brownell <david-b@pacbell.net>
Subject: Re: Overo broken after recent mainline merge
Date: Sun, 15 Mar 2009 16:16:50 -0700
Message-ID: <200903151616.50940.david-b@pacbell.net>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com> <200903141900.08727.david-b@pacbell.net> <5e088bd90903151256v554ee5edwbf36d2ebc29add03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:24646 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754162AbZCOXQx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Mar 2009 19:16:53 -0400
In-Reply-To: <5e088bd90903151256v554ee5edwbf36d2ebc29add03@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Sunday 15 March 2009, Steve Sakoman wrote:
> +=A0=A0=A0=A0=A0=A0=A0/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> +=A0=A0=A0=A0=A0=A0=A0mmc[0].gpio_cd =3D gpio + 0;
>=20
> Overo, having a microSD slot, doesn't have a card detect switch. The
> other part of your patch sets gpio_cd properly:

Hmm, the board I have seems to work fine with those lines.

microSD slots can support card detect just fine ... but
I think you're probably right that those lines should
be removed.

I recall testing microSD card detect with that board:
eject after loading kernel, bootm, and verify the kernel
waits politely for re-insert.

But I tried that just now, and it doesn't work.  Odd.

Can you resend an updated patch with your s-o-b?

- Dave
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
