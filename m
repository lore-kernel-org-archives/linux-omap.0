From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Few corner case fixes for ti-sysc
Date: Wed,  8 Aug 2018 01:07:02 -0700
Message-ID: <20180808080706.100389-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few corner case fixes for ti-sysc.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Fix null hwmod for ti-sysc debug
  ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
  bus: ti-sysc: Fix module register ioremap for larger offsets
  bus: ti-sysc: Fix no_console_suspend handling

 arch/arm/mach-omap2/omap_hwmod.c | 39 +++++++++++++++++++++++++++++++-
 drivers/bus/ti-sysc.c            | 35 ++++++++++++++--------------
 2 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.17.1
