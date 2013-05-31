From: Benoit Cousson <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP: dts fixes for 3.10-rc4
Date: Fri, 31 May 2013 15:23:37 +0200
Message-ID: <51A8A459.1000706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38427 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3EaNYZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 09:24:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony >> \"tony@atomide.com\"" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Kevin Hilman <khilman@linaro.org>, Lars Poeschel <poeschel@lemonage.de>

Hi Tony,

Please pull two DTS fixes for the next -rc.

Thanks,
Benoit


The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:
  Linus Torvalds (1):
        Linux 3.10-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git dts-fixes-for-3.10

Kevin Hilman (1):
      ARM: dts: omap4-panda|sdp: Fix mux for twl6030 IRQ pin and msecure line

Lars Poeschel (1):
      ARM: dts: AM33xx: Fix properties on gpmc node

 arch/arm/boot/dts/am33xx.dtsi             |    4 ++--
 arch/arm/boot/dts/omap4-panda-common.dtsi |   20 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts           |   20 ++++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)
