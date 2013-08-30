From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v2 0/3] cleanup of gpio_pcf857x.c
Date: Fri, 30 Aug 2013 16:18:30 +0530
Message-ID: <1377859713-13460-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kuninori.morimoto.gx@renesas.com, n.a.balandin@gmail.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series
	- removes the irq_demux_work
	- Uses devm_request_threaded_irq
	- Call the user handler iff gpio_to_irq is done.

v1 --> v2 
	Split v1 to 3 patches

George Cherian (3):
  gpio: pcf857x: change to  devm_request_threaded_irq
  gpio: pcf857x: remove the irq_demux_work
  gpio: pcf857x: call the gpio user  handler  iff gpio_to_irq is done

 arch/arm/boot/dts/dra7-evm.dts |  6 ++---
 drivers/gpio/gpio-pcf857x.c    | 51 +++++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

-- 
1.8.1.4
