From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/2] ARM: OMAP: rx51: Register audio device
Date: Sun, 20 Jan 2013 04:04:30 +0100
Message-ID: <1358651070-30029-3-git-send-email-pali.rohar@gmail.com>
References: <1358651070-30029-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358651070-30029-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index 45d401a..038ea1f 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1370,6 +1370,16 @@ error:
 	 */
 }
=20
+static struct platform_device rx51_audio_device =3D {
+	.name	=3D "rx51-audio",
+	.id	=3D -1,
+};
+
+static void __init rx51_init_audio(void)
+{
+	platform_device_register(&rx51_audio_device);
+}
+
 static struct tsc2005_platform_data tsc2005_pdata =3D {
 	.ts_pressure_max	=3D 2048,
 	.ts_pressure_fudge	=3D 2,
@@ -1568,6 +1578,7 @@ void __init rx51_peripherals_init(void)
 	gpmc_onenand_init(board_onenand_data);
 	board_smc91x_init();
 	rx51_add_gpio_keys();
+	rx51_init_audio();
 	rx51_init_wl1251();
 	rx51_init_tsc2005();
 	rx51_init_si4713();
--=20
1.7.10.4
