From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for v3.16
Date: Wed, 28 May 2014 08:13:13 +0100
Message-ID: <20140528071313.GH4227@lee--X1>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34518 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbaE1HNS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 03:13:18 -0400
Received: by mail-ie0-f169.google.com with SMTP id at1so9956642iec.14
        for <linux-omap@vger.kernel.org>; Wed, 28 May 2014 00:13:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401214140-9828-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Thanks Tony, here's the pull-request:

The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73d=
e11c:

  Linux 3.14 (2014-03-30 20:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-om=
ap-v3.16-1

for you to fetch changes up to 43fef47f94a1ae46fb2720dada32fa3b5547bee2=
:

  mfd: twl4030-power: Add a configuration to turn off oscillator during=
 off-idle (2014-05-28 08:06:18 +0100)

----------------------------------------------------------------
Second immutable branch between MFD and OMAP due for the v3.16 merge wi=
ndow.

----------------------------------------------------------------
Tony Lindgren (7):
      mfd: twl-core: Fix idle mode signaling for omaps when booted with=
 device tree
      mfd: twl4030-power: Fix hang on reboot if sleep configuration was=
 loaded earlier
      mfd: twl4030-power: Fix some defines for SW_EVENTS
      mfd: twl4030-power: Add generic reset configuration
      mfd: twl4030-power: Add recommended idle configuration
      mfd: twl4030-power: Add support for board specific configuration
      mfd: twl4030-power: Add a configuration to turn off oscillator du=
ring off-idle

 .../devicetree/bindings/mfd/twl4030-power.txt      |  17 +-
 arch/arm/mach-omap2/omap_twl.c                     |  60 -----
 drivers/mfd/twl-core.c                             |  15 ++
 drivers/mfd/twl4030-power.c                        | 286 +++++++++++++=
++++++--
 include/linux/i2c/twl.h                            |   4 +
 5 files changed, 296 insertions(+), 86 deletions(-)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
