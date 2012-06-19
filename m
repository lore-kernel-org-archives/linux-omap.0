From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: Please help! AM35xx mm/slab.c BUG
Date: Tue, 19 Jun 2012 06:29:28 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99C552@DBDE01.ent.ti.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
 <20120605070853.GE12766@atomide.com>
 <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
 <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com>
 <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
 <20120606071024.GP12766@atomide.com>
 <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com>
 <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
 <1340069382.68890.YahooMailNeo@web125206.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078Ab2FSG3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jun 2012 02:29:43 -0400
In-Reply-To: <1340069382.68890.YahooMailNeo@web125206.mail.ne1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi,

On Tue, Jun 19, 2012 at 06:59:42, CF Adad wrote:

> Anyway, we have advanced our kernel to today's latest l-o (3.5-rc2). =
Though we are not considering the GPMC a likely source of the error at =
this moment, I'm considering exploring this patchset.=A0 Unfortunately,=
 the NAND is very critical to our current efforts.=A0 So I'm trying to =
find a time where it would be OK to disable it as you suggested to try =
this.=A0 Since these values are being set now in Linux, do I need to re=
work my bootloaders as well?=A0 In my current case, these settings are =
all done in u-boot. I do not believe Linux did anything with them.=A0 D=
o I need to remove those in order to use your patches?=A0 If I do, do I=
 not lose access to those things while in the bootloaders?

Please sent me your board file, I will modify it to use the
new interface with NAND relying on bootloader settings and
SMSC relying on Kernel.

No bootloader modifications are required.

Regards
Afzal
=20
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69501.h=
tml
> [2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.h=
tml
> [3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69891.h=
tml
> [4] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69897.h=
tml
> [5] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69917.h=
tml
> [5.x] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69924=
=2Ehtml
>=20
> [6]
> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap=
2/gpmc-smsc911x.c
> index 4bfe721..34816b9 100644
> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
> @@ -105,12 +105,12 @@ static void gpmc_smsc911x_timing(struct gpmc_ti=
me_ctrl *time_ctrl,
> {
> =A0 =A0 =A0 =A0 struct gpmc_timings t;
> =A0 =A0 =A0 =A0 /* SMSC 9220 timings */
> -=A0 =A0 =A0  unsigned tcycle_r =3D 165;
> +=A0 =A0 =A0  unsigned tcycle_r =3D 45;
> =A0 =A0 =A0 =A0 unsigned tcsl_r =3D 32;
> =A0 =A0 =A0 =A0 unsigned tcsh_r =3D 133;
> =A0 =A0 =A0 =A0 unsigned tcsdv_r =3D 30;
> =A0 =A0 =A0 =A0 unsigned tdoff_r =3D 9;
> -=A0 =A0 =A0  unsigned tcycle_w =3D 165;
> +=A0 =A0 =A0  unsigned tcycle_w =3D 45;
> =A0 =A0 =A0 =A0 unsigned tcsl_w =3D 32;
> =A0 =A0 =A0 =A0 unsigned tcsh_w =3D 133;
> =A0 =A0 =A0 =A0 unsigned tdsu_w =3D 7;
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
