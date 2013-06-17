From: Kevin Hilman <khilman@linaro.org>
Subject: [GIT PULL] OMAP: PM: voltagedomain cleanup for v3.11
Date: Mon, 17 Jun 2013 11:14:06 -0700
Message-ID: <87r4g08v0x.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37646 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab3FQSOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 14:14:10 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so3111681pab.35
        for <linux-omap@vger.kernel.org>; Mon, 17 Jun 2013 11:14:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.11/voltdm

for you to fetch changes up to 63b0420c85096d4bb1a3ba365dbf6b970a58b8f7:

  ARM: AM33xx: Remove the unused voltagedomain data (2013-06-17 07:26:44 -0700)

----------------------------------------------------------------
OMAP: PM: remove requirement for voltage domain data; remove dummy data

----------------------------------------------------------------
Rajendra Nayak (2):
      ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm associated to a pwrdm
      ARM: AM33xx: Remove the unused voltagedomain data

 arch/arm/mach-omap2/Makefile                  |  1 -
 arch/arm/mach-omap2/io.c                      |  1 -
 arch/arm/mach-omap2/powerdomain.c             |  5 ++++
 arch/arm/mach-omap2/powerdomain.h             |  2 ++
 arch/arm/mach-omap2/prm33xx.c                 |  7 +++++
 arch/arm/mach-omap2/voltage.h                 |  1 -
 arch/arm/mach-omap2/voltagedomains33xx_data.c | 43 ---------------------------
 7 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
