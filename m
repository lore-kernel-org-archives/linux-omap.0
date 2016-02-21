From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/6] power_supply: isp1704_charger: Add compatible of match for nxp,isp1707
Date: Sun, 21 Feb 2016 12:28:19 +0100
Message-ID: <1456054103-19551-3-git-send-email-pali.rohar@gmail.com>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/power/isp1704_charger.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_ch=
arger.c
index acaf7cf..4cd6899 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -536,6 +536,7 @@ static int isp1704_charger_remove(struct platform_d=
evice *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id omap_isp1704_of_match[] =3D {
 	{ .compatible =3D "nxp,isp1704", },
+	{ .compatible =3D "nxp,isp1707", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_isp1704_of_match);
--=20
1.7.9.5

