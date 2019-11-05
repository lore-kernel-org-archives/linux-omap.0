From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH 62/62] gpiolib: Nag for INPUT direction values
 other than GPIO_LINE_DIRECTION_IN
Date: Tue, 5 Nov 2019 12:42:21 +0200
Message-ID: <06aa0acec5797fc5711354d8ecad18bc6e947122.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc: Semi Malinen <semi.malinen@ge.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-aspeed@lists.ozlabs.org, David Daney <david.daney@cavium.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Peter Tyser <ptyser@xes-inc.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Fabio Estevam <festevam@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Marek Vasut <marek.vasut+renesas@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Marek Behun <marek.behun@nic.cz>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, bcm-kernel-feedback-list@broadcom.com, Joel Stanley <joel@jms.id.au>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>B
List-Id: linux-omap@vger.kernel.org

It seems that bunch of drivers put some effort (namely use !! or ! when
converting GPIO direction register value to direction) to only return 1
or 0 for direction INPUT/UOTPUT. Others do just return any positive value
they happen to read from register for INPUT. Let's try iron out this habit
by nagging if our cool new definitions GPIO_LINE_DIRECTION_IN and
GPIO_LINE_DIRECTION_OUT are not used.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/gpio/gpiolib.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 104ed299d5ea..ed292498afb6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -226,6 +226,12 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	ret = chip->get_direction(chip, offset);
 	if (ret > 0) {
 		/* GPIOF_DIR_IN, or other positive */
+		if (ret != GPIO_LINE_DIRECTION_IN) {
+			struct gpio_device *gdev = chip->gpiodev;
+
+			dev_warn(&gdev->dev,
+				 "drivers should use GPIO_LINE_DIRECTION_IN\n");
+		}
 		ret = 1;
 		clear_bit(FLAG_IS_OUT, &desc->flags);
 	}
@@ -1389,12 +1395,18 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
 	for (i = 0; i < chip->ngpio; i++) {
 		struct gpio_desc *desc = &gdev->descs[i];
+		int dir;
 
 		if (chip->get_direction && gpiochip_line_is_valid(chip, i)) {
-			if (!chip->get_direction(chip, i))
+			dir = chip->get_direction(chip, i);
+			if (!dir) {
 				set_bit(FLAG_IS_OUT, &desc->flags);
-			else
+			} else {
+				if (dir != GPIO_LINE_DIRECTION_IN)
+					dev_warn(&gdev->dev,
+						 "drivers should use GPIO_LINE_DIRECTION_IN\n");
 				clear_bit(FLAG_IS_OUT, &desc->flags);
+			}
 		} else {
 			if (!chip->direction_input)
 				set_bit(FLAG_IS_OUT, &desc->flags);
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
