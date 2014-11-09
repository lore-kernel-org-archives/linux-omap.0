From: Pavel Machek <pavel@ucw.cz>
Subject: sound: enable sound support on n900 on devicetree-based boot
Date: Sun, 9 Nov 2014 13:02:22 +0100
Message-ID: <20141109120222.GA3815@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, peter.ujfalusi@ti.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


With device tree, it is possible (and encouraged) to build N900
kernels without CONFIG_MACH_NOKIA_RX51. Update config file to enable
the driver build in this case.

This makes sound work on my n900 under 3.18-rc1.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index d44463a..0d7b707 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -26,7 +26,7 @@ config SND_OMAP_SOC_N810
 
 config SND_OMAP_SOC_RX51
 	tristate "SoC Audio support for Nokia RX-51"
-	depends on SND_OMAP_SOC && ARM && (MACH_NOKIA_RX51 || COMPILE_TEST) && I2C
+	depends on SND_OMAP_SOC && ARM && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_TPA6130A2

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
