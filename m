From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Mon, 19 Dec 2011 10:31:15 +0200
Message-ID: <1324283475.1903.28.camel@deskari>
References: <1323755818-17901-1-git-send-email-mythripk@ti.com>
	 <1323755818-17901-2-git-send-email-mythripk@ti.com>
	 <1323766081.1877.21.camel@deskari>
	 <CAP5A+B-+SXzGOvY_51v32iHEC7vO0OMbfVMGR+TK3FGH3DkJpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-mnazYFsFbrvTX1MXGdlP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:44970 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751034Ab1LSIvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 03:51:32 -0500
Received: by lagu2 with SMTP id u2so2126554lag.9
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 00:51:29 -0800 (PST)
In-Reply-To: <CAP5A+B-+SXzGOvY_51v32iHEC7vO0OMbfVMGR+TK3FGH3DkJpA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-mnazYFsFbrvTX1MXGdlP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-12-19 at 13:56 +0530, K, Mythri P wrote:
> >> +     /*
> >> +      * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
> >> +      * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
> >> +      * internal pull up resistor - This is a change needed in
> >> +      * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze Boards as
> the
> >> +      * external pull up are present. This is needed to avoid
> >> +      * EDID read failure.
> >> +      */
> >
> Well CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
> HDMI_DDC_SCL_PULLUPRESX (bit 24) are marked as reserved bits in TRM
> and hence dont feature there so wanted to add to make clear as to what
> these bits mean, I can remove.=20

It is fine to have the comments (and even good, if they are indeed not
mentioned in the TRM). My point was that the comments are in the wrong
place. You are not writing the bits in the board file, where the
comments are. You are writing the bits in display.c, which is where the
comments should be.

So in the board file you should have comment about the pull up without
the exact bit details, like I gave the example:

> "OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and later have
> external pull up on the HDMI I2C lines."

And in the display.c you can give details about the bits, if required.

 Tomi


--=-mnazYFsFbrvTX1MXGdlP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO7vZTAAoJEPo9qoy8lh71mJ0QAJ6kMHjREQ4vnBkka5puQTeC
URKKHMqdmI1xJzm5y6L1pvf8eqSUyOcvuiIOm9y6wM4Gp++CYmQPyUv4300R+qYF
v8pp83yDVaal0r0ljgDS3AqodKLZAFT4XYbIaHSZ1ItwHpFGRTaPsKxfzeUQIK7m
hJoWLZatt8UGwWVb9PS1kPcCwseLC4YEosRZCi70/S7wcCpQvoTHtOlGmEfQDcrE
fBjWieOlVVRW6ncZTCogBgduY/hkK1v9fLWaBi2fDIANdRHLLoUGNHO8AOOfA8GD
3UyB/rW7dA/ziKDfuLr4rsi5lkhr0lTSJPf6VUuVU/NAcCcXnbDUewL49HrdZsJ2
r9sfS72AIw0iIml6SHRE3jtZUzhjv4cGT8+IP5CCjA9+8LrmTj0YQYkW8ktZSbyI
E3pNDdno94C+WLk1cqrpyifLDmwZfFVzgpFs9SMQu0R1KLeSDBZwDYQgH9PTe6Hb
BANsSJVjY3C0XI3G+VSKBP1g1mwRQOZE0tKeYqBIfXEOvwkDe7kRUttdpKLYFRBP
iCMO7Eq6Y2mIOOH/gYCxmHV+V+dY8aaMqJKUu3+a26NNiTiQCLLruoJjBP8dxuuZ
T5W3tI/cLBUlqEiwBYK2UMjbSLGFhOj7s+FFiYmuy2eXx2rd09uLUT3aOcj7/hwa
bl/+ewB4l3s8HPJeQMYR
=gUnz
-----END PGP SIGNATURE-----

--=-mnazYFsFbrvTX1MXGdlP--

