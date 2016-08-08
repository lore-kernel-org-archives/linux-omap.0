From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] ADC: Fix bugs related to oneshot read
Date: Mon, 8 Aug 2016 16:34:59 +0530
Message-ID: <20160808110501.29586-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, "Andrew F . Davis" <afd@ti.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org



This series fixes a couple of bugs related to simultaneous read of
multiple ADC channels in oneshot mode. Since, all channels share FIFO1,
it has to be protected using a mutex, implemented by patch 1. Patch 2
increases the timeout waiting for a ADC sample.

Vignesh R (2):
  iio: adc: ti_am335x_adc: Protect FIFO1 from concurrent access
  iio: adc: ti_am335x_adc: Increase timeout value waiting for ADC sample

 drivers/iio/adc/ti_am335x_adc.c      | 16 ++++++++++++----
 include/linux/mfd/ti_am335x_tscadc.h |  8 ++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.9.2
