From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 1/3] omap2: Change clk dev id for rng to omap3-rom-rng
Date: Fri, 20 Sep 2013 15:25:05 +0200
Message-ID: <1379683507-30793-2-git-send-email-pali.rohar@gmail.com>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
 <1379683507-30793-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379683507-30793-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Name omap_rng is already used by omap_rng driver which is for omap2 and=
 omap4.
=46or omap3 HS devices there is new driver omap3-rom-rng which needs th=
at clk.
And because there cannot be two drivers with same name, rename omap3 cl=
k dev id.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap=
2/cclock3xxx_data.c
index 334b767..5059338 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3274,7 +3274,7 @@ static struct omap_clk omap36xx_clks[] =3D {
  */
 static struct omap_clk omap34xx_omap36xx_clks[] =3D {
 	CLK(NULL,	"aes1_ick",	&aes1_ick),
-	CLK("omap_rng",	"ick",		&rng_ick),
+	CLK("omap3-rom-rng",	"ick",		&rng_ick),
 	CLK(NULL,	"sha11_ick",	&sha11_ick),
 	CLK(NULL,	"des1_ick",	&des1_ick),
 	CLK(NULL,	"cam_mclk",	&cam_mclk),
--=20
1.7.10.4
