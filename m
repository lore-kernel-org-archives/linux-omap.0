From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the
 AVS driver framework
Date: Wed, 23 Nov 2011 13:04:49 +0200
Message-ID: <20111123110448.GP25068@legolas.emea.dhcp.ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
 <1321974370-25800-26-git-send-email-j-pihet@ti.com>
 <20111123095120.GD25068@legolas.emea.dhcp.ti.com>
 <CAORVsuV2bRJrCnk2Kntr3YgZzoTcFyVcg6A6ZSUUOqkh9Jz0uA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K9fy5ol1Oes4Q/ix"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51319 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750742Ab1KWLEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 06:04:52 -0500
Received: by mail-yw0-f47.google.com with SMTP id 20so1411605ywb.34
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 03:04:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAORVsuV2bRJrCnk2Kntr3YgZzoTcFyVcg6A6ZSUUOqkh9Jz0uA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>


--K9fy5ol1Oes4Q/ix
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2011 at 11:22:42AM +0100, Jean Pihet wrote:
> Hi Felipe,
>=20
> On Wed, Nov 23, 2011 at 10:51 AM, Felipe Balbi <balbi@ti.com> wrote:
> > On Tue, Nov 22, 2011 at 04:06:09PM +0100, jean.pihet@newoldbits.com wro=
te:
> >> +config POWER_AVS_OMAP_V1
> >> + =A0 =A0 tristate "AVS support for the OMAP IP version 1"
> >> + =A0 =A0 depends on ARCH_OMAP3 && PM
> >> + =A0 =A0 help
> >> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the versi=
on 1 of
> >> + =A0 =A0 =A0 the SmartReflex IP.
> >> + =A0 =A0 =A0 V1 is the 65nm version used in OMAP3430.
> >> +
> >> + =A0 =A0 =A0 Please note, that by default SmartReflex is only
> >> + =A0 =A0 =A0 initialized. To enable the automatic voltage
> >> + =A0 =A0 =A0 compensation for vdd mpu =A0and vdd core from user space,
> >> + =A0 =A0 =A0 user must write 1 to
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /debug/voltage/vdd_<X>/smartreflex/autocomp,
> >> + =A0 =A0 =A0 where X is mpu or core for OMAP3.
> >> + =A0 =A0 =A0 Optionally autocompensation can be enabled in the kernel
> >> + =A0 =A0 =A0 by default during system init via the enable_on_init flag
> >> + =A0 =A0 =A0 which an be passed as platform data to the smartreflex d=
river.
> >> +
> >> +config POWER_AVS_OMAP_V2
> >> + =A0 =A0 tristate "AVS support for the OMAP IP version 2"
> >> + =A0 =A0 depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
> >> + =A0 =A0 help
> >> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the versi=
on 2 of
> >> + =A0 =A0 =A0 the SmartReflex IP.
> >> + =A0 =A0 =A0 V2 is the update for the 45nm version of the IP used in =
OMAP3630
> >> + =A0 =A0 =A0 and OMAP4430
> >
> > can't you read the revision register and decide this in runtime ?
> Those Kconfig options are used to compile the v1 and/or v2 drivers.
> The init of v1 or v2 is decided at runtime, cf. the sr_init functions
> where the cpu revision is checked. Is this the correct check?

if you already decide in runtime the correct initialization to call, why
do you add ifdefs ? It's not like you're adding that huge amount of code
for v1 and v2, right ?

--=20
balbi

--K9fy5ol1Oes4Q/ix
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzNNQAAoJEIaOsuA1yqREl/IQAJaU3vSHiHyu7ISgfzk33hRq
9TNt3dqnqte6gibOuzJLFxwAylPORD5mBb20h0nRsB3xxU/QY1Bhpann38QbiHGa
wBBqwIdzDJo6RYgEvyoIUE9SNi1CIbh8GTZXLTtpkbjrgXiD4yaSuuHzfXlmomXk
QUTXV+BtKtmYuXTniCrg1DduBBMrd9yt15TyYYygyfHgmHTx5+MZlh9nc2iBR6k/
EhTpEMxLau/UVFBwwGERBptoSi6RIZiDzsBRz99/HoWnDA/cjdy45S8zXujGJJra
akY0ht4uG9Y1IYSAHBHpJrlniIKIOSRofIurvZX6mLBTH9x3nHltV4YWlYyx8Xuv
19kHWg61srdrmYkgNxvRMEAbf1OZ9mlJ4IdKESfE/1p0pguuZE7tzKTgVaCEQwTF
NNYUFt4SKsRk/OerXXZhTzzRzYmdX4rNEg8Z+ezWER7kceOYMUqO2fT5V9buKFPH
1AXkkmDxx7AVbXasGYC38sb5PFTlWbgLNGiXxuGNwlwAS4fUkUyhGrsGGzr2B/MI
c4mYMNMBlS8NYgtV+wz9Sti6ordyZD25HMTg2iqWSyfTEivZt2KT7mpj8BlSbsF9
WawkfBO8tFAaneIbYB6Tc1HiD8f/zOzL0EEsv1y+jEAYS+grMSix72cD+GWmyWiy
HaX5oUXhkvUki8TqYWOx
=H12p
-----END PGP SIGNATURE-----

--K9fy5ol1Oes4Q/ix--
