From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
Date: Thu, 13 Jun 2013 15:38:42 +0530
Message-ID: <1371118124-15910-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59127 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab3FMKJ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 06:09:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi,

The powerdomain framework today expects to always have a voltagedomain
associated with a given powerdomain. We already have AM33xx which
has no Voltage Controller/Voltage Processor as part of PRCM.
There are more SoCs' to follow starting with AM437x and DRA7xx
which do not have VC/VP.

Instead of adding dummy voltage domain data files, make the powerdomain
framework aware of the fact that some SoCs' might not really have
scalable voltage domains.

Patches are based of 3.10-rc5 and are boot tested on am335x bone.

Rajendra Nayak (2):
  ARM: OMAP2+: Powerdomain: Remove the need to always have a
    voltdm associated to a pwrdm
  ARM: AM33xx: Remove the unused voltagedomain data

 arch/arm/mach-omap2/Makefile                  |    1 -
 arch/arm/mach-omap2/io.c                      |    1 -
 arch/arm/mach-omap2/powerdomain.c             |    5 +++
 arch/arm/mach-omap2/powerdomain.h             |    2 ++
 arch/arm/mach-omap2/prm33xx.c                 |    7 ++++
 arch/arm/mach-omap2/voltage.h                 |    1 -
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 -------------------------
 7 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c

-- 
1.7.9.5

