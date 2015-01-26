From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap changes to make dm816x usable
Date: Mon, 26 Jan 2015 13:08:19 -0800
Message-ID: <25162.8869715661$1422306713@news.gmane.org>
References: <pull-1422306429-777451>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.ore.mailhop.org ([54.149.88.251]:43379 "EHLO
	smtp3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbbAZVLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 16:11:47 -0500
In-Reply-To: <pull-1422306429-777451>
In-Reply-To: <pull-1422306429-777451>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 13efcb188984f69e1f97b4d9e7d3663fb782946f:

  ARM: OMAP2+: Disable omap3 PM init for ti81xx (2015-01-14 17:37:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/dm816x-data

for you to fetch changes up to 4d38bd1237f5bb67c3d5d183fc41db4bf4dbfb6b:

  ARM: OMAP2+: Add dm816x hwmod support (2015-01-26 09:26:32 -0800)

----------------------------------------------------------------
Patches to add necessary SoC related clockdomain and interconnect
data  to make dm816x boot with basic devices. This finally gets
dm816x into a usable shape for further work to happen after a few
years of stalled effort of making this SoC to work with the mainline
kernel.

As most of the devices are similar to the other omap variants, we
get at least serial, MMC, Ethernet, I2C, EDMA, pinctrl, SPI and GPMC
working for these SoCs with the related device tree changes.

----------------------------------------------------------------
Aida Mynzhasova (1):
      ARM: OMAP2+: Add clock domain support for dm816x

Tony Lindgren (2):
      ARM: OMAP2+: Add board-generic.c entry for ti81xx
      ARM: OMAP2+: Add dm816x hwmod support

 arch/arm/mach-omap2/Makefile                |    4 +
 arch/arm/mach-omap2/board-generic.c         |   36 +
 arch/arm/mach-omap2/clockdomain.h           |    1 +
 arch/arm/mach-omap2/clockdomains81xx_data.c |  194 +++++
 arch/arm/mach-omap2/cm81xx.h                |   61 ++
 arch/arm/mach-omap2/io.c                    |   82 +-
 arch/arm/mach-omap2/omap_hwmod.c            |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h            |    1 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 1136 +++++++++++++++++++++++++++
 9 files changed, 1478 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm81xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_81xx_data.c
