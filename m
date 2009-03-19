From: Opel Fahrer <opelfahrer79@yahoo.de>
Subject: AW: CAM / V4L2: OMAP3 camera issues
Date: Thu, 19 Mar 2009 09:20:47 -0700 (PDT)
Message-ID: <640769.14875.qm@web24704.mail.ird.yahoo.com>
References: <A24693684029E5489D1D202277BE89442E6B18D6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n22.bullet.mail.ukl.yahoo.com ([87.248.110.139]:37083 "HELO
	n22.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754299AbZCSQUv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2009 12:20:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Sergio,

thanks for your fast reply, it's good to hear that someone already has =
the issues in mind that I'm talking of. As I mentioned before I haven't=
 done any driver development by now, but maybe it's also a good chance =
to get a little bit into that now. Currently the one and only real prob=
lem with the driver at this time is that the YUYV and YVYU support seem=
s to be broken - it's hard to say because of the heavy over-exposure, b=
ut I guess there is something wrong in a conversion or something simple=
 like that. Fixing only this issue (and maybe the auto-exposure) would =
give us everything we need. However, as soon as you have some time to t=
ake a look at that feel free to contact me such that we can further tal=
k about these things.

Regards
Clemens



----- Urspr=C3=BCngliche Mail ----
Von: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
An: Opel Fahrer <opelfahrer79@yahoo.de>; "linux-omap@vger.kernel.org" <=
linux-omap@vger.kernel.org>
Gesendet: Donnerstag, den 19. M=C3=A4rz 2009, 16:02:48 Uhr
Betreff: RE: CAM / V4L2: OMAP3 camera issues

Hi Clemens,

I'm the one responsible for this driver, and the features that are adde=
d by now are pretty basical.

Currently I'm a bit absorbed by other higher priority tasks, so I haven=
=C3=A2=E2=82=AC=E2=84=A2t been able to update the driver as fast as I w=
ould want.

We are working towards enhancing the driver so most of the features be =
available, but if you have some enhancement suggestion, I'll invite you=
 to do so.

I appreciate your time.

Regards,
Sergio

> -----Original Message-----
> From: linux-omap-owner@vger.kernel..org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Opel Fahrer
> Sent: Thursday, March 19, 2009 8:24 AM
> To: linux-omap@vger.kernel..org
> Subject: CAM / V4L2: OMAP3 camera issues
>=20
>=20
> Hi everybody,
>=20
> I just wanted to ask if someone of you recently had a look at the  ca=
mera
> driver for the ov3640 sensor included in the omap zoom 1 platform. As=
 I'm
> a total noob in writing drivers I'm searching for someone to help me =
to
> get this device to work the right way because currently it's really a=
 mess.
> Unfortunately our future work with the omap zoom heavily relies on ha=
ving
> camera images in reasonable resolutions and reasonable quality, so fo=
r us
> there is no way around fixing at least some of these points:
>=20
> As far as I have seen there are several issues. The main problem is t=
hat
> it is only possible to use a very restricted number of image formats.=
 One
> can use Bayer images in 1024x768 up to 2048x1536 pixels, and using th=
e
> Bayer format is the only way to get RGB images actually. The much mor=
e
> appreciated YUYV and YVYU formats seem to be broken somehow, so nobod=
y is
> known to me who was able to decode such an image into a reasonable co=
lor
> image yet. Lastly, a problem is that there is no way to control the
> exposure of the sensor, such that the images are all heavily over-exp=
osed
> and there is no way known to me to change any setting to use auto-exp=
osure
> (the feature is reported to be not available by v4l2).
>=20
> I'd be happy if someone could help me in fixing some of these problem=
s.
> Regards
> Clemens
>=20
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=20

N=E2=80=B9=C2=A7=C2=B2=C3=A6=C3=ACr=C2=B8=E2=80=BAy=C3=BA=C3=A8=C5=A1=C3=
=98b=C2=B2X=C2=AC=C2=B6=C3=87=C2=A7v=C3=98^=E2=80=93)=C3=9E=C2=BA{.n=C3=
=87+=E2=80=B0=C2=B7=C2=A5=C5=A0{=C2=B1=C2=A2f=C2=A9=C5=A0{ay=C2=BA=C3=8A=
=E2=80=A1=C3=9A=E2=84=A2=C3=AB,j=C2=AD=C2=A2f=C2=A3=C2=A2=C2=B7h=C5=A1=E2=
=80=B9=C3=A0z=C2=B9=C2=AEw=C2=A5=C2=A2=C2=B8=C2=A2=C2=B7=C2=A6j:+v=E2=80=
=B0=C2=A8=C5=A0w=C3=A8j=C3=98m=C2=B6=C5=B8=C3=BF=C2=BE=C2=AB=E2=80=98=C3=
=AA=C3=A7zZ+=C6=92=C3=B9=C5=A1=C5=BD=C5=A0=C3=9D=C2=A2j"=EF=BF=BD=C3=BA=
!=C2=B6i


     =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
