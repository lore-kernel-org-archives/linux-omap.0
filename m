From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Sun, 12 Oct 2008 08:21:30 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365BC66F5@dlee02.ent.ti.com>
References: <200810030857.37888.david-b@pacbell.net>
 <200810061626.33616.david-b@pacbell.net>
 <5e088bd90810112133ob4f0fa6v5bfe37aece35c98a@mail.gmail.com>
 <200810112343.02304.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52544 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbYJLNVm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Oct 2008 09:21:42 -0400
In-Reply-To: <200810112343.02304.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Steve Sakoman <sakoman@gmail.com>
Cc: Anand Gadiyar <gadiyar@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> owner@vger.kernel.org] On Behalf Of David Brownell
=20
> > Turns out it is this one in omap_start_ehc:
> >
> > =A0=A0=A0=A0=A0=A0=A0=A0/* Wait for TLL to be Active */
> > =A0=A0=A0=A0=A0=A0=A0=A0while ((cm_read_mod_reg(CORE_MOD, OMAP2430_=
CM_IDLEST3) &
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 << OMAP3430ES2_S=
T_USBTLL_SHIFT)));
>=20
> Fishy ... TLL =3D=3D TransceiverLess Link, which is used with
> on-board links that don't need to be morphed to use signals
> that go over cables as defined in the USB spec.  I would
> think you'd want ULPI.

TLL block does get used for some cases for non-tll (phy) mode use.  Rec=
ently there was some low power fixes for non-tll mode in which tll bloc=
k handling was important.  This was specifically in ohci configuration.

Anand (in copy) did make some fix which changed ordering of clock enabl=
es which were necessary to get usb bus suspend/resume working.  With th=
e other ordering you would get an abort when accessing that blocks regi=
sters.

Regards,
Richard W.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
