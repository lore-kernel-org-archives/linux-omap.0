From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH/RFC 0/7] Remove the omapdrm device from platform code
Date: Thu, 15 Dec 2016 10:08:47 +0200
Message-ID: <88473bd0-0273-3d80-2249-e3ec0d1ee928@ti.com>
References: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161214150506.GV4920@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0592892265=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20161214150506.GV4920@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============0592892265==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uTuooMu8xQ1d8XULuR9x3QM3iNcRGSBKh"

--uTuooMu8xQ1d8XULuR9x3QM3iNcRGSBKh
Content-Type: multipart/mixed; boundary="6kvxEqVnMhoUX4srFPehkp2EIV5lkEsv2";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Message-ID: <88473bd0-0273-3d80-2249-e3ec0d1ee928@ti.com>
Subject: Re: [PATCH/RFC 0/7] Remove the omapdrm device from platform code
References: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161214150506.GV4920@atomide.com>
In-Reply-To: <20161214150506.GV4920@atomide.com>

--6kvxEqVnMhoUX4srFPehkp2EIV5lkEsv2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/12/16 17:05, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [161213 15:38]:
>> The series will be annoying to merge given how interleaved the ARM and=
 driver
>> patches are. The easiest solution would be to merge everything through=
 the ARM
>> tree (as the risk of conflict on the DRM side is low), in which case s=
ome=20
>> patches could be squashed together if desired (especially the last two=
 that
>> wouldn't require renaming the driver internally anymore).
>=20
> Maybe Tomi can set up an immutable branch once the patches have been re=
viewed?
> That way also I can merge it in too as needed.

Yes, I think that's a good option. Then the series doesn't have to be so
artificially split into linux-omap and drm parts.

I don't think there are much chances with conflicts on the linux-omap
side, as the only files touched are display.c and drm.c (well, and a
small change in Makefile).

I like the series in general, but I still need to go through it in detail=
=2E

And speaking of removing of platform data...

Tony, the only big reason we still have the omapdss platform data
(include/linux/platform_data/omapdss.h) is the omapdss_version, which is
based on the OMAP SoC version.

We need that in the driver, as the DSS IP revision hasn't been updated
in a couple of cases, or the issue comes from outside DSS. But there are
only a few of these cases, mostly we would do just fine with the DSS IP
revision.

What do you think of a scheme, where we'd drop the platform data, but at
early platform init code we would inject a DT property or two into DSS's
DT data in those problematic cases?

Or do you have any other ideas how to pass flags to the driver based on
the SoC revision?

 Tomi


--6kvxEqVnMhoUX4srFPehkp2EIV5lkEsv2--

--uTuooMu8xQ1d8XULuR9x3QM3iNcRGSBKh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUk+PAAoJEPo9qoy8lh716w4P/26Gnba6zXAnW3+XPajTiYdd
EO8bYY5NwjGFZ7RpmLIasICzD4AE2dYos7O9I7wlfrL8z9o4ZWv/j4hwMNZYnUu7
Ui2ZrrPGL+r9v6hvSgiCdYNOLJ+i9CyA7lGjueZXaKvFn/638ayFRdke3rGBFdeV
rZxaO1FztopPNlGQfBdqAgG/LP8OqRyPBoSPpW4sj0896LxGuWPTeUlIWFsFgJFU
GkwGw0Jy4/LHC611+9gnmDTwOEnQ2yj0KL+MYfjsaTq1hAUv2KepRw6loQk7VHFj
T+Me8QOdUo66fX3np7rcVn5NdZttivwIWXidYhw/H6FyJ9phjKsU2ipsQS+5IxX6
uoG19lDJWJ94KJgHxF67mBTnnkbuSDZHmx/8pY8KVd69/F9SH0xSbvLbt1G7sh8a
dGohH1g0Zmoe71/WMkqB3T95IEppOeyx3K/EI2tMFl4riHIiip5f9ucX9jxRYF6G
UwaUGEgNCn5zQV8iB6fPl+RTbzDSpklB0vdjxJ7SHquQM2KYU8BNUDFCZBVaO2UW
vLY8+Co9abBBOMqFa3pNxLm4r/5u12T2JlcZpuxd1ezC7RkHlahy2EnSG3a+0H+8
kT1wzKMENO4glFbHxDSzFebISwNJru6iHK7Om9hGxoWeHUs5VZz+DDqes81K7o7x
o4fFf4RUIXx7fazgdkls
=WZan
-----END PGP SIGNATURE-----

--uTuooMu8xQ1d8XULuR9x3QM3iNcRGSBKh--

--===============0592892265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0592892265==--
