From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 0/2] Add definition for GPIO direction
Date: Wed, 6 Nov 2019 09:39:38 -0500
Message-ID: <20191106143938.GA3176@icarus>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-aspeed@lists.ozlabs.org, David Daney <david.daney@cavium.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Peter Tyser <ptyser@xes-inc.com>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jonathan Hunter <jonathanh@nvidia.com>, Fabio Estevam <festevam@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Marek Vasut <marek.vasut+renesas@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Marek Behun <marek.behun@nic.cz>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, bcm-kernel-feedback-list@broadcom.com, Joel Stanley <joel@jms.id.au>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.d>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 06, 2019 at 10:51:06AM +0200, Matti Vaittinen wrote:
> The patch series adds definitions for GPIO line directions.
> 
> For occasional GPIO contributor like me it is always a pain to remember
> whether 1 or 0 was used for GPIO direction INPUT/OUTPUT. Judging the
> fact that I removed few comments like:
> 
> /* Return 0 if output, 1 if input */
> /* This means "out" */
> return 1; /* input */
> return 0; /* output */
> 
> it seems at least some others may find it hard to remember too. Adding
> defines for these values helps us who really have good - but short
> duration - memory :]
> 
> This idea comes from RFC series for ROHM BD71828 PMIC and was initially
> discussed with Linus Walleij here:
> https://lore.kernel.org/lkml/c06725c3dd34118a324907137758d8b85b3d4043.camel@fi.rohmeurope.com/
> but as this has no dependencies to BD71828 work (which probably takes a
> while) I decided to make it independent series.
> 
> Patches are compile-tested only. I have no HW to really test them. Thus I'd
> appreciate carefull review. This work is mainly about converting zeros
> and ones to the new defines but it wouldn't be first time I get it
> wrong.
> 
> Changelog v2:
>  - squashed patches 2-61 into patch 2.
>  - dropped patch 62 (can be applied later)
>  - rebased (cherry-picked) changes on top of GPIO devel branch.
> 
> Patch 1:
>  - adds the defines
> Patch 2:
>  - convert drivers to use new defines
> 
> This patch series is based on GPIO tree devel branch.

Just a tip for future patchsets in case you didn't know, you case
specify the base of your patchset by using the "--base" option:
https://git-scm.com/docs/git-format-patch#_base_tree_information

This will append a "base-commit" line with the commit hash at the end of
the first message so that it's unabiguous which base you're using
(useful in case the branch changes before your patch is reviewed).

William Breathitt Gray

> 
> ---
> 
> Matti Vaittinen (2):
>   gpio: Add definition for GPIO direction
>   gpio: Use new GPIO_LINE_DIRECTION
> 
>  drivers/gpio/gpio-104-dio-48e.c     |  5 ++++-
>  drivers/gpio/gpio-104-idi-48.c      |  2 +-
>  drivers/gpio/gpio-104-idio-16.c     |  4 ++--
>  drivers/gpio/gpio-74xx-mmio.c       |  5 ++++-
>  drivers/gpio/gpio-amd-fch.c         |  2 +-
>  drivers/gpio/gpio-aspeed.c          |  7 +++----
>  drivers/gpio/gpio-bcm-kona.c        |  6 +++---
>  drivers/gpio/gpio-bd70528.c         |  8 +++++---
>  drivers/gpio/gpio-bd9571mwv.c       |  4 +++-
>  drivers/gpio/gpio-dln2.c            |  6 +++---
>  drivers/gpio/gpio-exar.c            |  5 ++++-
>  drivers/gpio/gpio-f7188x.c          |  5 ++++-
>  drivers/gpio/gpio-gpio-mm.c         |  5 ++++-
>  drivers/gpio/gpio-htc-egpio.c       |  5 ++++-
>  drivers/gpio/gpio-ich.c             |  5 ++++-
>  drivers/gpio/gpio-kempld.c          |  5 ++++-
>  drivers/gpio/gpio-lp873x.c          |  2 +-
>  drivers/gpio/gpio-lp87565.c         |  5 ++++-
>  drivers/gpio/gpio-madera.c          |  5 ++++-
>  drivers/gpio/gpio-max3191x.c        |  2 +-
>  drivers/gpio/gpio-merrifield.c      |  5 ++++-
>  drivers/gpio/gpio-mmio.c            | 21 +++++++++++++++------
>  drivers/gpio/gpio-mockup.c          | 11 +++--------
>  drivers/gpio/gpio-moxtet.c          |  4 ++--
>  drivers/gpio/gpio-mvebu.c           |  5 ++++-
>  drivers/gpio/gpio-mxs.c             |  5 ++++-
>  drivers/gpio/gpio-omap.c            |  6 ++++--
>  drivers/gpio/gpio-pca953x.c         |  5 ++++-
>  drivers/gpio/gpio-pci-idio-16.c     |  4 ++--
>  drivers/gpio/gpio-pcie-idio-24.c    |  9 ++++++---
>  drivers/gpio/gpio-pisosr.c          |  2 +-
>  drivers/gpio/gpio-pl061.c           |  5 ++++-
>  drivers/gpio/gpio-raspberrypi-exp.c |  5 ++++-
>  drivers/gpio/gpio-rcar.c            |  5 ++++-
>  drivers/gpio/gpio-reg.c             |  3 ++-
>  drivers/gpio/gpio-sa1100.c          |  5 ++++-
>  drivers/gpio/gpio-sama5d2-piobu.c   |  7 ++++---
>  drivers/gpio/gpio-sch.c             |  5 ++++-
>  drivers/gpio/gpio-sch311x.c         |  5 ++++-
>  drivers/gpio/gpio-siox.c            |  4 ++--
>  drivers/gpio/gpio-stmpe.c           |  5 ++++-
>  drivers/gpio/gpio-tc3589x.c         |  5 ++++-
>  drivers/gpio/gpio-tegra.c           |  5 ++++-
>  drivers/gpio/gpio-tegra186.c        |  4 ++--
>  drivers/gpio/gpio-thunderx.c        |  5 ++++-
>  drivers/gpio/gpio-tpic2810.c        |  2 +-
>  drivers/gpio/gpio-tps65086.c        |  2 +-
>  drivers/gpio/gpio-tps65912.c        |  4 ++--
>  drivers/gpio/gpio-tps68470.c        |  6 +++---
>  drivers/gpio/gpio-tqmx86.c          |  5 ++++-
>  drivers/gpio/gpio-ts4900.c          |  5 ++++-
>  drivers/gpio/gpio-twl4030.c         | 10 +++++-----
>  drivers/gpio/gpio-twl6040.c         |  3 +--
>  drivers/gpio/gpio-uniphier.c        |  5 ++++-
>  drivers/gpio/gpio-wcove.c           |  7 +++++--
>  drivers/gpio/gpio-ws16c48.c         |  5 ++++-
>  drivers/gpio/gpio-xgene.c           |  5 ++++-
>  drivers/gpio/gpio-xra1403.c         |  5 ++++-
>  drivers/gpio/gpio-xtensa.c          |  4 ++--
>  drivers/gpio/gpio-zynq.c            |  7 +++++--
>  include/linux/gpio/driver.h         |  3 +++
>  61 files changed, 214 insertions(+), 102 deletions(-)
> 
> -- 
> 2.21.0
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 
