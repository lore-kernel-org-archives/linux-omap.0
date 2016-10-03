From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH v2 0/4] Add DMA support for ti_am335x_adc driver
Date: Mon, 3 Oct 2016 18:33:14 +0530
Message-ID: <20161003130318.12591-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, John Syne <john3909@gmail.com>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

The ADC has a 64 work depth fifo length which holds the ADC data
till the CPU reads. So when a user program needs a large ADC data
to operate on, then it has to do multiple reads to get its
buffer. Currently if the application asks for 4 samples per
channel with all 8 channels are enabled, kernel can provide only
3 samples per channel when all 8 channels are enabled (logs at
[1]). So with DMA support user can request for large number of
samples at a time (logs at [2]).

Tested the patch on AM437x-gp-evm and AM335x Boneblack with the
patch [3] to enable ADC and pushed a branch for testing [4]

Changes from Initial version:
* Changed DMA api from dma_request_slave_channel_compat() to
  dma_request_chan()
* Changed variable names to have more clear information as per
  comments from Peter.

[1] - http://pastebin.ubuntu.com/23211490/
[2] - http://pastebin.ubuntu.com/23269792/
[3] - http://pastebin.ubuntu.com/23211494/
[4] - git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git iio-dma-v2

Mugunthan V N (4):
  mfd: ti_am335x_tscadc: store physical address
  drivers: iio: ti_am335x_adc: add dma support
  ARM: dts: am33xx: add DMA properties for tscadc
  ARM: dts: am4372: add DMA properties for tscadc

 arch/arm/boot/dts/am33xx.dtsi        |   2 +
 arch/arm/boot/dts/am4372.dtsi        |   2 +
 drivers/iio/adc/ti_am335x_adc.c      | 145 ++++++++++++++++++++++++++++++++++-
 drivers/mfd/ti_am335x_tscadc.c       |   1 +
 include/linux/mfd/ti_am335x_tscadc.h |   8 ++
 5 files changed, 155 insertions(+), 3 deletions(-)

-- 
2.10.0.372.g6fe1b14
