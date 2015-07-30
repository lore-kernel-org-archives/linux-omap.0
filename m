From: NeilBrown <neil@brown.name>
Subject: [PATCH 00/13] Enhance twl4030_charger functionality. - V3
Date: Thu, 30 Jul 2015 10:11:24 +1000
Message-ID: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


Following is most of my twl4030_charger patches, rebased against
 git://git.infradead.org/battery-2.6

Since the previous set I have added the conversion to
module_platform_driver so EPROBE_DEFER can be used, and fixed
a few minor typos.

This does not include the changes to add extcon support, in part
because extcon has seen some changes lately which leave me even more
confused about how best to use it than before.
I need to sort that out before I can resolve the rest of my usb phy
patches and then add a few more charger patches.

Thanks,
NeilBrown


---

NeilBrown (12):
      twl4030_charger: use runtime_pm to keep usb phy active while charging.
      twl4030_charger: correctly handle -EPROBE_DEFER from devm_usb_get_phy_by_node
      twl4030_charger: trust phy to determine when USB power is available.
      twl4030_charger: split uA calculation into a function.
      twl4030_charger: allow fine control of charger current.
      twl4030_charger: distinguish between USB current and 'AC' current
      twl4030_charger: allow max_current to be managed via sysfs.
      twl4030_charger: enable manual enable/disable of usb charging.
      twl4030_charger: add software controlled linear charging mode.
      twl4030_charger: add ac/mode to match usb/mode
      twl4030_charger: Increase current carefully while watching voltage.
      twl4030_charger: assume a 'charger' can supply maximum current.

Pavel Machek (1):
      twl4030_charger: convert to module_platform_driver instead of ..._probe.


 .../ABI/testing/sysfs-class-power-twl4030          |   45 ++
 drivers/mfd/twl-core.c                             |    9 
 drivers/power/twl4030_charger.c                    |  541 ++++++++++++++++++--
 3 files changed, 531 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-twl4030

--
Signature
