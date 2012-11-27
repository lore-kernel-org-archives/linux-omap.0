From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Tue, 27 Nov 2012 13:32:39 +0200
Message-ID: <50B4A4D7.2070203@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com> <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6414DEAEEC75ADB15EBF9E91"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36859 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755271Ab2K0Lco (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 06:32:44 -0500
In-Reply-To: <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enig6414DEAEEC75ADB15EBF9E91
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-23 17:20, Steve Sakoman wrote:
> On Fri, Nov 23, 2012 at 12:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>=20
>=20
>> Ok, so hmm... So the overlay is disabled, and the paddr is zero. Can y=
ou
>> put a printk at dss/apply.c:dss_olv_set_info, and print ovl->id and
>> info->paddr? And perhaps also to omapfb-main.c:omapfb_setup_overlay, a=
t
>> the point where it sets info.paddr, as I think that's the only place
>> where omapfb sets paddr.
>=20
> OK, did that and here is what I get when starting up gdm, prior to
> that all is normal
>=20
> root@omap3-multi:~# systemctl start gdm.service
> Starting Gnome Display Manager...
> Started Gnome Display Manager                                          =
[  OK  ]
> root@omap3-multi:~# [   83.475128] omapfb_setup_plane entry
> [   83.479492] setup_overlay 0, posx 0, posy 0, outw 1024, outh 768
> [   83.485809] omapfb_setup_overlay: setting info.paddr =3D 9f400000
> [   83.492431] dss_ovl_set_info entry
> [   83.496307]     ovl->id =3D 0
> [   83.499267]     info->paddr =3D 9f400000
> [   83.503601] omapfb_setup_plane: return success
> [   83.508697] omapfb_setup_plane entry
> [   83.513153] dss_ovl_set_info entry
> [   83.516723]     ovl->id =3D 2
> [   83.520111]     info->paddr =3D 0
> [   83.523406] omapdss OVERLAY error: check_overlay: paddr cannot be 0
> [   83.530426] omapfb_setup_plane: !pi->enabled & ovl->set_overlay_info=

> [   83.537414] dss_ovl_set_info entry
> [   83.540985]     ovl->id =3D 2
> [   83.544250]     info->paddr =3D 0
> [   83.547546] omapdss OVERLAY error: check_overlay: paddr cannot be 0
>=20
> <repeats  as X dies and restarts>
>=20
>> I don't know what's going on there, why the paddr is suddenly zero.
>> Looking at the log from Enric, SETUP_PLANE works fine just fine, and
>> then, for no reason, next SETUP_PLANE fails, and the log doesn't show
>> anything much happening between.
>>
>> However, I think omapdss may have been more permissive in the past,
>> allowing paddr 0 if the overlay is disabled. I could add that back, bu=
t
>> I'd rather first understand what's happening here.
>=20
> From the above it seems that the first SETUP_PLANE is for ovl->id =3D 0=

> and then those that fail are for ovl->id =3D2.
>=20
> No idea what is going on in user space, but maybe this will mean
> something to you :-)

Ok. So X is configuring video2 overlay for some reason. XVideo, perhaps?

Anyway, I guess it's a valid thing to configure the overlay with
paddr =3D=3D 0 when the overlay is disabled. In fact, paddr =3D=3D 0 chec=
k=20
is in any case quite limited, as if the board's physical memory
doesn't contain the given paddr, the DSS HW will fail just as it=20
would for paddr 0. So the paddr =3D=3D 0 check is more of a sanity check
than a comprehensive test.

Can you try the following patch:

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/=
overlay.c
index 45f4994..e271e28 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -130,11 +130,6 @@ void dss_uninit_overlays(struct platform_device *pde=
v)
 int dss_ovl_simple_check(struct omap_overlay *ovl,
 		const struct omap_overlay_info *info)
 {
-	if (info->paddr =3D=3D 0) {
-		DSSERR("check_overlay: paddr cannot be 0\n");
-		return -EINVAL;
-	}
-
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) =3D=3D 0) {
 		if (info->out_width !=3D 0 && info->width !=3D info->out_width) {
 			DSSERR("check_overlay: overlay %d doesn't support "


 Tomi



--------------enig6414DEAEEC75ADB15EBF9E91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQtKTXAAoJEPo9qoy8lh718MQQAK4sXQHw05hKySx+59OiB3+7
AYKE/OnC35Gy0Z5FIsqrFYUTRNP3Ot8UgRw+A6DvzqTEp/GxqyfXJ1ADa4ETg+ez
3onpmZOX1WKKi3ywXJPEzgXpkTzOHkB91nvUYv4R0/ZvKMl0HyLM91XTPkOKI+Ny
eb+Eo2zEnewrqgK+ScC2CJSEDFX6s5z5fu3hAEuW4ZRTINmXoho6Cyw08fvLPMc8
Sfb+dtE8lRGKWwtVHo9i02QDFhhIC4ryco7WjNBRg32cujcSWDjIHp7sGFurXGd8
Nwy0YI8Zn5jdlrVIaB/wt3oQxeGl6SG6UBL9S8JqwPC0hD+sLk5rtmnEayiqIsaK
BX6oF7rnF0uRqUfUYV5U5cb84I9k4cnxWn0nivTVC44gU5Pb3l7YofE5R1fm2q0K
Xj1EM1eCGM+ratz7a94L8jaqJKmiD4F+E+nQZsd2y6TX6TCA2vDvJSD5FdgPOV2V
kymKtJT7drfL1qxwnrU3nw6DnKBnA59sfQOdrIVJPw8/aau2G7kAS00n8x8Am2qM
PeZssVzmxuyllbABbkoQFn3OKnMCx7pycmY88jT8EJROC/k0HKHgFt+VQJNOX84T
ssbvIPkRw+YQBUESl/GkQUbfUgiPQO8IpocxMovKB8chrH+PKKvhwx8hocNXfJ1C
yd111f6BSvC6g8bWvGLV
=HDvS
-----END PGP SIGNATURE-----

--------------enig6414DEAEEC75ADB15EBF9E91--
