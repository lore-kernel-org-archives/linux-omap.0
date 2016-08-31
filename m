From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due for
 the v4.9 merge window
Date: Wed, 31 Aug 2016 13:24:35 +0100
Message-ID: <20160831122435.GD9415@dell>
References: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Enjoy!

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-regulator-v4.9

for you to fetch changes up to f618ed218dc01207882a8f02b1310c7daaf5156a:

  regulator: lp873x: Change the MFD config option as per latest naming (2016-08-31 13:20:44 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO and Regulator due for the v4.9 merge window

----------------------------------------------------------------
Keerthy (3):
      mfd: lp873x: Add lp873x PMIC support
      gpio: lp873x: Add support for General Purpose Outputs
      regulator: lp873x: Change the MFD config option as per latest naming

 drivers/gpio/Kconfig       |  10 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-lp873x.c | 193 ++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig        |  14 +++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/lp873x.c       |  99 +++++++++++++++++
 drivers/regulator/Kconfig  |   2 +-
 include/linux/mfd/lp873x.h | 269 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 589 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-lp873x.c
 create mode 100644 drivers/mfd/lp873x.c
 create mode 100644 include/linux/mfd/lp873x.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
