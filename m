From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
Date: Tue, 10 Apr 2012 12:24:43 +0300
Message-ID: <20120410092441.GB20616@arwen.pp.htv.fi>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:52322 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752741Ab2DJJZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 05:25:40 -0400
Received: by lagz14 with SMTP id z14so4126024lag.28
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 02:25:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
> +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
> +						u32 offset, u32 value)
> +{
> +	return __raw_writel(value, keypad_data->base + offset);
> +}
> +
> +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
> +						u32 offset, u32 value)
> +{
> +	return __raw_writel(value, keypad_data->base + offset);
> +}

if this only writes to irqenable, why do you pass offset as an argument?
likewise for irqstatus.

--=20
balbi

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPg/xZAAoJEIaOsuA1yqREkGQQAIQ+bn9O1dc/0Tjzw0HoA+di
zgMAKonY84IJRSGC3UaKkKZPpMJL/YTu94+WYidRJp5B/7XBMeMLxbNyHmST2Xps
+ArFtU9snRQpCS7cKE/l7oopRhFf1zjlRRSz1iJ1QobtMu/hLoODDPD1wjqP4mUM
jpAmJgkvK4autjGCmpcOlG51AuIBM+/bJGW2mHF7/y/nJ9e2TL+04pCByhJ/Dz2W
wjPiRBQWfaSa4CfO5wI/o0pMxNdVAfDDkmZv3EeVciQr+jJr7ahlgNf6nhQ6uPUK
/UMZIE2xBu1DCy8Ex73PE5O4lpfLScbBNaiBwuBVdIjPc/Ioz1hmSGMpDubjuwhJ
sUsrFdhWArgY8UAdaLMEzxBBL6ChV6ZaYXFFSFfuqMyGJRNpLWYxGED41thK0gLk
flVTm2e42nATWuag1mQ1okc3kzL4n0QgibsOqnt9VMfyc8pSnM8j5cpfvtIYJ5l/
gdqdX1ET5OukgwMPMtsoyorqMHgrfbBLXLChp5V2tD9Z0uJVV8MSAyjSb8dL33dP
Uyt6sgoVs1WMD8D4OL33v4mE0tHWxrzWYUegp32h6BYL56LpUhzKK50tw9AAqtCf
TvEbZVqyYgAqC/9nY+5liJumkNy5xQ07AgVFqKJ/IZEkGaafP0XcmXKKHdhUSPgV
gIJSr4tQpRPZa4C/v5Q4
=S9fg
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
