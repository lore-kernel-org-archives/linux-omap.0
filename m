From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/5] [input] tsc2005 cleanup
Date: Wed, 22 Jul 2015 22:04:40 +0200
Message-ID: <1437595485-16421-1-git-send-email-sre@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

The following patches simplify and cleanup the tsc2005 touchscreen driver.
Apart from making the driver more readable, the direct usage of SPI has been
reduced to one function, so that tsc2004 support may be addable now (see [0]).

Changes since PATCHv1 [1]:
 * Avoid mixing spi_*_drvdata() and dev_*_drvdata() by converting
   all spi_*_drvdata() to  dev_*_drvdata()
 * Add new patch fixing the indent of TSC2005's Kconfig entry
 * Select REGMAP_SPI in TSC2005's Kconfig entry
 * Use optional gpiod and regulator API, so that the DT check can
   be removed
 * Set TSC2005_REG_PND0 on regmap writes, since it has also been
   used before the regmap conversion.

[0] http://permalink.gmane.org/gmane.linux.kernel.input/37513
[1] https://lkml.org/lkml/2015/7/15/500

-- Sebastian

Sebastian Reichel (5):
  Input: tsc2005 - improve readability of register defines
  Input: tsc2005 - fix Kconfig indentation
  Input: tsc2005 - convert to regmap
  Input: tsc2005 - simplify drvdata acquisition
  Input: tsc2005 - convert to gpiod

 drivers/input/touchscreen/Kconfig   |   9 +-
 drivers/input/touchscreen/tsc2005.c | 262 ++++++++++++++----------------------
 2 files changed, 106 insertions(+), 165 deletions(-)

-- 
2.1.4

