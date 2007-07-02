From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: [PATCH] OMAP: Define more OMAP24XX GPIOs pinout
Date: Mon, 2 Jul 2007 16:34:24 +0900
Message-ID: <002c01c7bc7b$6ccd1f50$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[PATCH] OMAP: Define more OMAP24XX GPIOs pinout

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 4c82860..37e364d 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -78,6 +78,10 @@ MUX_CFG_24XX("AA8_242X_GPIO58",		0x0ea,	3,
0,	0,	1)
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,
1)
 MUX_CFG_24XX("W4__24XX_GPIO74",		0x0f2,	3,	0,	0,
1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,
1)
+MUX_CFG_24XX("P20_24XX_GPIO93",		0x10b,	3,	0,	0,
1)
+MUX_CFG_24XX("P18_24XX_GPIO95",		0x10d,	3,	0,	0,
1)
+MUX_CFG_24XX("M18_24XX_GPIO96",		0x10e,	3,	0,	0,
1)
+MUX_CFG_24XX("L14_24XX_GPIO97",		0x10f,	3,	0,	0,
1)
 MUX_CFG_24XX("J15_24XX_GPIO99",		0x113,	3,	1,	1,
1)
 MUX_CFG_24XX("V14_24XX_GPIO117",	0x128,	3,	1,	0,	1)
 MUX_CFG_24XX("P14_24XX_GPIO125",	0x140,	3,	1,	1,	1)
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index 90e454e..fc682b5 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -470,6 +470,10 @@ enum omap24xx_index {
 	Y20_24XX_GPIO60,
 	W4__24XX_GPIO74,
 	M15_24XX_GPIO92,
+	P20_24XX_GPIO93,
+	P18_24XX_GPIO95,
+	M18_24XX_GPIO96,
+	L14_24XX_GPIO97,
 	J15_24XX_GPIO99,
 	V14_24XX_GPIO117,
 	P14_24XX_GPIO125,
