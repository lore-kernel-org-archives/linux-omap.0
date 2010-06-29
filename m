From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] omap Kconfig improvments for 2.6.36 merge window
Date: Tue, 29 Jun 2010 14:47:08 +0300
Message-ID: <20100629113229.16008.2931.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63670 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab0F2LrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:47:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some Kconfig improvments to produce a mostly sane .config for
omap2/3/4 without a defconfig. This assumes that CONFIG_ARCH_OMAP is
selected, for example with:

$ echo "CONFIG_ARCH_OMAP=y" > .config && yes "" | ARCH=arm make oldconfig

or

$ rm .config; ARCH=arm make xconfig, then select System Type -> TI OMAP

Regards,

Tony

---

Tony Lindgren (6):
      omap: Disable VGA console for omaps
      omap: Use 32KiHZ timer by default
      omap: Make omap specific features appear under Kconfig menu
      omap2/3/4: Move Kconfig options to mach-omap2/Kconfig
      omap2/3/4: Select all omaps and boards by default
      omap2/3/4: Add Kconfig option to compile in typical omap features


 arch/arm/mach-omap1/Kconfig   |    7 ++++
 arch/arm/mach-omap2/Kconfig   |   74 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig    |   22 +-----------
 drivers/video/console/Kconfig |    2 +
 4 files changed, 84 insertions(+), 21 deletions(-)

-- 
Signature
