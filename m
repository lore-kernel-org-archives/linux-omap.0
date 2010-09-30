From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Few omap1 patches for v2.6.37 merge window
Date: Thu, 30 Sep 2010 11:46:13 -0700
Message-ID: <20100930184459.12052.14542.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50463 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0I3SqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:46:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap1 related patches I've picked up for the upcoming
merge window.

Regards,

Tony

---

Janusz Krzysztofik (3):
      OMAP1: Add support for SoC camera interface
      OMAP1: Amstrad Delta: add support for camera
      OMAP1: Amstrad Delta: add camera controlled LEDS trigger


 arch/arm/mach-omap1/board-ams-delta.c     |   69 +++++++++++++++++++++++++++++
 arch/arm/mach-omap1/devices.c             |   43 ++++++++++++++++++
 arch/arm/mach-omap1/include/mach/camera.h |   11 +++++
 3 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/camera.h

-- 
Signature
