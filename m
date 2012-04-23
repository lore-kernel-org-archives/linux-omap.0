From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock
 usage
Date: Mon, 23 Apr 2012 09:19:13 +0300
Message-ID: <1335161953.1668.11.camel@lappy>
References: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
	 <1334928673-27943-1-git-send-email-cmahapatra@ti.com>
	 <1334932153.2058.40.camel@deskari>
	 <CAF0AtAu6xhQmQZLbW9keTMjcSfPwsVUoWa7e4fsSpHXms+pVSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-N/+jUjOHZrWSO1pPjcIS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39048 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753780Ab2DWGTU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 02:19:20 -0400
Received: by lboi15 with SMTP id i15so6282625lbo.18
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 23:19:17 -0700 (PDT)
In-Reply-To: <CAF0AtAu6xhQmQZLbW9keTMjcSfPwsVUoWa7e4fsSpHXms+pVSQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-N/+jUjOHZrWSO1pPjcIS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-04-23 at 10:05 +0530, Mahapatra, Chandrabhanu wrote:
> On Fri, Apr 20, 2012 at 7:59 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:

> > The patch is now otherwise fine, but I think it needs some more
> > renaming. Now the code mixes fclk and core-clk names, which is rather
> > confusing. I guess the calc_fclk should actually be calc_req_core_clk?
> > And the fclk variable core_clk (or cclk or something)?
> >
> >  Tomi
> >
>=20
> As per TRM dispc_core_clk is also a functional clock, so I think above
> code should be fine. But, to avoid confusion of names the renaming of
> fclk, calc_fclk and calc_fclk_five_taps can be done.

Well, that is true is a sense, if you consider a "functional clock"
something that is used to drive some function of the HW. But then we
could also call the pixel clock a functional clock, as it also drives
some functionality. And true, TRM seems to refer to the core clock as
"dispc internal functional clock" at times.

But in this case, looking at the clock tree, DISPC_FCLK is the clock
coming to DISPC, which is then divided by the logic clock divisor to get
the logic clock (or core clock, or DISPC internal functional clock). And
I think the TRM, at least the OMAP2/3 versions, mostly speak of the
DISPC_FCLK as the functional clock, and that's what the driver also has
meant with "functional clock".

So to avoid any confusion, I'd suggest renaming them. At least I don't
see any benefit in having multiple clocks called "functional clock" for
dispc...

That said, I wonder if the DISPC_FCLK, LCD1_CLK and LCD2_CLK are used at
all before they are divided with the logic clock divider. If they are
not, then it could make sense to speak of the logic clock as the
functional clock, and call the incoming clocks something else.

But for the time being, I think we should continue calling the internal
fclk as core-clock.

 Tomi


--=-N/+jUjOHZrWSO1pPjcIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPlPRbAAoJEPo9qoy8lh71De0P/jvzNialBA/G/0ElDLQwL8qF
MJbBMZY1QFrOxmdXuVarJ957pNAaBtidEmudTDKkNIzQxWKuBSBjSto23Ie9bxP7
+lwbw4zI04aI2NRUzRNeMEIt3WDMMdp3YgJZ9CIlmK4MsHXOlE6XrbuCLofh92+a
mbpxEaRp4yhk/K+HY+tZueAzG1IoLD6PoIq69rs6aM8qgW8tCvS+aLr0jCrCsR5/
Le2hlcSdIF9n9l91e8/L7N6sJLPE4905hfIU6gctnhvqYCncVGkWzLprPfOEeMpf
Z/9vWe3fPFZfGriehndnTM9+h+RdUXDNTMcODubyE2LYeGkNII3QeSgMYP3yeEPY
2eHuFFrIMQjsULIwf/7w5QVTAQk66WyTzocsjAlxdeFoMaxLqvdm59uFY/uv+CrA
NknwMOZm2WjP9Ffbg0rOGMis94k6I3F//P5kFlOEXtRnaz7d5ppAilxjmsTJJ7ef
K4CUFUSupxBGGNPHjzDgmZk25JtV8Hcep3dHyNRUpafHsiHzc8jGa98P1eQmtn9k
YXcUvhOgaJEaFp69HEc2yN87I7Px4hcFo4s2cnYC25a4UmeGAXpjhrMVAeO7xhQz
hzlYKgJ28xXvuIYciRgNsJ+m1hLLfhJl17N/I6jMMfmzlgaxgjr7kVAuotP5SImx
KLkQx6KTDWc83KjGaEQU
=g+Jg
-----END PGP SIGNATURE-----

--=-N/+jUjOHZrWSO1pPjcIS--

