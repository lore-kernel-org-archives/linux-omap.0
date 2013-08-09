From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [RFC PATCH v2 0/3] DWC3 USB support for Qualcomm platform
Date: Fri,  9 Aug 2013 12:53:44 +0300
Message-ID: <1376042027-9798-1-git-send-email-iivanov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: balbi@ti.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, gregkh@linuxfoundation.org, grant.likely@linaro.org, idos@codeaurora.org, mgautam@codeaurora.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Ivan T. Ivanov" <iivanov@mm-sol.com>
List-Id: linux-omap@vger.kernel.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

Hi,

These patches add basic support for USB3.0 controllers found
on MSM platforms. USB3.0 core is based on Synopsys DesignWare 
SuperSpeed IP. 

Changes since first version:
* Split devicetree bindings description file to separate patch
* Address comments for device bindings description
* Fix typo in 'gdsc' requlator name.

With fake regulators and clocks support drivers could be successfully 
loaded, but nothing more, of course.

Generated on top of Felipe 'testing' branch.

Regards,
Ivan

Ivan T. Ivanov (3):
  usb: dwc3: msm: Add device tree binding information
  usb: phy: Add Qualcomm SS-USB and HS-USB drivers for DWC3 core
  usb: dwc3: Add Qualcomm DWC3 glue layer driver

 .../devicetree/bindings/usb/msm-ssusb.txt          |  101 +++++
 drivers/usb/dwc3/Kconfig                           |    8 +
 drivers/usb/dwc3/Makefile                          |    1 +
 drivers/usb/dwc3/dwc3-msm.c                        |  174 +++++++++
 drivers/usb/phy/Kconfig                            |   11 +
 drivers/usb/phy/Makefile                           |    2 +
 drivers/usb/phy/phy-msm-dwc3-hs.c                  |  340 +++++++++++++++++
 drivers/usb/phy/phy-msm-dwc3-ss.c                  |  387 ++++++++++++++++++++
 8 files changed, 1024 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/msm-ssusb.txt
 create mode 100644 drivers/usb/dwc3/dwc3-msm.c
 create mode 100644 drivers/usb/phy/phy-msm-dwc3-hs.c
 create mode 100644 drivers/usb/phy/phy-msm-dwc3-ss.c

-- 
1.7.9.5
