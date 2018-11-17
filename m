From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Improve phy-mapphone pm
Date: Sat, 17 Nov 2018 05:37:53 -0800
Message-ID: <20181117133755.9129-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Here are two non-urgent patches to get phy-mapphone runtime PM working
better. Currently it only works when toggled from the userspace via the
sysfs entry for for "auto" and "on".

Regards,

Tony


Tony Lindgren (2):
  phy: core: Add phy_pm_runtime_enabled
  phy: mapphone-mdm6600: Improve phy related runtime PM calls

 drivers/phy/motorola/phy-mapphone-mdm6600.c | 71 +++++++++++++++------
 drivers/phy/phy-core.c                      |  9 +++
 include/linux/phy/phy.h                     |  6 ++
 3 files changed, 66 insertions(+), 20 deletions(-)

-- 
2.19.1
