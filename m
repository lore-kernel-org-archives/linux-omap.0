From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 14:38:02 +0300
Message-ID: <1340883482.5037.56.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	 <1340878461.5037.30.camel@deskari>
	 <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	 <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	 <1340881815.5037.53.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mVJuAyXTB5LDRl9NfFon"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:36312 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772Ab2F1LiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 07:38:07 -0400
Received: by lbbgm6 with SMTP id gm6so3336090lbb.5
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 04:38:04 -0700 (PDT)
In-Reply-To: <1340881815.5037.53.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org


--=-mVJuAyXTB5LDRl9NfFon
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 14:10 +0300, Tomi Valkeinen wrote:
> On Thu, 2012-06-28 at 16:28 +0530, Jassi Brar wrote:

> > Sorry a correction. Reading detect() won't work. I suggest we keep HPD
> > IRQ enabled for the lifetime of the driver.
>=20
> Ok, I see. But that's not acceptable. It would require us to keep the
> TPD12S015 always powered and enabled. Even if you're not interested in
> using HDMI at all.

Btw, a bigger problem that I see is how we have to do read_edid() (and
detect(), if I recall correctly): we enable the whole video pipeline and
output. We should only enable enough of the HW to be able to read the
EDID or read the HPD GPIO.

I've noticed that this leads to sync losts quite easily, as we switch
the hdmi output on and off quickly multiple times. I couldn't figure out
why the sync losts happen though, and I did try quite many different
combinations how to handle it.

 Tomi


--=-mVJuAyXTB5LDRl9NfFon
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7EIaAAoJEPo9qoy8lh71YZoP+gNzbJlEBGNB3yd2agBG50dA
b98Y1TComZ4LNiiw7YuJZTOODHM5zS9s+VWv/SftNfGpWJ/Hdvg0fKTBS6jfxalk
u8kFNCRGWCiqWGv3XVo+gijfPeq07anfRFY5+gajzUT1k1KlItYuAGGK76t0wmJr
3u/ugzx9NHZ9fVKDp4nPgbsmNMllpVH8niOhas0LwNJ3dB54MOX6fqwdr8Szf6Yh
X0bTewf5Zm6NuqTj8k35HYEwwy4MezbdrmNaF9InrFXyUl3+IKkLI8qiBVWsSofN
j65cbn7n55ChTWDdnxkgaMAuovry+Sbr9t4PGkDahTHE3BleUazc0/54mFLT/9bB
rByV6Mq0G8z4/f01NwVRxwEOBG+TZpX0HfTn7xHZNj4uVr4Ia2hqyROC7o8f9lk2
pjtWVUOeT/XWbpWPR3feY63R3efSsPDzXIKcQOfJ0lkmG6k++ec55Gu12gs1JIIN
vyQPH1cVaJ2GwFr/+abDrIrNEHfMbfjlDgyci/+OEBrPZVqO+HrieybyfvHo1TUy
8nygx536BgcuIXQ/4USJEMEdJ7nf2f0qj1poCASPeYJcKq+yBKzY3AEB85WoezJq
i45eH3cJ7rOsb537zYaubBtPs6TU1EPf5vh1ujBy6Z2W0xTu4TtJguw26LjbznkY
BUEV4kMqCjiFKQMkkzRy
=oN6g
-----END PGP SIGNATURE-----

--=-mVJuAyXTB5LDRl9NfFon--

