From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Mon, 18 Jun 2012 13:54:25 +0300
Message-ID: <1340016865.4012.10.camel@deskari>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340007094.1859.3.camel@lappyti>
	 <CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-t+xkm+SrWiKJhobBPCZn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38766 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914Ab2FRKyb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 06:54:31 -0400
Received: by laai10 with SMTP id i10so3432074laa.41
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 03:54:28 -0700 (PDT)
In-Reply-To: <CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-t+xkm+SrWiKJhobBPCZn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-18 at 15:42 +0530, Jassi Brar wrote:
> On 18 June 2012 13:41, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >>
> >> Explicitly maintaining HDMI phy power state using a flag is prone to
> >> race and un-necessary when we have a zero-cost alternative of checking
> >> the state before trying to set it.
> >
> > Why would reading the value from the register be any less racy than
> > keeping it in memory?
> >
> Racy in the sense that h/w doesn't always hop states according to what
> a "state" variable would expect it to.

But I don't think the status register is any better. If I'm not
mistaken, when you set the phy pwr to, say, TXON, the status register
will still show the old value. The status register will be right only
after the HW is actually at TXON state.

In this case the hdmi_set_phy_pwr() function will anyway wait until the
HW has changed states, so both approaches should work just fine.

> Also in this case, phy_tx_enabled modification is unprotected in
> ti_hdmi_4xxx_phy_disable().

So is hdmi_set_phy_pwr(). Note that I'm not saying the current approach
is not racy, but your patch doesn't make it any less racy.

> BTW, coming to think about it, I am not sure what we need the
> spin_lock_irqsave() protection for in hdmi_check_hpd_state() ?  It
> can't control HPD gpio state change and hdmi_set_phy_pwr() seems too
> expensive and is already unprotected elsewhere.

It's needed when enabling the hdmi output. In phy_enable() the irq is
requested first, and then the phy_enable() runs hdmi_check_hpd_state().
So there's a chance to run hdmi_check_hpd_state() from both
hpd-interrupt and phy_enable() at the same time.

The hdmi_set_phy_pwr() is not called in many places, but I think there's
indeed a problem there. It is called after free_irq(), but I think
(guess) the irq handler could still be running after free_irq. So those
should be protected by the same spinlock too.

 Tomi


--=-t+xkm+SrWiKJhobBPCZn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP3wjhAAoJEPo9qoy8lh71ObkP/RqK5vmIH4OWdU1HCtpUhwwV
Hem+disIXLPMxPHhxFZICEBua+OtTFqQeZCdLXG4Vhl3wZa7Igs+ByhSXhsd8aM5
zlsoSQnfToGWuWtWnWni7ICKZeb0SIUe9YLkK542+1WayOKgZ8fiaUhoyX208Ggb
NDyVaKKo+BBP0L5EhGrqrHX63e/H42e38M9CQDFI86w/eBlL80I8MrBHWGb+krOo
1iJBjC7Ez7y8K9X0FNOx+/sa0GZiLYGTWtUklCWw3fGwPPIseKC1ljR222nc5uCY
aMR0oMNc8StPvzAK7bEP0uVNO2EDcJl0FQvEBEUsCORKonfhHiP1iZDyEMhNJRo7
PI9T9zHYHIzZPt9Oh8AdiJLxJbY4NY78PlcpvqNi4/ckilaUcrW3vc1hxfMpQGPE
9IIH6bOc40h8Aa7NOSt9oecklhZniRPHeFDjIvYpyoGFBUwexXVDT0yYKF4eibEC
838l8Jma3+r3ztC6r5lI8X7v0wghDT9DDdP8Pxu6Sv23uN9zM0tVeN+yhgU1g8pl
rBjyenhp/4YueJBiaOhGJcZls5ntVDvWR3vX3wOVmLMJ9Yg7pMOPmOvgeRJ571Zi
Su0qGtMBvkTzKYbaRABYkxEo7uP6a1qed7qrgNGU2J+cP04qpq6fMumKhuRjUTu/
AarlpvtM+7Fs+9BcrdMx
=UUPQ
-----END PGP SIGNATURE-----

--=-t+xkm+SrWiKJhobBPCZn--

