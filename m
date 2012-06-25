From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Mon, 25 Jun 2012 15:30:59 +0300
Message-ID: <1340627459.3395.54.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-HtSxqepw5ykP22mwMOex"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:54923 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752126Ab2FYMay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 08:30:54 -0400
Received: by lbbgj3 with SMTP id gj3so5631639lbb.25
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 05:30:51 -0700 (PDT)
In-Reply-To: <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-HtSxqepw5ykP22mwMOex
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 15:05 +0300, Grazvydas Ignotas wrote:
> On Mon, Jun 25, 2012 at 9:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
> >>
> >>  Currenlty HDMI fails to come up in the suspend-resume path.
> >> This patch helps that real-world scenario.
> >
> > What is the problem there? It'd be good to explain the problem in the
> > patch description. Does the pm_runtime_get return -EACCES?
>=20
> On slightly different but related issue, currently OMAPDSS always
> spits lots of backtraces when it's compiled without CONFIG_PM_RUNTIME,
> because pm_runtime_put* always return -ENOSYS without
> CONFIG_PM_RUNTIME. So something like this patch proposes is needed, or
> maybe WARN_ON should check for -ENOSYS, I don't know..

Hmm. I guess I'm missing some understanding about runtime PM. omapdss
uses runtime PM to enable the underlying DSS hardware. If there's no
runtime PM, how does the driver work? Or is it the job of
hwmod/omap_device to keep all the hardware always enabled if runtime PM
is not compiled in?

 Tomi


--=-HtSxqepw5ykP22mwMOex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6FoDAAoJEPo9qoy8lh71XEgP/2mReCuXJha9NkPJWciOinNV
WeKabcp+Rbjtlw1Jgn4Brys11r/KVTppVw7BaixR+qay0NCj2fSPZswll0xVEqOF
9BiYpgM7UjE4XeP57Q+3mFjdxB0BAHfRaljWhtKn7hi/9PJErwJr+7rCkNzrzoH3
HfP3hzsF5S4WwpOWptXi1u7ROwjIH7c/KTv7PtufDKDeupfneqK/BBsySRZPNTJV
xNvZzjTY33qoDuMKGl/xMG+Vl52eSSicqM+y+M9ZQPTo7uF62Q0GkS7LG//K6/vp
DuAO3ThsBGgUdASQYP6dGjy0NiOGRXVlEMNXBIvm8bD75pEn+4nWYVmJQbnlKDBa
ySembMrKKDb6JpVuEpZxbnLtX+tuIS0ZYqbzxVwyguvJA+tW3dC2ZMmA6uyUyKvl
IlizPF2aEV+9qFijCDa01JxD/plFrU45OHEKCNGx+LWYG1HgYvUCii+bjXVoqQto
oadhrC2l6O7Pq161EQWXHbr73j5anCaOwME+q6eRtZV0ODrlmTywDcpJpM90yl/E
sioZ5rSuIPsfyEIUzR9c4v7DgkaAVdAsmyfobO1wZJ9AjI/SZarTZ+YKuExeJrK/
XHJh/30s8m2EtNRP7uiUCGNIo9QRrO96SGnUHn/HoiTkefoBClg9/gJhfUAdEm0R
NMu4UiO+YsTIaSyvLJo2
=cWRn
-----END PGP SIGNATURE-----

--=-HtSxqepw5ykP22mwMOex--

