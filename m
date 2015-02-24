From: NeilBrown <neilb@suse.de>
Subject: [PATCH 00/15]  Enhance twl4030_charger functionality.
Date: Tue, 24 Feb 2015 15:33:50 +1100
Message-ID: <20150224043341.4243.23291.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34315 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbbBXEfL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 23:35:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

These patches make a number of improvements to twl4030_charger.

So are just internal cleanups (e.g. use of devres).  Others allow
better control of charging through both manual and automatic means.

- the maximum current can be configured via sysfs.
- the charger will only draw that current if it can do so without
  the voltage dropping too much
- a 'continuous' mode is available which ignores voltage and just
  takes what it can (to be used with caution, but very useful in
  some circumstances).
- 'ac' and 'usb' power sources can be configured separately.

Some of this functionality requires patch to phy-twl4030-usb.c which
have been sent separately.

Thanks,
NeilBrown


---

NeilBrown (15):
      power_supply core: support use of devres to register/unregister a power supply.
      twl4030_charger: use devm_request_threaded_irq
      twl4030_charger: use devres for power_supply_register and kzalloc.
      twl4030_charger: use runtime_pm to keep usb phy active while charging.
      twl4030_charger: trust phy to determine when USB power is available.
      twl4030_charger: split uA calculation into a function.
      twl4030_charger: allow fine control of charger current.
      twl4030_charger: distinguish between USB current and 'AC' current
      twl4030_charger: allow max_current to be managed via sysfs.
      twl4030_charger: only draw USB current as negotiated with host.
      twl4030_charger: enable manual enable/disable of usb charging.
      twl4030_charger: add software controlled linear charging mode.
      twl4030_charger: add ac/mode to match usb/mode
      twl4030_charger: Increase current carefully while watching voltage.
      twl4030_charger: assume a 'charger' can supply maximum current.


 drivers/mfd/twl-core.c            |    9 -
 drivers/power/power_supply_core.c |   45 +++
 drivers/power/twl4030_charger.c   |  572 +++++++++++++++++++++++++++++++------
 include/linux/power_supply.h      |    4 
 4 files changed, 539 insertions(+), 91 deletions(-)

--
Signature

