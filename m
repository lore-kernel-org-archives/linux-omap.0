From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 0/4] Thermal: Support for hardware-tracked trip points
Date: Mon, 25 Apr 2016 11:02:43 +0800
Message-ID: <1461553367-24744-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, eddie.cai@rock-chips.com, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The history patches come from Mikko and Sascha.
http://thread.gmane.org/gmane.linux.power-management.general/59451

Now, I pick them up to continue upstream.
Nevermind!

Tis series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

This series patches rebase the conflicts.
Note that the hardware-tracked trip points are very well tested currently.

Verified and tested on https://github.com/Caesar-github/rockchip/tree/wip/fixes-thermal-0425
That's based on linux-kernel 20160422.

[    0.000000] Linux version 4.6.0-rc4-next-20160422-00016-g0ac0bfb-dirty



Sascha Hauer (4):
  thermal: Add support for hardware-tracked trip points
  thermal: of: implement .set_trips for device tree thermal zones
  thermal: streamline get_trend callbacks
  thermal: bang-bang governor: act on lower trip boundary

 drivers/thermal/gov_bang_bang.c                    |  2 +-
 drivers/thermal/of-thermal.c                       | 23 ++++++-----
 drivers/thermal/thermal_core.c                     | 48 ++++++++++++++++++++++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 ++++-------
 include/linux/thermal.h                            |  9 +++-
 5 files changed, 78 insertions(+), 29 deletions(-)

-- 
1.9.1
