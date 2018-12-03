From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and IIO due for the v4.21
 merge window
Date: Mon, 3 Dec 2018 11:34:50 +0000
Message-ID: <20181203113450.GM26661@dell>
References: <20181203080118.17504-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181203080118.17504-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Enjoy!

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-v4.21

for you to fetch changes up to 4b3ab9372ffa569827c8f7b7ffc7b69ba544a3bd:

  iio: adc: ti_am335x_tscadc: Improve accuracy of measurement (2018-12-03 11:33:20 +0000)

----------------------------------------------------------------
Immutable branch between MFD and IIO due for the v4.21 merge window

----------------------------------------------------------------
Vignesh R (2):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
      iio: adc: ti_am335x_tscadc: Improve accuracy of measurement

 drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-
 drivers/mfd/ti_am335x_tscadc.c       | 5 +++--
 include/linux/mfd/ti_am335x_tscadc.h | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
