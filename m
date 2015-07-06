From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PULL gpio-for-next] gpio: make flags mandatory for gpiod_get
 functions
Date: Mon, 6 Jul 2015 11:07:59 +0200
Message-ID: <20150706090759.GS11824@pengutronix.de>
References: <1434404169-4639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434404169-4639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, kernel@pengutronix.de, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Charles Gorand <charles.gorand@effinnov.com>, Daniel Mack <daniel@zonque.org>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Irina Tirdea <irina.tirdea@intel.com>, Jonathan Cameron <jic23@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-nfc@ml01.01.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Mauro Carvalho Chehab <mchehab@o>
List-Id: linux-omap@vger.kernel.org

Hello,

now that all patches that were in next hit Linus Torvalds' tree and
v4.2-rc1 is out here comes the promised pull request that makes usage o=
f
the flags parameter mandatory for gpiod_get et al:

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f=
0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/gpiod-flags-for-4.3

for you to fetch changes up to b17d1bf16cc72a374a48d748940f700009d40ff4=
:

  gpio: make flags mandatory for gpiod_get functions (2015-07-06 10:39:=
24 +0200)

----------------------------------------------------------------
The last patch in this series makes the flags parameter for the various
gpiod_get* functions mandatory and so allows to remove an ugly cpp hack
introduced in commit 39b2bbe3d715 (gpio: add flags argument to gpiod_ge=
t*()
functions) for v3.17-rc1.

The other nine commits fix the last remaining users of these functions =
that
don't pass flags yet. (Only etraxfs-uart wasn't fixed; this driver's us=
e of the
gpiod functions needs fixing anyhow.)

----------------------------------------------------------------

According to the coccinelle-script I wrote all users (apart from
etraxfs-uart) are fixed now.

As some of the maintainers requested it, I'll resend the patches
contained in this series as a reply to this mail.

It would be great if this could be put into next via the gpio tree to
give new users enough time to adapt their patches.

Thanks
Uwe

Uwe Kleine-K=F6nig (10):
      drm/msm/dp: use flags argument of devm_gpiod_get to set direction
      drm/tilcdc: panel: make better use of gpiod API
      iio: light: stk3310: use flags argument of devm_gpiod_get
      iio: magn: bmc150: use flags argument of devm_gpiod_get
      media: i2c/adp1653: set enable gpio to output
      NFC: nxp-nci_i2c: use flags argument of devm_gpiod_get_index
      phy: tusb1210: make better use of gpiod API
      usb: dwc3: pci: make better use of gpiod API
      usb: pass flags parameter to gpiod_get functions
      gpio: make flags mandatory for gpiod_get functions

 drivers/gpio/devres.c                  | 18 ++++----
 drivers/gpio/gpiolib.c                 | 16 +++----
 drivers/gpu/drm/msm/edp/edp_ctrl.c     | 17 +------
 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 22 +++------
 drivers/iio/light/stk3310.c            |  6 +--
 drivers/iio/magnetometer/bmc150_magn.c |  6 +--
 drivers/media/i2c/adp1653.c            |  2 +-
 drivers/nfc/nxp-nci/i2c.c              | 10 ++---
 drivers/phy/phy-tusb1210.c             | 30 +++++--------
 drivers/usb/dwc3/dwc3-pci.c            | 26 ++++++-----
 drivers/usb/gadget/udc/pxa27x_udc.c    |  2 +-
 drivers/usb/phy/phy-generic.c          |  6 ++-
 include/linux/gpio/consumer.h          | 82 ++++++++++----------------=
--------
 13 files changed, 88 insertions(+), 155 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
