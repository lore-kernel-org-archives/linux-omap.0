From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Sat, 11 Oct 2008 23:43:02 -0700
Message-ID: <200810112343.02304.david-b@pacbell.net>
References: <200810030857.37888.david-b@pacbell.net> <200810061626.33616.david-b@pacbell.net> <5e088bd90810112133ob4f0fa6v5bfe37aece35c98a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:39320 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751035AbYJLGnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Oct 2008 02:43:06 -0400
In-Reply-To: <5e088bd90810112133ob4f0fa6v5bfe37aece35c98a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Anand Gadiyar <gadiyar@gmail.com>, linux-omap@vger.kernel.org

On Saturday 11 October 2008, Steve Sakoman wrote:
> I put timeouts in all of the infinite loops to see which one was the =
culprit.
>=20
> Turns out it is this one in omap_start_ehc:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0/* Wait for TLL to be Active */
> =A0=A0=A0=A0=A0=A0=A0=A0while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM=
_IDLEST3) &
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 << OMAP3430ES2_ST_=
USBTLL_SHIFT)));

=46ishy ... TLL =3D=3D TransceiverLess Link, which is used with
on-board links that don't need to be morphed to use signals
that go over cables as defined in the USB spec.  I would
think you'd want ULPI.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
