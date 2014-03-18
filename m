From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/2] extcon: of: Update OF helper function
Date: Tue, 18 Mar 2014 21:04:38 +0900
Message-ID: <1395144280-23240-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, myungjoo.ham@samsung.com
Cc: kishon@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-omap@vger.kernel.org

Thisp patchset remove unnecessary function call in of_extcon_get_extcon_dev()
which get the extcon device from devicetree. Also, this patchset move OF helper func
to extcon core and change function name as following:
- of_extcon_get_extcon_dev() -> extcon_get_edev_by_phandle()

Chanwoo Choi (2):
  extcon: of: Remove unnecessary function call by using the name of device_node
  extcon: Move OF helper function to extcon core and change function name

 drivers/extcon/Kconfig           |  4 ---
 drivers/extcon/Makefile          |  2 --
 drivers/extcon/extcon-class.c    | 43 +++++++++++++++++++++++++++
 drivers/extcon/of_extcon.c       | 64 ----------------------------------------
 drivers/usb/dwc3/dwc3-omap.c     |  3 +-
 include/linux/extcon.h           | 12 ++++++++
 include/linux/extcon/of_extcon.h | 31 -------------------
 7 files changed, 56 insertions(+), 103 deletions(-)
 delete mode 100644 drivers/extcon/of_extcon.c
 delete mode 100644 include/linux/extcon/of_extcon.h

-- 
1.8.0
