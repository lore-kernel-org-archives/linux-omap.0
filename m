From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP2+: Add AM335x and AM3517/05 EVM DT support
Date: Fri, 11 May 2012 14:47:45 +0200
Message-ID: <4FAD0A71.80201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59023 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759501Ab2EKMsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 08:48:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Tony,

Here are some remaining DT patches I was not able to push at 3.4 due to some missing dependency.
It applies now fine on top of lo/dt branch.

Regards,
Benoit


The following changes since commit 40364b9f5a4d167d97bb6a76cd239ca8cfff056a:
  Benoit Cousson (1):
        arm/dts: omap4-panda: Add LEDs support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.5/dts/am33xx

Vaibhav Hiremath (3):
      arm/dts: Add support for TI AM335x EVM board
      arm/dts: omap3-evm: Add i2c and twl4030 support
      arm/dts: Add support for TI AM3517/05 EVM board

 arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am3517-evm.dts |   32 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-evm.dts  |   28 +++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-evm.dts
 create mode 100644 arch/arm/boot/dts/am3517-evm.dts
