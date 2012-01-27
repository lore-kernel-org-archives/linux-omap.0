From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [RFC PATCH 0/2] Generic DMA bindings helpers for Device Tree
Date: Fri, 27 Jan 2012 18:27:50 +0100
Message-ID: <4F22DE96.7090605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab2A0R2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 12:28:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, Thomas Abraham <thomas.abraham@linaro.org>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi All,

Here is a first RFC to introduce a generic binding for DMA
controller and DMA request along with a couple of basic helpers
functions.

The support is very limited since the a lot of DMA controllers in
ARM SoCs are far for being adapted to dmaengine. At least this is
the case for OMAP.

It is thus a little bit harder to handle that the same way GPIO is
doing thanks to the gpiolib and provide a dmaengine pointer to the
user.

For the moment the API is just returning the DMA controller device_node
to the driver + the DMA request number.

I added as well for legacy purpose the dma to resource API, because
it is still widely us in ARM SoC in general.

I found at least two custom DMA bindings that could be replaced by a
generic one for my point of view.

    commit bf55499e6ee927e047feed85349365481289bd75 
    Stephen Warren <swarren@nvidia.com>
    ASoC: Tegra I2S: Add device tree binding

    commit 93ed55441245a39e3935f5cf1af3e22febcce905
    Thomas Abraham <thomas.abraham@linaro.org>
    DMA: PL330: Add device tree support


That generic DMA support is indeed pretty basic for the moment, but I
think it can still help a couple of platforms.

Comments are welcome.

Thanks,
Benoit


Benoit Cousson (2):
  of: Add generic device tree DMA helpers
  arm/dts: OMAP4: Add dma-controller and dma-request for I2C

 Documentation/devicetree/bindings/dma/dma.txt |   44 +++++++++
 arch/arm/boot/dts/omap4.dtsi                  |   15 +++
 drivers/of/Kconfig                            |    5 +
 drivers/of/Makefile                           |    1 +
 drivers/of/dma.c                              |  130 +++++++++++++++++++++++++
 include/linux/of_dma.h                        |   49 +++++++++
 6 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h
