From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 0/5] Thermal: Support for hardware-tracked trip points
Date: Tue,  3 May 2016 17:33:28 +0800
Message-ID: <1462268013-14992-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, Caesar Wang <wxt@rock-chips.com>, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, linux-doc@vger.kernel.org, Ni Wade <wni@nvidia.com>, linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>, Andy Champ <andycham@amazon.com>, Javi Merino <javi.merino@arm.com>, Leo Yan <leo.yan@linaro.org>, Laxman Dewangan <ldewangan@nvidia.com>, Zhang Rui <rui.zhang@intel.com>, linux-omap@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

The history patches come from Mikko and Sascha.
http://thread.gmane.org/gmane.linux.power-management.general/59451

Now, I pick them up to continue upstream.
Nevermind!

This series history patches:
v1: https://lkml.org/lkml/2016/4/24/227

This series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

This series patches rebase the conflicts.
Note that the hardware-tracked trip points are very well tested currently.

Verified and tested on https://github.com/Caesar-github/rockchip/tree/wip/fixes-thermal-0503
That's based on linux-kernel 20160502.
.Linux version 4.6.0-rc6-next-20160502-08922-g860ed34 (wxt@nb)


Changes in v2:
- update the sysfs-api.txt for set_trips
- add the commit in patch[v2 2/5].
- Update the commit for patch[v2 4/5].

Caesar Wang (1):
  thermal: rockchip: add the set_trips function

Sascha Hauer (4):
  thermal: Add support for hardware-tracked trip points
  thermal: of: implement .set_trips for device tree thermal zones
  thermal: streamline get_trend callbacks
  thermal: bang-bang governor: act on lower trip boundary

 Documentation/thermal/sysfs-api.txt                |  7 +++
 drivers/thermal/gov_bang_bang.c                    |  2 +-
 drivers/thermal/of-thermal.c                       | 23 +++++-----
 drivers/thermal/rockchip_thermal.c                 | 39 ++++++++++++++++
 drivers/thermal/thermal_core.c                     | 52 ++++++++++++++++++++++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 ++++-------
 include/linux/thermal.h                            |  9 +++-
 7 files changed, 128 insertions(+), 29 deletions(-)

-- 
1.9.1

