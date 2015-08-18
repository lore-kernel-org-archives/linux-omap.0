From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 3/7] gpio: omap: fix omap2_set_gpio_debounce
Date: Tue, 18 Aug 2015 14:10:54 +0300
Message-ID: <1439896258-26449-4-git-send-email-grygorii.strashko@ti.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

According to TRMs:

Required input line stable =3D
  (the value of the GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) =C3=97 3=
1,
where the value of the GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME bit field
is from 0 to 255.

But now omap2_set_gpio_debounce() will calculate debounce time and
behave incorrectly in the following cases:
1) requested debounce time is !0 and <32
   calculated DEBOUNCETIME =3D 0x1 =3D=3D 62 us;
   expected value of DEBOUNCETIME =3D 0x0 =3D=3D 31us
2) requested debounce time is 0
   calculated DEBOUNCETIME =3D 0x1 =3D=3D 62 us;
   expected: disable debounce and DEBOUNCETIME =3D 0x0
3) requested debounce time is >32 and <63
   calculated DEBOUNCETIME =3D 0x0 and debounce will be disabled;
   expected: enable debounce and DEBOUNCETIME =3D 0x1 =3D=3D 62 us

Hence, rework omap2_set_gpio_debounce() to fix above cases:
1) introduce local variable "enable" and use it to identify
when debounce need to be enabled or disabled. Disable debounce
if requested debounce time is 0.
2) use below formula for debounce time calculation:
   debounce =3D (DIV_ROUND_UP(debounce, 31) - 1) & 0xFF;

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 03fd111..9ed5a67 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/gpio-omap.h>
=20
 #define OFF_MODE	1
+#define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
=20
 static LIST_HEAD(omap_gpio_list);
=20
@@ -204,8 +205,9 @@ static inline void omap_gpio_dbck_disable(struct gp=
io_bank *bank)
  * @offset: the gpio number on this @bank
  * @debounce: debounce time to use
  *
- * OMAP's debounce time is in 31us steps so we need
- * to convert and round up to the closest unit.
+ * OMAP's debounce time is in 31us steps
+ *   <debounce time> =3D (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) x=
 31
+ * so we need to convert and round up to the closest unit.
  */
 static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned o=
ffset,
 				    unsigned debounce)
@@ -213,16 +215,15 @@ static void omap2_set_gpio_debounce(struct gpio_b=
ank *bank, unsigned offset,
 	void __iomem		*reg;
 	u32			val;
 	u32			l;
+	bool			enable =3D !!debounce;
=20
 	if (!bank->dbck_flag)
 		return;
=20
-	if (debounce < 32)
-		debounce =3D 0x01;
-	else if (debounce > 7936)
-		debounce =3D 0xff;
-	else
-		debounce =3D (debounce / 0x1f) - 1;
+	if (enable) {
+		debounce =3D DIV_ROUND_UP(debounce, 31) - 1;
+		debounce &=3D OMAP4_GPIO_DEBOUNCINGTIME_MASK;
+	}
=20
 	l =3D BIT(offset);
=20
@@ -233,7 +234,7 @@ static void omap2_set_gpio_debounce(struct gpio_ban=
k *bank, unsigned offset,
 	reg =3D bank->base + bank->regs->debounce_en;
 	val =3D readl_relaxed(reg);
=20
-	if (debounce)
+	if (enable)
 		val |=3D l;
 	else
 		val &=3D ~l;
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
