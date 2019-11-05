From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 12:09:10 +0200
Message-ID: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
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

The patch series adds definitions for GPIO line directions.

For occasional GPIO contributor like me it is always a pain to remember
whether 1 or 0 was used for GPIO direction INPUT/OUTPUT. Judging the
fact that I removed few comments like:

/* Return 0 if output, 1 if input */
/* This means "out" */
return 1; /* input */
return 0; /* output */

it seems at least some others may find it hard to remember too. Adding
defines for these values helps us who really have good - but short
duration - memory :]

Please also see the last patch. It adds warning prints to be emitted
from gpiolib if other than defined values are used. This patch can be
dropped out if there is a reason for that to still be allowed.

This idea comes from RFC series for ROHM BD71828 PMIC and was initially
discussed with Linus Walleij here:
https://lore.kernel.org/lkml/c06725c3dd34118a324907137758d8b85b3d4043.camel@fi.rohmeurope.com/
but as this has no dependencies to BD71828 work (which probably takes a
while) I decided to make it independent series.

Patches are compile-tested only. I have no HW to really test them. Thus I'd
appreciate carefull review. This work is mainly about converting zeros
and ones to the new defines but it wouldn't be first time I get it wrong
in one of the patches :)

Patch 1:
 - adds the defines
Patches 2 - 61:
 - convert drivers to use new defines
Patch 62:
 - Add warning print if values other than the defines is used for direction.

Patches are created on top of Linux v5.4-rc6.

--

