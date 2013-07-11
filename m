From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/2] Fix omap serial early crash during hwmod _setup()
Date: Thu, 11 Jul 2013 16:23:03 +0530
Message-ID: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44608 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab3GKKxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 06:53:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

This series should fix the issue with the early serial crash seen
during hwmod _setup() as reported by [1]

The issue was reported on a am33xx device and was not seen on omap4
or omap5 devices as the hwmod data for both omap4 and omap5 had
statically defined HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET for
uart3 which happens to be the debug console used on omap4 panda and
omap5 uevm boards.

The series reverts the patch which stubbed out omap_serial_early_init()
for DT boot and gets rid of the static flags in omap4 and omap5 hwmod
data.

This series along with the patch posted by Felipe [2] should fix the
issue reported by [1] completely and boot to prompt on a am33xx device
with LL_DEBUG enabled.

I have boot tested this series (along with [2]) on a omap4 panda es and
a am335x boneblack.

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/100628

[2] http://marc.info/?l=linux-omap&m=137353783912736&w=2

Rajendra Nayak (2):
  Revert "ARM: OMAP2+: Fix serial init for device tree based booting"
  ARM: OMAP4+: Get rid of the HWMOD_INIT_NO_IDLE and
    HWMOD_INIT_NO_RESET flags for uart

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    1 -
 arch/arm/mach-omap2/serial.c               |    3 ---
 3 files changed, 1 insertion(+), 6 deletions(-)

-- 
1.7.9.5

