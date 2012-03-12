From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAPDSS: provide default timings functions for panels
Date: Mon, 12 Mar 2012 13:26:17 +0200
Message-ID: <CANOLnOO9XgaO0fYtAw5c88En6vJJAQKQfV-1z-sAg7pxzUKuXQ@mail.gmail.com>
References: <1331480061-5767-1-git-send-email-notasas@gmail.com>
	<4F5D9002.1030505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53738 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab2CLL0S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 07:26:18 -0400
In-Reply-To: <4F5D9002.1030505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Mon, Mar 12, 2012 at 7:56 AM, Archit Taneja <a0393947@ti.com> wrote:

>> diff --git a/drivers/video/omap2/dss/core.c
>> b/drivers/video/omap2/dss/core.c
>> index 86ec12e..9dc0c10 100644
>> --- a/drivers/video/omap2/dss/core.c
>> +++ b/drivers/video/omap2/dss/core.c
>> @@ -434,6 +434,12 @@ int omap_dss_register_driver(struct omap_dss_dr=
iver
>> *dssdriver)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dssdriver->get_recommended_bpp =3D=3D=
 NULL)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dssdriver->ge=
t_recommended_bpp =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omapdss_default_get_recommended_bpp;
>> + =C2=A0 =C2=A0 =C2=A0 if (dssdriver->set_timings =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dssdriver->set_ti=
mings =3D omapdss_default_set_timings;
>> + =C2=A0 =C2=A0 =C2=A0 if (dssdriver->get_timings =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dssdriver->get_ti=
mings =3D omapdss_default_get_timings;
>> + =C2=A0 =C2=A0 =C2=A0 if (dssdriver->check_timings =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dssdriver->check_=
timings =3D omapdss_default_check_timings;
>
>
> This elimination makes sense with get_timings(), but having the defau=
lt
> check_timings() and set_timings() linked with the DPI interface doesn=
't seem
> right.
>
> For example, if a panel driver using DSI interface doesn't have it's =
own
> set_timings() op populated, and if some user of DSS call's set_timing=
s(), it
> would mess up the DSS2 driver.
>
> Probably having a check like this in check_timings()/set_timings() mi=
ght
> make it safer:
>
> if (dssdev->type =3D=3D OMAP_DISPAY_TYPE_DPI)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dpi_set_timings(dssdev, timings);

Makes sense, sending v2 shortly.

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
