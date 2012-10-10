From: Vikas C Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH 0/3] USB: dwc3: Add suspend/resume support
Date: Wed, 10 Oct 2012 19:35:46 +0530
Message-ID: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45667 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab2JJOBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 10:01:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, Vikas Sajjan <vikas.sajjan@linaro.org>

From: Vikas Sajjan <vikas.sajjan@linaro.org>

This patchset adds suspend/resume functionality to dwc3-core layer
and xhci-platform driver. It also adds S2R support to dwc3-exynos
glue layer.

Based on 'usb-next' branch.

Vikas Sajjan (3):
  usb: dwc3: Add the suspend/resume functionality
  usb: xhci: Add the suspend/resume functionality
  exynos5: usb: dwc3: Add the suspend/resume functionality

 drivers/usb/dwc3/core.c        |  268 +++++++++++++++++++++++++---------------
 drivers/usb/dwc3/dwc3-exynos.c |   60 +++++++++
 drivers/usb/host/xhci-plat.c   |   44 +++++++
 3 files changed, 273 insertions(+), 99 deletions(-)

-- 
1.7.6.5

