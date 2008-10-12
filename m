From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Sun, 12 Oct 2008 10:24:14 -0700
Message-ID: <200810121024.14981.david-b@pacbell.net>
References: <200810030857.37888.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE89671620365BC66F5@dlee02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC3560870239624AC3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:24557 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754340AbYJLRYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Oct 2008 13:24:17 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870239624AC3@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Steve Sakoman <sakoman@gmail.com>, Anand Gadiyar <gadiyar@gmail.com>, linux-omap@vger.kernel.org

On Sunday 12 October 2008, Pandita, Vikram wrote:
> >> > =A0=A0=A0=A0=A0=A0=A0=A0/* Wait for TLL to be Active */
> >> > =A0=A0=A0=A0=A0=A0=A0=A0while ((cm_read_mod_reg(CORE_MOD, OMAP24=
30_CM_IDLEST3) &
> >> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 << OMAP3430ES=
2_ST_USBTLL_SHIFT)));
> >>
> >> Fishy ... TLL =3D=3D TransceiverLess Link, which is used with
> >> on-board links that don't need to be morphed to use signals
> >> that go over cables as defined in the USB spec. =A0I would
> >> think you'd want ULPI.
> >
> >TLL block does get used for some cases for non-tll (phy) mode use. =A0
>=20
> In particular, clocking mode used for EHCI on omap34xx is input clock=
ing mode.
> This means OMAP feeds the 60Mhz clock and TLL module is used to gener=
ate the 60Mhz clock.
> So irrespective of TLL or ULPI-PHY mode, TLL block has to be kept up.

OK ... I suggest a comment in the code explaining that,
so it's clear what's going on.

Along with whatever fix is needed to allow booting with
EHCI enabled again.  Something seems to be preventing
TLL from coming up now...


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
