From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 14/15] OMAPDSS: HDMI: remove the unused code
Date: Fri, 27 Jun 2014 13:20:53 +0300
Message-ID: <53AD4585.1060405@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com> <1403604240-16738-15-git-send-email-tomi.valkeinen@ti.com> <53AC6EDD.6040300@ti.com> <53AD4485.3070506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ROH8flNlfkfKJR00idHRall4vwMJI3hlr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51985 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbaF0KUz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 06:20:55 -0400
In-Reply-To: <53AD4485.3070506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

--ROH8flNlfkfKJR00idHRall4vwMJI3hlr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/06/14 13:16, Tomi Valkeinen wrote:
> On 26/06/14 22:05, Jyri Sarha wrote:
>> On 06/24/2014 01:03 PM, Tomi Valkeinen wrote:
>>> We no longer need the horrible driver internal videmode tables, which=

>>> were used to decide if a given videomode is a HDMI or DVI mode. So
>>> remove all related code.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>   drivers/video/fbdev/omap2/dss/hdmi.h        |  11 -
>>>   drivers/video/fbdev/omap2/dss/hdmi_common.c | 316
>>> ----------------------------
>>>   2 files changed, 327 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h
>>> b/drivers/video/fbdev/omap2/dss/hdmi.h
>>> index e3956defc1c3..262771b9b76b 100644
>>> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
>>> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
>> ...
>>> @@ -192,7 +187,6 @@ struct hdmi_video_format {
>>>
>>>   struct hdmi_config {
>>>       struct omap_video_timings timings;
>>> -    struct hdmi_cm cm;
>>>       struct hdmi_avi_infoframe infoframe;
>>>       enum hdmi_core_hdmi_dvi hdmi_dvi_mode;
>>>   };
>>
>> The HDMI audio finctionality is broken already now, but removing
>> hdmi_config.cm will cause compilation failure if HDMI audio is enabled=
=2E
>=20
> Ah, true.
>=20
>> I'll mail a patch set to fix OMAP4+ HDMI audio shortly. The set should=

>> be applied on top of these patches and it fixes (obviously) the
>> compilation issue too.
>=20
> I'll rather fix my series. It's not good to introduce compilation error=
s.
>=20
> So I'll just add the following in my patches:
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c

Oh, and the same for hdmi5.c. Although that code is not compiled anyway,
but I think it's still better to fix it.

That could introduce a conflict with your series, but it's trivial.

 Tomi



--ROH8flNlfkfKJR00idHRall4vwMJI3hlr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrUWFAAoJEPo9qoy8lh71vRUQAJ1Ylaz1Q9H654qVeQkziiuy
NzxJ/f/2XKWEiW6AFOWunDvUMraVXEFHBUcHjK8nb5vcoBXcfodi1xMuyBkX0TLT
I+j8Oiu2wiaI4Dj8aCPbLAdolHmg3crVN0O82jMJD24N6sR1z2t/oV07Kd6vnWRP
5QCDxW10cUMXz9kxXKnl0a6K/Zq18e0jacBifz5YhanaG+7N3EpJNuUiT7BSuD/A
rCD7R7x9qAsm3NN2NEVOPFaYPo1g054qRn4Nl8joEbElLFfKqwFt1YjtjYuepWCH
beMA1nb82gVufEXZE2JFu3IffkkZQfRtXopxxSr8LABFMgNjpTiiXdmjQXKkVxmP
aFCxwoDTTEddf9q4tooM6ZevMEKTURfbmxqo+o6mA2NkWBwfSI1oN2HQpW6oPJal
kqUas0Y0Rz2INLvrPFaF2aaUxx+Lp+jF4/Coz7Lmm41HMzTyUfqegVrhIZzcCLix
XysjyHTdC2wzn/CCHOldHJ8WxPFDtOMFP2m+1OLAxcEHkM9TmxNV1wce+IKzZ/Mi
UTKNQ/YsjAVLO8qdft4QoL6iYlhj7R0dyyLKG38N3wW3D9n7lSXw0FwnqkduQocf
Chz4ZDP24QjPSqPSgkJId6Zje6GtbBZDXTIXUFm3adjr1zrXn5bfqpeWSSgDU9RQ
mJLAWA/EobLRlipkK2Yo
=mKOE
-----END PGP SIGNATURE-----

--ROH8flNlfkfKJR00idHRall4vwMJI3hlr--
