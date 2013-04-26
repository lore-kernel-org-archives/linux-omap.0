From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] WLAN support for omap4 when booted with devicetree
Date: Thu, 25 Apr 2013 20:52:07 -0700
Message-ID: <20130426034858.26065.65118.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41437 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757397Ab3DZDwK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Apr 2013 23:52:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some patches against linux next to make WLAN to work with
device tree. Note that we still are initializing wl12xx with pdata,
but so far it looks like only minimal binding for it is needed.

There are various fixes pending posted recently, but at least the
fix "[PATCH] mmc: omap_hsmmc: Fix the DT pbias workaround for MMC
controllers 2 to 5" is needed.

Please test on blaze/sdp if you have a chance, I don't have the
connectivity card on mine.

Regards,

Tony

---

Tony Lindgren (3):
      ARM: OMAP2+: Legacy support for wl12xx when booted with devicetree
      ARM: dts: Add muxing for wl12xx on the SDIO bus for pandaboard
      ARM: dts: Add muxing for wl12xx on the SDIO bus for blaze


 arch/arm/boot/dts/omap4-panda-common.dtsi |   43 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap4-sdp.dts           |   39 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c             |   39 ++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 2 deletions(-)

-- 
Signature
