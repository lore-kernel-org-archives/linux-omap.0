From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Mon, 18 Jun 2012 18:29:42 -0700 (PDT)
Message-ID: <1340069382.68890.YahooMailNeo@web125206.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com> <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com> <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm24.bullet.mail.ne1.yahoo.com ([98.138.90.87]:21610 "HELO
	nm24.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752459Ab2FSB3o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 21:29:44 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Afzal,

I just wanted to follow back up.=A0 We are still trying to find this sl=
ab bug, but so far we've not found any smoking guns.=A0 Less than stabl=
e power is our current main suspect. As has been the custom however, th=
e error was here 2 weeks ago nearly non-stop, and then as suddenly as i=
t came it went nearly silent.=A0 We've had a very hard time reproducing=
 it since!


Anyway, we have advanced our kernel to today's latest l-o (3.5-rc2). Th=
ough we are not considering the GPMC a likely source of the error at th=
is moment, I'm considering exploring this patchset.=A0 Unfortunately, t=
he NAND is very critical to our current efforts.=A0 So I'm trying to fi=
nd a time where it would be OK to disable it as you suggested to try th=
is.=A0 Since these values are being set now in Linux, do I need to rewo=
rk my bootloaders as well?=A0 In my current case, these settings are al=
l done in u-boot. I do not believe Linux did anything with them.=A0 Do =
I need to remove those in order to use your patches?=A0 If I do, do I n=
ot lose access to those things while in the bootloaders?


Thanks



----- Original Message -----
=46rom: "Mohammed, Afzal" <afzal@ti.com>
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>; Tony Lin=
dgren <tony@atomide.com>; "Shilimkar, Santosh" <santosh.shilimkar@ti.co=
m>
Sent: Tuesday, June 12, 2012 7:14 AM
Subject: RE: Please help! AM35xx mm/slab.c BUG

Hi,

On Fri, Jun 08, 2012 at 01:20:13, CF Adad wrote:

> Thanks for your thoughts!=A0 I may try fiddling a bit just to see if =
that helps.

5 series of patches for gpmc modifications [1-5] has been posted,
In case it helps in resolving your issue, please let me know.

You will have to use the new interface to make use of runtime
calculation of smsc911x timing, [5.x] can be referred for how to
do board modifications for smsc911x (please comment out any other
gpmc peripheral initialization in your board code, seems you have
nand, comment out nand initialization, even nand can be made to
work with new changes, but avoiding it will probably reduce your
burden)

As your eth is 9221, either you can provide the timings based on it
from board file or apply [6] over [1-5] (base: 3.5-rc1)

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69501.htm=
l
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.htm=
l
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69891.htm=
l
[4] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69897.htm=
l
[5] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69917.htm=
l
[5.x] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69924.h=
tml

[6]
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/=
gpmc-smsc911x.c
index 4bfe721..34816b9 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -105,12 +105,12 @@ static void gpmc_smsc911x_timing(struct gpmc_time=
_ctrl *time_ctrl,
{
=A0 =A0 =A0 =A0 struct gpmc_timings t;
=A0 =A0 =A0 =A0 /* SMSC 9220 timings */
-=A0 =A0 =A0  unsigned tcycle_r =3D 165;
+=A0 =A0 =A0  unsigned tcycle_r =3D 45;
=A0 =A0 =A0 =A0 unsigned tcsl_r =3D 32;
=A0 =A0 =A0 =A0 unsigned tcsh_r =3D 133;
=A0 =A0 =A0 =A0 unsigned tcsdv_r =3D 30;
=A0 =A0 =A0 =A0 unsigned tdoff_r =3D 9;
-=A0 =A0 =A0  unsigned tcycle_w =3D 165;
+=A0 =A0 =A0  unsigned tcycle_w =3D 45;
=A0 =A0 =A0 =A0 unsigned tcsl_w =3D 32;
=A0 =A0 =A0 =A0 unsigned tcsh_w =3D 133;
=A0 =A0 =A0 =A0 unsigned tdsu_w =3D 7;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
