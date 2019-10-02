From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] ARM: OMAP1: ams-delta FIQ: Fix a typo ("Initiaize")
Date: Wed,  2 Oct 2019 16:53:00 +0200
Message-ID: <20191002145301.11332-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/mach-omap1/ams-delta-fiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams=
-delta-fiq.c
index 0254eb9cf8c6..4eea3e39e633 100644
=2D-- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -110,7 +110,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip,

 		/*
 		 * FIQ handler takes full control over serio data and clk GPIO
-		 * pins.  Initiaize them and keep requested so nobody can
+		 * pins.  Initialize them and keep requested so nobody can
 		 * interfere.  Fail if any of those two couldn't be requested.
 		 */
 		switch (i) {
=2D-
2.20.1
