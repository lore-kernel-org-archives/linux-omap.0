From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAPDSS: remove dispc's dependency to VENC/HDMI
Date: Tue, 27 Aug 2013 14:16:22 +0300
Message-ID: <521C8A86.8020306@ti.com>
References: <20130827012016.GE17061@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ioSxHtW6E7IDpPWplMn00SJALvA5G0LxG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40314 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137Ab3H0LQZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Aug 2013 07:16:25 -0400
In-Reply-To: <20130827012016.GE17061@elgon.mountain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-omap@vger.kernel.org

--ioSxHtW6E7IDpPWplMn00SJALvA5G0LxG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/08/13 04:20, Dan Carpenter wrote:
> Hello Tomi Valkeinen,
>=20
> This is a semi-automatic email about new static checker warnings.
>=20
> The patch 5391e87d1259: "OMAPDSS: remove dispc's dependency to=20
> VENC/HDMI" from May 16, 2013, leads to the following Smatch complaint:
>=20
> drivers/video/omap2/dss/hdmi.c:672 omapdss_hdmi_display_set_timing()
> 	 error: we previously assumed 't' could be null (see line 669)
>=20
> drivers/video/omap2/dss/hdmi.c
>    668		t =3D hdmi_get_timings();
>    669		if (t !=3D NULL)
>                     ^^^^^^^^^
> Existing check.
>=20
>    670			hdmi.ip_data.cfg =3D *t;
>    671=09
>    672		dispc_set_tv_pclk(t->timings.pixel_clock * 1000);
>                                   ^^^^^^^^^^^^^^^^^^^^^^
> Patch added a dereference.
>=20
>    673=09
>    674		mutex_unlock(&hdmi.lock);
>=20

Thanks. I've made a fix, below.

 Tomi

commit 70218db3effca57252625042a2b2c740fd3604ba (HEAD, work/fixes)
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Tue Aug 27 14:11:48 2013 +0300

    OMAPDSS: HDMI: Fix possible NULL reference
   =20
    Commit 5391e87d1259 (OMAPDSS: remove dispc's dependency to VENC/HDMI)=

    introduced a possible NULL reference bug in the HDMI driver when sett=
ing
    timings. In practice the bug shouldn't happen, as the timings have be=
en
    verified earlier, and thus the timings should always be ok.
   =20
    Fix the possible issue by moving the use of the timings pointer insid=
e
    the NULL check.
   =20
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
index 44a885b..ea97854 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -666,10 +666,11 @@ void omapdss_hdmi_display_set_timing(struct omap_ds=
s_device *dssdev,
 	hdmi.ip_data.cfg.cm =3D cm;
=20
 	t =3D hdmi_get_timings();
-	if (t !=3D NULL)
+	if (t !=3D NULL) {
 		hdmi.ip_data.cfg =3D *t;
=20
-	dispc_set_tv_pclk(t->timings.pixel_clock * 1000);
+		dispc_set_tv_pclk(t->timings.pixel_clock * 1000);
+	}
=20
 	mutex_unlock(&hdmi.lock);
 }



--ioSxHtW6E7IDpPWplMn00SJALvA5G0LxG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSHIqGAAoJEPo9qoy8lh71ngwP/0NS+yauoDP0oCXINzcD14KG
aQFwOBb6xLQpeGdwPUlVFhUcVpQ7dba6aLr/Ih/WiNscm9AyMz0DnCWIp/5FLj4C
axPVpoTfrerh/C83rnhitU1LpjOW4EqBig6j1CS0Gil6uTJ00HZw8a2NMr/YqdQJ
FDs3ajoA+kUdaI+/HHWHHR29cPdEbPUeOkL0ivXRwBbcVpABKWDzGtcjXKpoUMQ1
FtEetSAy7GuzeXc/q/IJLRG6rhu58In9zbYqnCg1CAGjuM87Z2EcDD2FWI3iQ5Ru
14wgWf7k+qoudxE+DegSfW72JQSmX+3rYs012K0c+htNJ9LS0hEYAuUQdjhFLZpU
bgodIFyzDciJtvHg8It3DlP+UFBg5rc2KooBM0pMjVygPhO95Em/rAPN4j51x+zk
Okg8/sXHq2gzqbgmtzahfUxmWqW2moEdJlHJ11nNOlxHpzM1aB3g0eGbfJO2q5wt
I0/EMkmm7MQZf+G+CnB/EcE8PDLzInM3+QpA8o67olEKc3nzDoRMohQB88xixTsL
lcBldzT4ePZNLuyavU2gA832tisH71Z+LGgWK3SIsvge4SNvKTRAHEnxoX4NARi4
roFvTHAhF07DCjWjXPPDJFfAw6gl99nlT9FtlPxrQqNIJNbVHWK6vJIHLK6TSZ7M
r3oR2EbndzmLEXlN1MhM
=Y/im
-----END PGP SIGNATURE-----

--ioSxHtW6E7IDpPWplMn00SJALvA5G0LxG--
