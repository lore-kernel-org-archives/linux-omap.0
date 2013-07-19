From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/4] dra7: I2C/MCSPI/UART pin control datas
Date: Fri, 19 Jul 2013 21:54:06 +0530
Message-ID: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36852 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759105Ab3GSQYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Jul 2013 12:24:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sourav Poddar <sourav.poddar@ti.com>

These series add support for I2C/MCSPI/UART pin control datas.

The series is done on top of Rajendra Nayak series[1](posted to the list), 
which has basic dt boot enable for dra7.
These patches has been tested, along with I2C and UART patches from
wolfram sang patch series[2]. 


[1]: http://www.spinics.net/lists/linux-omap/msg93535.html
[2]: https://lkml.org/lkml/2013/7/10/335

Sourav Poddar (4):
  arm: dts: omap5-evm: Add I2c pinctrl data
  arm: dts: omap5-evm: Add I2c pinctrl data
  arm: dts: dra7-evm: Add SPI pinctrl data
  arm: dts: dra7-evm: Add UART pinctrl data

 arch/arm/boot/dts/dra7-evm.dts |  123 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi    |   15 +++++
 2 files changed, 138 insertions(+), 0 deletions(-)

