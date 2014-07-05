From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 0/3] Add ST dwc3 glue layer driver.
Date: Sat,  5 Jul 2014 07:25:27 +0100
Message-ID: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, peppe.cavallaro@st.com
List-Id: linux-omap@vger.kernel.org

This series adds support for the ST glue logic to manage the DWC3 HC
on STiH407 SoC family chipsets.

Peter Griffin (3):
  usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
  ARM: dts: sti: Add st-dwc3 devicetree bindings documentation
  MAINTAINERS: Add dwc3-st.c file to ARCH/STI architecture

 Documentation/devicetree/bindings/usb/dwc3-st.txt |  58 ++++
 MAINTAINERS                                       |   1 +
 drivers/usb/dwc3/Kconfig                          |   9 +
 drivers/usb/dwc3/Makefile                         |   1 +
 drivers/usb/dwc3/dwc3-st.c                        | 325 ++++++++++++++++++++++
 5 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt
 create mode 100644 drivers/usb/dwc3/dwc3-st.c

-- 
1.9.1
