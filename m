From: George Cherian <george.cherian@ti.com>
Subject: [RESEND PATCH 0/2] Add dt support for extcon gpio driver
Date: Wed, 5 Nov 2014 20:59:46 +0530
Message-ID: <1415201388-32060-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rongjun.ying@csr.com, Baohua.Song@csr.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

This series
        - Adds dt support to extcon-gpio driver.
	- Add cable name support in case of dt.

George Cherian (2):
  extcon: gpio: Add dt support for the driver
  extcon: gpio: Add support for using cable names

 drivers/extcon/extcon-gpio.c       | 87 +++++++++++++-------------------------
 include/linux/extcon/extcon-gpio.h | 59 --------------------------
 2 files changed, 29 insertions(+), 117 deletions(-)
 delete mode 100644 include/linux/extcon/extcon-gpio.h

-- 
1.8.3.1
