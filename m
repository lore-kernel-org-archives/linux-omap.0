From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 0/7] dwc3 - bug fixes and use meaningful goto labels
Date: Fri, 24 Mar 2017 18:04:58 -0600
Message-ID: <cover.1490387086.git.shuahkh@osg.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch series consists of two fixes and changes to goto labels
to use meaningful names.

While working on goto label changes, I noticed  put_sync calls without
successful get_sync in error legs.  The first two patches are the fixes
and the rest of the patches are goto label changes.


Shuah Khan (7):
  usb: dwc3: core: fix dwc3_probe() to not do put_sync when get_sync
    fails
  usb: dwc3: dwc3-omap: fix dwc3_omap_probe() do put_sync when get_sync
    works
  usb: dwc3: core: change goto labels to meaningful names
  usb: dwc3: exynos: change goto labels in this file to meaningful names
  usb: dwc3: omap: change goto labels in this file to meaningful names
  usb: dwc3: gadget: change goto labels in this file to meaningful names
  usb: dwc3: host: change goto labels in this file to meaningful names

 drivers/usb/dwc3/core.c        | 64 +++++++++++++++++++++---------------------
 drivers/usb/dwc3/dwc3-exynos.c | 16 +++++------
 drivers/usb/dwc3/dwc3-omap.c   | 11 ++++----
 drivers/usb/dwc3/gadget.c      | 56 ++++++++++++++++++------------------
 drivers/usb/dwc3/host.c        | 10 +++----
 5 files changed, 79 insertions(+), 78 deletions(-)

-- 
2.7.4
