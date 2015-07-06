From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 0/5] ATAGs to DT patches
Date: Mon,  6 Jul 2015 22:26:08 +0200
Message-ID: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch series converts some legacy ATAGs into DT and provide them t=
o
userspace. It is needed for userspace applications which needs some
informations from legacy bootloaders which are not DT compatible.

Patch series is for now without DT documentation files. It was tested i=
n
QEMU for Nokia N900. File /proc/cpuinfo contains correct "Revision" lin=
e
from ATAG_REVISION and /proc/atags contains full ATAGs structure.

Pali Roh=C3=A1r (5):
  arm: devtree: Set system_rev from DT "/revision"
  arm: boot: convert ATAG_REVISION to DT "/revision" entry
  arm: atags: Fix declaration of function save_atags
  arm: devtree: Read ATAGs structure from DT "/chosen/linux,atags"
    entry
  arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry

 arch/arm/boot/compressed/atags_to_fdt.c |    8 ++++++-
 arch/arm/kernel/atags.h                 |    4 ++--
 arch/arm/kernel/devtree.c               |   36 +++++++++++++++++++++++=
+++++---
 3 files changed, 42 insertions(+), 6 deletions(-)

--=20
1.7.9.5
