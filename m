From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] late omap PRCM and hwmod changes for v3.12 merge window
Date: Mon, 26 Aug 2013 07:21:36 -0700
Message-ID: <49140.9456627027$1377526912@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34647 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751429Ab3HZOVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 10:21:42 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/prcm-signed

for you to fetch changes up to eb8460e01ba632416277ea6d0f6324caa6963e4f:

  Merge tag 'for-v3.12/omap-prcm-hwmod' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.12/prcm (2013-08-26 03:18:43 -0700)

----------------------------------------------------------------

OMAP PRCM and hwmod fixes and improvments via Paul Walmsley <paul@pwsan.com>:

Various OMAP PRCM & hwmod fixes and improvements.  Notable changes
include:

- a fix for OMAP4 PLL locking to avoid a bootloader dependency that
  causes nasty log spew on startup

- AM33xx DEBUGSS support fixes in hwmod data

- OMAP5 mailbox support in hwmod data

Basic test logs are here:

http://www.pwsan.com/omap/testlogs/prcm_a_for_v3.12/20130823125002/

Note that the 3530 failure is due to the mysterious transient serial
issue affecting 3530 for several releases now, which causes a log
parsing failure.  PM still seems to work.

----------------------------------------------------------------
Aida Mynzhasova (1):
      ARM: OMAP: TI81XX: add always-on powerdomain for TI81XX

Jon Hunter (1):
      ARM: OMAP2+: Only write the sysconfig on idle when necessary

Lokesh Vutla (1):
      ARM: OMAP: AM33xx: clock: Add RNG clock data

Paul Walmsley (1):
      Merge branches 'hwmod_devel_v3.12', 'prcm_devel_v3.12' and 'am33xx_devel_v3.12' into prcm_a_for_v3.12

Rajendra Nayak (1):
      ARM: OMAP4: clock: Lock PLLs in the right sequence

Suman Anna (1):
      ARM: OMAP5: hwmod data: Add mailbox data

Tony Lindgren (1):
      Merge tag 'for-v3.12/omap-prcm-hwmod' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.12/prcm

Vaibhav Hiremath (1):
      ARM: OMAP: AM33XX: hwmod: Add hwmod data for debugSS

 arch/arm/mach-omap2/cclock33xx_data.c       |  5 +++
 arch/arm/mach-omap2/cclock44xx_data.c       | 20 +++++----
 arch/arm/mach-omap2/omap_hwmod.c            |  4 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c  | 69 ++++++++++++++++++++---------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c  | 42 ++++++++++++++++++
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  8 ++++
 arch/arm/mach-omap2/prcm-common.h           |  1 +
 7 files changed, 118 insertions(+), 31 deletions(-)
