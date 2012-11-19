From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] bq2415x charger driver
Date: Sun, 18 Nov 2012 16:00:06 -0800
Message-ID: <20121119000006.GD29066@lizard.sbx05977.paloaca.wayport.net>
References: <1391088.VOCN5mxOBg@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391088.VOCN5mxOBg@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@debian.org>, Felipe Contreras <felipe.contreras@gmail.com>, Joerg Reisenweber <joerg@openmoko.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, David Woodhouse <dwmw2@infradead.org>, Aliaksei Katovich <aliaksei.katovich@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 02, 2012 at 08:18:11PM +0100, Pali Roh=C3=A1r wrote:
> Hello,
>=20
> I'm sending new version of bq2415x charger driver which is needed
> for example on Nokia N900 for charging battery. Driver is part of
> open source project to replace proprietary battery management.
> Driver is based on old RFC version which I sent months ago.
>=20
> power_supply: Add bq2415x charger driver
>=20
> This patch implements driver for bq2415x charging chips.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Applied, thanks!

Note that I had to add the Makefile/Kconfig entries and fix some style
issues...

commit 7ad85830736f3e0d854becf7621eba3a0c926d13
Author: Anton Vorontsov <cbouatmailru@gmail.com>
Date:   Sun Nov 18 15:48:52 2012 -0800

    bq2415x_charger: Add Kconfig/Makefile entries
   =20
    This commit adds Kconfig and Makefile entries so that we could actu=
ally
    build the driver.
   =20
    Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 5c3237f..523a580 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -322,6 +322,16 @@ config CHARGER_MAX8998
 	  Say Y to enable support for the battery charger control sysfs and
 	  platform data of MAX8998/LP3974 PMICs.
=20
+config CHARGER_BQ2415X
+	tristate "TI BQ2415x battery charger driver"
+	depends on I2C
+	help
+	  Say Y to enable support for the TI BQ2415x battery charger
+	  PMICs.
+
+	  You'll need this driver to charge batteries on e.g. Nokia
+	  RX-51/N900.
+
 config CHARGER_SMB347
 	tristate "Summit Microelectronics SMB347 Battery Charger"
 	depends on I2C
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index bc81fe2..74dfd95 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -48,5 +48,6 @@ obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
 obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
+obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
 obj-$(CONFIG_POWER_AVS)		+=3D avs/
 obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
