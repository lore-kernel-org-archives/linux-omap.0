From: Pavel Machek <pavel@ucw.cz>
Subject: twl4030_charger: need changes to get probed?
Date: Fri, 6 Mar 2015 22:24:17 +0100
Message-ID: <20150306212417.GA24169@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.11227.stgit@notabene.brown>
 <20150302210926.GP13270@amd>
 <20150305173350.50502b95@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150305173350.50502b95@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

According to n900 dts, twl4030-bci (aka charger) should be included.

(But it does not seem to do anything useful on n900. I was hoping for
measurement of input voltage, but .. no.)

Any ideas why the patch below is needed?

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_ch=
arger.c
index d35b83e..96bbbe9 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -714,6 +722,7 @@ static const struct of_device_id twl_bci_of_match[]=
 =3D {
 MODULE_DEVICE_TABLE(of, twl_bci_of_match);
=20
 static struct platform_driver twl4030_bci_driver =3D {
+	.probe =3D twl4030_bci_probe,
 	.driver	=3D {
 		.name	=3D "twl4030_bci",
 		.of_match_table =3D of_match_ptr(twl_bci_of_match),
@@ -721,7 +730,7 @@ static struct platform_driver twl4030_bci_driver =3D=
 {
 	.remove	=3D __exit_p(twl4030_bci_remove),
 };
=20
-module_platform_driver_probe(twl4030_bci_driver, twl4030_bci_probe);
+module_platform_driver(twl4030_bci_driver);
=20
 MODULE_AUTHOR("Gra=C5=BEvydas Ignotas");
 MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
