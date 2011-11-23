From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the
 AVS driver framework
Date: Wed, 23 Nov 2011 13:38:36 +0200
Message-ID: <20111123113835.GU25068@legolas.emea.dhcp.ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
 <1321974370-25800-26-git-send-email-j-pihet@ti.com>
 <20111123095120.GD25068@legolas.emea.dhcp.ti.com>
 <CAORVsuV2bRJrCnk2Kntr3YgZzoTcFyVcg6A6ZSUUOqkh9Jz0uA@mail.gmail.com>
 <20111123110448.GP25068@legolas.emea.dhcp.ti.com>
 <CAORVsuUio6viQxBFJES0wm7sP3O44se0CsiXue95XEKiR5_F4w@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lwdfKABU4AhUWl+O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50632 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751985Ab1KWLij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 06:38:39 -0500
Received: by mail-yx0-f179.google.com with SMTP id r9so1306272yen.10
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 03:38:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAORVsuUio6viQxBFJES0wm7sP3O44se0CsiXue95XEKiR5_F4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>


--lwdfKABU4AhUWl+O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 23, 2011 at 12:30:54PM +0100, Jean Pihet wrote:
> >> On Wed, Nov 23, 2011 at 10:51 AM, Felipe Balbi <balbi@ti.com> wrote:
> >> > On Tue, Nov 22, 2011 at 04:06:09PM +0100, jean.pihet@newoldbits.com =
wrote:
> >> >> +config POWER_AVS_OMAP_V1
> >> >> + =A0 =A0 tristate "AVS support for the OMAP IP version 1"
> >> >> + =A0 =A0 depends on ARCH_OMAP3 && PM
> >> >> + =A0 =A0 help
> >> >> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the ve=
rsion 1 of
> >> >> + =A0 =A0 =A0 the SmartReflex IP.
> >> >> + =A0 =A0 =A0 V1 is the 65nm version used in OMAP3430.
> >> >> +
> >> >> + =A0 =A0 =A0 Please note, that by default SmartReflex is only
> >> >> + =A0 =A0 =A0 initialized. To enable the automatic voltage
> >> >> + =A0 =A0 =A0 compensation for vdd mpu =A0and vdd core from user sp=
ace,
> >> >> + =A0 =A0 =A0 user must write 1 to
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 /debug/voltage/vdd_<X>/smartreflex/autoco=
mp,
> >> >> + =A0 =A0 =A0 where X is mpu or core for OMAP3.
> >> >> + =A0 =A0 =A0 Optionally autocompensation can be enabled in the ker=
nel
> >> >> + =A0 =A0 =A0 by default during system init via the enable_on_init =
flag
> >> >> + =A0 =A0 =A0 which an be passed as platform data to the smartrefle=
x driver.
> >> >> +
> >> >> +config POWER_AVS_OMAP_V2
> >> >> + =A0 =A0 tristate "AVS support for the OMAP IP version 2"
> >> >> + =A0 =A0 depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
> >> >> + =A0 =A0 help
> >> >> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the ve=
rsion 2 of
> >> >> + =A0 =A0 =A0 the SmartReflex IP.
> >> >> + =A0 =A0 =A0 V2 is the update for the 45nm version of the IP used =
in OMAP3630
> >> >> + =A0 =A0 =A0 and OMAP4430
> >> >
> >> > can't you read the revision register and decide this in runtime ?
> >> Those Kconfig options are used to compile the v1 and/or v2 drivers.
> >> The init of v1 or v2 is decided at runtime, cf. the sr_init functions
> >> where the cpu revision is checked. Is this the correct check?
> >
> > if you already decide in runtime the correct initialization to call, why
> > do you add ifdefs ?
> There is no #ifdef with CONFIG_POWER_AVS_OMAP_V[12], those options are
> used to compile or not the respective modules, cf.
> driver/power/avs/Makefile.

separate modules ? Can't that be combined into one driver only ?

--=20
balbi

--lwdfKABU4AhUWl+O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzNs7AAoJEIaOsuA1yqRE3j0P/A5Z5uLKCcWtWkGIs1djTrOU
Q7FffA1VRD08fQ7yU7YbI+xAu/wfidtrhRzAlNU0S+7F5eGbSoSgGLJ9aLTi1f+f
u+Sf1v2n6eNCGno0Gs004Za4xKFLHoR1AKGki4PQC9EC/ruc3uWRuNn1/xc5AZKp
QGZl/jEX4f+D1LEeuUUg5BLE7ffkQ+gBV5YKG5WHqI+6f0T2XoCG7K30yx5hgKKa
ukICLjdM85Jej2c2ALhn+0hqiRi/GoNPMYUbUKSzDOZTl7L5LnN1kHLSPWkQ3Bkz
Wf1pAuqXrSX+phxGEwNk3p60WOgT6dQKV7RORb3OIHCRWOfbORsZbzVP+dSG/ZHx
Up45X8UsuUQbnQOuq78HLPzLUWFbUzd7Sj2zZDlzgEAo8F97IT/adQA9V86kd7dV
o0tGl662fgoPmhS8/cU4BklZn0NN13iurE3NmHy79YssegHJ7bK8fM5xAWxFkmZL
c0NJXVl7b+7fDvT/bjBW7TFvSNZavv7aUqbWoyCPNxYNhRNZJSh0v51OzZaJqUOv
ZjRHxCJQ5qUB7UIfKTuXoQXWr741+W13Rsixc3VPTtKi9YCFY5vLvI71POYrdhRl
Dbyrqzo/3YnErkaQxO8T5BaQmJVMKMQtxY/9RRuMybLgfDIp+TdWyU8iZMxeXCy4
nxMGpxDNZeSR/eKo5O6J
=XA15
-----END PGP SIGNATURE-----

--lwdfKABU4AhUWl+O--
