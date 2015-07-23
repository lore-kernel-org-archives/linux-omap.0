From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] thermal: consistently use int for temperatures
Date: Thu, 23 Jul 2015 12:37:58 +0200
Message-ID: <20150723103758.GI18700@pengutronix.de>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
 <9hhk2tteqb3.fsf@e105922-lin.cambridge.arm.com>
 <744357E9AAD1214791ACBA4B0B9092630153E699@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092630153E699@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard>
List-Id: linux-omap@vger.kernel.org

Hi Zhang,

On Tue, Jul 21, 2015 at 01:35:31PM +0000, Zhang, Rui wrote:
> > >
> Patch applied.

Thanks for applying. I missed to convert another place, so we get a new
compiler warning. The attached patch fixes this (suitable for git rebas=
e
--autosquash). Please let me know if you can handle this or if you
prefer a new patch instead.

Thanks
 Sascha


-----------------------------8<-------------------------------------

=46rom 4907a7c32fd16eaf9f31d9f904276c9a0176b717 Mon Sep 17 00:00:00 200=
1
=46rom: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 23 Jul 2015 12:32:31 +0200
Subject: [PATCH] fixup! thermal: consistently use int for temperatures
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

fixes:
drivers/power/charger-manager.c: In function =E2=80=98cm_get_battery_te=
mperature=E2=80=99:
drivers/power/charger-manager.c:622:45: warning: passing argument 2 of =
=E2=80=98thermal_zone_get_temp=E2=80=99 from incompatible pointer type
   ret =3D thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/power/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-ma=
nager.c
index 1c202cc..907293e 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -619,7 +619,7 @@ static int cm_get_battery_temperature(struct charge=
r_manager *cm,
=20
 #ifdef CONFIG_THERMAL
 	if (cm->tzd_batt) {
-		ret =3D thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
+		ret =3D thermal_zone_get_temp(cm->tzd_batt, temp);
 		if (!ret)
 			/* Calibrate temperature unit */
 			*temp /=3D 100;
--=20
2.1.4


--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
