From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: Please help! AM35xx mm/slab.c BUG
Date: Tue, 12 Jun 2012 11:14:12 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
 <20120605070853.GE12766@atomide.com>
 <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
 <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com>
 <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
 <20120606071024.GP12766@atomide.com>
 <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com>
 <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54432 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab2FLLOS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 07:14:18 -0400
In-Reply-To: <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

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
        struct gpmc_timings t;
        /* SMSC 9220 timings */
-       unsigned tcycle_r =3D 165;
+       unsigned tcycle_r =3D 45;
        unsigned tcsl_r =3D 32;
        unsigned tcsh_r =3D 133;
        unsigned tcsdv_r =3D 30;
        unsigned tdoff_r =3D 9;
-       unsigned tcycle_w =3D 165;
+       unsigned tcycle_w =3D 45;
        unsigned tcsl_w =3D 32;
        unsigned tcsh_w =3D 133;
        unsigned tdsu_w =3D 7;

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
