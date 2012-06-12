From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Tue, 12 Jun 2012 08:27:44 -0700 (PDT)
Message-ID: <1339514864.6355.YahooMailNeo@web125206.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com> <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com> <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm21-vm0.bullet.mail.ne1.yahoo.com ([98.138.90.94]:41410 "HELO
	nm21-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751132Ab2FLP1p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:27:45 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Afzal,

Thanks!=A0 This set looks very interesting.=A0 As I've been chasing thi=
s bug all week, I haven't had time to sync our build up to the latest t=
ree.=A0 So I'm still back at 3.4-rc6, and cannot directly patch this in=
 a give it a try yet.=A0 However, I'll certainly take a look as soon as=
 I can.=A0 My research on the issue so far has indicated that we may ha=
ve a hardware issue not a software issue.=A0 We're seeing some nasty tr=
ansients pouring in from our power supply.=A0 So, we're chasing that fi=
rst.

Thanks again for the post and suggestions though.=A0 I do want to get u=
p to the 3.5 series as soon as I can.

Best regards!



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
