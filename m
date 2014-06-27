From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 14/15] OMAPDSS: HDMI: remove the unused code
Date: Fri, 27 Jun 2014 13:16:37 +0300
Message-ID: <53AD4485.3070506@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com> <1403604240-16738-15-git-send-email-tomi.valkeinen@ti.com> <53AC6EDD.6040300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HfW1exGQ263UATQPeeU5m7hABE9JSevv1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbaF0KQn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 06:16:43 -0400
In-Reply-To: <53AC6EDD.6040300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

--HfW1exGQ263UATQPeeU5m7hABE9JSevv1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/14 22:05, Jyri Sarha wrote:
> On 06/24/2014 01:03 PM, Tomi Valkeinen wrote:
>> We no longer need the horrible driver internal videmode tables, which
>> were used to decide if a given videomode is a HDMI or DVI mode. So
>> remove all related code.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/fbdev/omap2/dss/hdmi.h        |  11 -
>>   drivers/video/fbdev/omap2/dss/hdmi_common.c | 316
>> ----------------------------
>>   2 files changed, 327 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h
>> b/drivers/video/fbdev/omap2/dss/hdmi.h
>> index e3956defc1c3..262771b9b76b 100644
>> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
>> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
> ...
>> @@ -192,7 +187,6 @@ struct hdmi_video_format {
>>
>>   struct hdmi_config {
>>       struct omap_video_timings timings;
>> -    struct hdmi_cm cm;
>>       struct hdmi_avi_infoframe infoframe;
>>       enum hdmi_core_hdmi_dvi hdmi_dvi_mode;
>>   };
>=20
> The HDMI audio finctionality is broken already now, but removing
> hdmi_config.cm will cause compilation failure if HDMI audio is enabled.=


Ah, true.

> I'll mail a patch set to fix OMAP4+ HDMI audio shortly. The set should
> be applied on top of these patches and it fixes (obviously) the
> compilation issue too.

I'll rather fix my series. It's not good to introduce compilation errors.=


So I'll just add the following in my patches:

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c
b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 342ddb47811a..6a8550cf43e5 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -491,7 +491,7 @@ static int hdmi_audio_enable(struct omap_dss_device
*dssdev)

        mutex_lock(&hdmi.lock);

-       if (!hdmi_mode_has_audio(hdmi.cfg.cm.mode)) {
+       if (!hdmi_mode_has_audio(hdmi.cfg.hdmi_dvi_mode)) {
                r =3D -EPERM;
                goto err;
        }
@@ -529,7 +529,7 @@ static bool hdmi_audio_supported(struct
omap_dss_device *dssdev)

        mutex_lock(&hdmi.lock);

-       r =3D hdmi_mode_has_audio(hdmi.cfg.cm.mode);
+       r =3D hdmi_mode_has_audio(hdmi.cfg.hdmi_dvi_mode);

        mutex_unlock(&hdmi.lock);
        return r;
@@ -543,7 +543,7 @@ static int hdmi_audio_config(struct omap_dss_device
*dssdev,

        mutex_lock(&hdmi.lock);

-       if (!hdmi_mode_has_audio(hdmi.cfg.cm.mode)) {
+       if (!hdmi_mode_has_audio(hdmi.cfg.hdmi_dvi_mode)) {
                r =3D -EPERM;
                goto err;
        }



--HfW1exGQ263UATQPeeU5m7hABE9JSevv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrUSIAAoJEPo9qoy8lh71Mt8P/A3dmE60s2vVgd67xzNfCVl4
mlu8049TL7L/hfMKiBoyE0ccKo/0qzQHtaivm6BZA9WHzBqmoesRJs8xNuRh0u1O
oYCf6vdXRwF7Z0v0esERd4Pjvhpq19LpCJ+d57gVzAHyOO00dt3meKNSA5E2aFCn
BISYnhrD34XWvuAhD0FSObdV7/veb+LJNzd2SkhY0BeXjZn49ms9WeG2x/VZoBYL
KPreWULkd/ReQQo4GusUyP+Jh+vVi1mnk3OqdGfARDFEqPy6LXlQqrzbwva2xp8b
ukMsEdOviB8dtiisdPrkDT+ecqhWqAbIDC1FBBdZKS+bDOFqv7eoVa3nDjhPr5Jh
mmR8z118sMNnzO854OpITVPV8PK8bIIVnJQV8oaaNx2aFh3hf+ZXiABjUpeNz+Jk
se7sXfiZ31saTuEA2djWXMXnFcGyveQMsKJd1VEydYohOkvXBeh6hdsPPfGR82xo
NThPy5JMIYBj7PIQMCvLpDootFLxARaZPDu/3ZmRYDe/balJX3Zuk9c409II7FnP
iVVjhu72Od5BgsC7Y7FzN/cJN8S35yQKURMj6sQn2SDGVHOD/+GdhmlJ+Up9VqMq
weSp/BRuo2qBeuna9BfzvGoqDIoHINGxitRd4ibJZtB2h+BthDxMfyXd8qhfWij0
N2e3NtdbQ7hHVxa3luzY
=devS
-----END PGP SIGNATURE-----

--HfW1exGQ263UATQPeeU5m7hABE9JSevv1--
