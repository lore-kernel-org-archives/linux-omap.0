From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] tscadc: Couple of fixes
Date: Mon, 19 Nov 2018 12:12:34 +0530
Message-ID: <20181119064236.28902-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Couple of fixes for tscadc drivers that I found while adding support for
new SoC. Patches are standalone and can go via individual domain trees.

Vignesh R (2):
  mfd: ti_am335x_tscadc: Provide unique name for child mfd cells
  iio: adc: ti_am335x_tscadc: Improve accuracy of measurement

 drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-
 drivers/mfd/ti_am335x_tscadc.c       | 6 ++++--
 include/linux/mfd/ti_am335x_tscadc.h | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.19.1
