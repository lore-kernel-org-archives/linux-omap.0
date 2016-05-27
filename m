From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 0/4] Thermal: Support for hardware-tracked trip points
Date: Fri, 27 May 2016 16:23:24 +0800
Message-ID: <1464337408-7123-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Caesar Wang <wxt@rock-chips.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The history patches come from Mikko and Sascha.
    http://thread.gmane.org/gmane.linux.power-management.general/59451

Now, I pick them up to continue upstream.
Nevermind!

This series history patches:
v3: https://lkml.org/lkml/2016/5/24/797
v2: https://lkml.org/lkml/2016/5/3/220
v1: https://lkml.org/lkml/2016/4/24/227

This series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

This series patches rebase the conflicts.
Note that the hardware-tracked trip points are very well tested currently.

Verified and tested on https://github.com/Caesar-github/rockchip/tree/wip/fixes-thermal-0525
That's based on linux-kernel 20160524.


Changes in v4:
- as the Javi comments, %s/implemnets/implements.

Changes in v3:
- as the Javi comments on https://patchwork.kernel.org/patch/9001311/.
- add the select if they set the option for devicetree.
- Add the peter's ACK.

Changes in v2:
- add the commit in patch[v2 2/5].
- Update the commit for patch[v2 4/5].

Caesar Wang (1):
  thermal: rockchip: add the set_trips function

Sascha Hauer (3):
  thermal: of: implement .set_trips for device tree thermal zones
  thermal: streamline get_trend callbacks
  thermal: bang-bang governor: act on lower trip boundary

 drivers/thermal/gov_bang_bang.c                    |  2 +-
 drivers/thermal/of-thermal.c                       | 30 +++++++++++------
 drivers/thermal/rockchip_thermal.c                 | 39 ++++++++++++++++++++++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 +++++---------
 include/linux/thermal.h                            |  6 +++-
 5 files changed, 73 insertions(+), 29 deletions(-)

-- 
1.9.1
