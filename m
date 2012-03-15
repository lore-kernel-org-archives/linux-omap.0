From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi, regulator and mmc DTS
 updates
Date: Wed, 14 Mar 2012 17:46:38 -0700
Message-ID: <20120315004638.GW12083@atomide.com>
References: <4F612C29.40608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47450 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031266Ab2COAqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 20:46:42 -0400
Content-Disposition: inline
In-Reply-To: <4F612C29.40608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>

Hi,

* Cousson, Benoit <b-cousson@ti.com> [120314 16:41]:
> Hi Tony,
> 
> Here are the remaining DTS patches for 3.4.
> 
> On top of the previous pull request, I just added the MMC DTS since the driver adaptation just got queued.
> 
> It will be still be good to have that for 3.4 if possible, otherwise we will have a bunch of drivers DT adapted but no DTS file to use them :-(

This might be doable as a follow-up patch series at the end
of the merge window or at -rc1 when the related driver changes
have been merged.

Arnd and Olof, what do you guys think?

Regards,

Tony

 
> This series is based on your lo/dt-part2 branch.
> 
> Thanks,
> Benoit
> 
> 
> The following changes since commit 328ae2cb50af2f96b6061eb462aa92966a462bbc:
>   Ilya Yanok (1):
>         arm/dts: mt_ventoux: very basic support for TeeJet Mt.Ventoux board
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dts/all
> 
> Benoit Cousson (11):
>       arm/dts: twl6030: Add DTS file for twl6030 PMIC
>       arm/dts: twl4030: Add DTS file for twl4030 PM + Audio IC
>       arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
>       arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
>       arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
>       ARM: OMAP2+: board-generic: Remove i2c static init
>       arm/dts: OMAP4: Add gpio nodes
>       arm/dts: OMAP3: Add gpio nodes
>       arm/dts: OMAP4: Add SPI controller nodes
>       arm/dts: OMAP3: Add SPI controller nodes
>       arm/dts: omap4-sdp: Add ks8851 ethernet SPI device
> 
> Rajendra Nayak (3):
>       arm/dts: twl: Pass regulator data from dt
>       arm/dts: OMAP4: Add mmc controller nodes and board data
>       arm/dts: OMAP3: Add mmc controller nodes and board data
> 
>  arch/arm/boot/dts/omap3-beagle.dts  |   49 +++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi        |  102 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4-panda.dts   |   56 +++++++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts     |   97 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi        |  117 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/twl4030.dtsi      |   39 ++++++++++++
>  arch/arm/boot/dts/twl6030.dtsi      |   86 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-generic.c |   37 +----------
>  arch/arm/mach-omap2/devices.c       |    4 +-
>  arch/arm/mach-omap2/gpio.c          |    8 ++-
>  10 files changed, 557 insertions(+), 38 deletions(-)
>  create mode 100644 arch/arm/boot/dts/twl4030.dtsi
>  create mode 100644 arch/arm/boot/dts/twl6030.dtsi
> 
