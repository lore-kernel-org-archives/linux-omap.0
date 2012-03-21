From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] usb: musb: fix some runtime_pm issues
Date: Wed, 21 Mar 2012 12:10:15 +0200
Message-ID: <20120321101014.GN3092@arwen.pp.htv.fi>
References: <1328377432-13563-1-git-send-email-notasas@gmail.com>
 <1328377432-13563-2-git-send-email-notasas@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYfJCIN5rqlfy3K0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:56699 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278Ab2CUKKf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 06:10:35 -0400
Received: by mail-lb0-f179.google.com with SMTP id gn12so702707lbb.10
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 03:10:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1328377432-13563-2-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>


--WYfJCIN5rqlfy3K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 04, 2012 at 07:43:51PM +0200, Grazvydas Ignotas wrote:
> When runtime_pm was originally added, it was done in rather confusing
> way: omap2430_musb_init() (called from musb_init_controller) would do
> runtime_pm_get_sync() and musb_init_controller() itself would do
> runtime_pm_put to balance it out. This is not only confusing but also
> wrong if non-omap2430 glue layer is used.
>=20
> This confusion resulted in commit 772aed45b604 "usb: musb: fix
> pm_runtime mismatch", that removed runtime_pm_put() from
> musb_init_controller as that looked unbalanced, and also happened to
> fix unrelated isp1704_charger crash. However this broke runtime PM
> functionality (musb is now always powered, even without gadget active).
>=20
> Avoid these confusing runtime pm dependences by making
> musb_init_controller() and omap2430_musb_init() do their own runtime
> get/put pairs; also cover error paths. Remove unneeded runtime_pm_put
> in omap2430_remove too. isp1704_charger crash that motivated
> 772aed45b604 will be fixed by following patch.
>=20
> Cc: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

applied, thanks

--=20
balbi

--WYfJCIN5rqlfy3K0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaakFAAoJEIaOsuA1yqREW/MQAKPQO5pAlIhULmbF0H09KMeR
kYNbitij7hcvJ6ap/YWpDFfDMpIj3KJa67K4+QiI8F0HJiUheun9hY91IMaZOonN
3JRP0NCBTeOACkmMH97iq3UkjdwxRXhv4SZBs2YEJBTRJ/HMvXzJoSRaJrlF004i
cerIo1euhWFL2BnsGvg6H/AG29SubikBlcpsuofB1dJSlOn7wYJQCUWB3nr+wUqa
Wyw9mAW+uWHWVyik6UQGceR/wT9kcoLaiBjIGLN6nT8LoPwsrW1rXGTIJ570NQER
ISO8KsBgjN4NJmBDnGY26NwevaF0DfJpQBkFDACkd/UuJhKbWkUe1bUJcwr8hlbs
hnleEXNvvxQQTUkf8wAgb++p5p79Hu38+Hl1+71v6N4+Y5y3NkBwaml+XH1yYPiR
T/z9vpT1mv2V4xAShcMKt4Dq4BEwkHWRHjVS8RL9vsoKxWq9KpWVu9+lBhFldQrJ
GFEPReCq6lHc6INBp83MXMxUb3OGoM81yDqubSFgfkz9FUM/C3g4IHycxxku0R1d
+ZdxPGSfsOmGi6VbZLUyy2/xB9kfhB1fkJRzdxhQWZTAGvGVk4mSVMicyxMXtpa4
ZuGJIRKuahDMncfgw7wedO9uoVoSp18kU5zHb18v+Tt35DtmB2EEqlZmDnyU5AXe
7TOTlYvUqkNHMzI9HLyU
=kHwe
-----END PGP SIGNATURE-----

--WYfJCIN5rqlfy3K0--