Matti Vaittinen (62):
  gpio: Add definition for GPIO direction
  gpio: gpio-104-dio-48e: Use new GPIO_LINE_DIRECTION
  gpio: add gpio-104-idi-48: Use new GPIO_LINE_DIRECTION
  gpio: gpio-104-idio-16: Use new GPIO_LINE_DIRECTION
  gpio: gpio-74xx-mmio: Use new GPIO_LINE_DIRECTION
  gpio: gpio-amd-fch: Use new GPIO_LINE_DIRECTION
  gpio: gpio-aspeed: Use new GPIO_LINE_DIRECTION
  gpio: gpio-bcm-kona: Use new GPIO_LINE_DIRECTION
  gpio: gpio-bd70528: Use new GPIO_LINE_DIRECTION
  gpio: gpio-bd9571mwv: Use new GPIO_LINE_DIRECTION
  gpio: gpio-dln2: Use new GPIO_LINE_DIRECTION
  gpio: gpio-exar: Use new GPIO_LINE_DIRECTION
  gpio: gpio-f7188x: Use new GPIO_LINE_DIRECTION
  gpio: gpio-gpio-mm: Use new GPIO_LINE_DIRECTION
  gpio: gpio-htc-egpio: Use new GPIO_LINE_DIRECTION
  gpio: gpio-ich: Use new GPIO_LINE_DIRECTION
  gpio: gpio-kempld: Use new GPIO_LINE_DIRECTION
  gpio: gpio-lp873x: Use new GPIO_LINE_DIRECTION
  gpio: gpio-lp87565: Use new GPIO_LINE_DIRECTION
  gpio: gpio-madera: Use new GPIO_LINE_DIRECTION
  gpio: gpio-max3191x: Use new GPIO_LINE_DIRECTION
  gpio: gpio-mmio: Use new GPIO_LINE_DIRECTION
  gpio: gpio-merrifield: Use new GPIO_LINE_DIRECTION
  gpio: gpio-mockup: Use new GPIO_LINE_DIRECTION
  gpio: gpio-moxtet: Use new GPIO_LINE_DIRECTION
  gpio: gpio-mvebu: Use new GPIO_LINE_DIRECTION
  gpio: gpio-mxs: Use new GPIO_LINE_DIRECTION
  gpio: gpio-omap: Use new GPIO_LINE_DIRECTION
  gpio: gpio-pca953x: Use new GPIO_LINE_DIRECTION
  gpio: gpio-pcie-idio-24: Use new GPIO_LINE_DIRECTION
  gpio: gpio-pci-idio-16: Use new GPIO_LINE_DIRECTION
  gpio: gpio-pisosr: Use new GPIO_LINE_DIRECTION
  gpio: gpio-pl061: Use new GPIO_LINE_DIRECTION
  gpio: gpio-raspberrypi-exp: Use new GPIO_LINE_DIRECTION
  gpio: gpio-rcar: Use new GPIO_LINE_DIRECTION
  gpio: gpio-reg: Use new GPIO_LINE_DIRECTION
  gpio: gpio-sama5d2-piobu: Use new GPIO_LINE_DIRECTION
  gpio: gpio-sch311x: Use new GPIO_LINE_DIRECTION
  gpio: gpio-sch: Use new GPIO_LINE_DIRECTION
  gpio: gpio-siox: Use new GPIO_LINE_DIRECTION
  gpio: gpio-stmpe: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tc3589x: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tegra186: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tegra: Use new GPIO_LINE_DIRECTION
  gpio: gpio-thunderx: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tpic2810: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tps65086: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tps65912: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tps68470: Use new GPIO_LINE_DIRECTION
  gpio: gpio-tqmx86: Use new GPIO_LINE_DIRECTION
  gpio: gpio-ts4900: Use new GPIO_LINE_DIRECTION
  gpio: gpio-twl4030: Use new GPIO_LINE_DIRECTION
  gpio: gpio-twl6040: Use new GPIO_LINE_DIRECTION
  gpio: gpio-uniphier: Use new GPIO_LINE_DIRECTION
  gpio: gpio-wcove: Use new GPIO_LINE_DIRECTION
  gpio: gpio-ws16c48: Use new GPIO_LINE_DIRECTION
  gpio: gpio-xgene: Use new GPIO_LINE_DIRECTION
  gpio: gpio-xra1403: Use new GPIO_LINE_DIRECTION
  gpio: gpio-xtensa: Use new GPIO_LINE_DIRECTION
  gpio: gpio-zynq: Use new GPIO_LINE_DIRECTION
  gpio: gpio-sa1100: Use new GPIO_LINE_DIRECTION
  gpiolib: Nag for INPUT direction values other than
    GPIO_LINE_DIRECTION_IN

 drivers/gpio/gpio-104-dio-48e.c     |  5 ++++-
 drivers/gpio/gpio-104-idi-48.c      |  2 +-
 drivers/gpio/gpio-104-idio-16.c     |  4 ++--
 drivers/gpio/gpio-74xx-mmio.c       |  5 ++++-
 drivers/gpio/gpio-amd-fch.c         |  2 +-
 drivers/gpio/gpio-aspeed.c          |  7 +++----
 drivers/gpio/gpio-bcm-kona.c        |  6 +++---
 drivers/gpio/gpio-bd70528.c         |  8 +++++---
 drivers/gpio/gpio-bd9571mwv.c       |  4 +++-
 drivers/gpio/gpio-dln2.c            |  6 +++---
 drivers/gpio/gpio-exar.c            |  5 ++++-
 drivers/gpio/gpio-f7188x.c          |  5 ++++-
 drivers/gpio/gpio-gpio-mm.c         |  5 ++++-
 drivers/gpio/gpio-htc-egpio.c       |  5 ++++-
 drivers/gpio/gpio-ich.c             |  5 ++++-
 drivers/gpio/gpio-kempld.c          |  5 ++++-
 drivers/gpio/gpio-lp873x.c          |  2 +-
 drivers/gpio/gpio-lp87565.c         |  5 ++++-
 drivers/gpio/gpio-madera.c          |  5 ++++-
 drivers/gpio/gpio-max3191x.c        |  2 +-
 drivers/gpio/gpio-merrifield.c      |  5 ++++-
 drivers/gpio/gpio-mmio.c            | 21 +++++++++++++++------
 drivers/gpio/gpio-mockup.c          | 11 +++--------
 drivers/gpio/gpio-moxtet.c          |  4 ++--
 drivers/gpio/gpio-mvebu.c           |  5 ++++-
 drivers/gpio/gpio-mxs.c             |  5 ++++-
 drivers/gpio/gpio-omap.c            |  6 ++++--
 drivers/gpio/gpio-pca953x.c         |  5 ++++-
 drivers/gpio/gpio-pci-idio-16.c     |  4 ++--
 drivers/gpio/gpio-pcie-idio-24.c    |  9 ++++++---
 drivers/gpio/gpio-pisosr.c          |  2 +-
 drivers/gpio/gpio-pl061.c           |  5 ++++-
 drivers/gpio/gpio-raspberrypi-exp.c |  5 ++++-
 drivers/gpio/gpio-rcar.c            |  5 ++++-
 drivers/gpio/gpio-reg.c             |  3 ++-
 drivers/gpio/gpio-sa1100.c          |  5 ++++-
 drivers/gpio/gpio-sama5d2-piobu.c   |  7 ++++---
 drivers/gpio/gpio-sch.c             |  5 ++++-
 drivers/gpio/gpio-sch311x.c         |  5 ++++-
 drivers/gpio/gpio-siox.c            |  4 ++--
 drivers/gpio/gpio-stmpe.c           |  5 ++++-
 drivers/gpio/gpio-tc3589x.c         |  5 ++++-
 drivers/gpio/gpio-tegra.c           |  5 ++++-
 drivers/gpio/gpio-tegra186.c        |  4 ++--
 drivers/gpio/gpio-thunderx.c        |  5 ++++-
 drivers/gpio/gpio-tpic2810.c        |  2 +-
 drivers/gpio/gpio-tps65086.c        |  2 +-
 drivers/gpio/gpio-tps65912.c        |  4 ++--
 drivers/gpio/gpio-tps68470.c        |  6 +++---
 drivers/gpio/gpio-tqmx86.c          |  5 ++++-
 drivers/gpio/gpio-ts4900.c          |  5 ++++-
 drivers/gpio/gpio-twl4030.c         | 10 +++++-----
 drivers/gpio/gpio-twl6040.c         |  3 +--
 drivers/gpio/gpio-uniphier.c        |  5 ++++-
 drivers/gpio/gpio-wcove.c           |  7 +++++--
 drivers/gpio/gpio-ws16c48.c         |  5 ++++-
 drivers/gpio/gpio-xgene.c           |  5 ++++-
 drivers/gpio/gpio-xra1403.c         |  5 ++++-
 drivers/gpio/gpio-xtensa.c          |  4 ++--
 drivers/gpio/gpio-zynq.c            |  7 +++++--
 drivers/gpio/gpiolib.c              | 16 ++++++++++++++--
 include/linux/gpio/driver.h         |  3 +++
 62 files changed, 228 insertions(+), 104 deletions(-)

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
