From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 0/3] regulator: twl: Fix regulator mode support
Date: Sat, 26 Mar 2016 10:28:12 +0200
Message-ID: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Nokia N900 regulators are left in the mode last set by the bootloader
or by the stock kernel, depends on whether it is power-on or reboot from
stock kernel to mainline. That leads to problem with devices connected
to vmmc2 regulator - when the device is rebooted from stock kernel vmmc2
is left in "sleep" mode (REGULATOR_STATUS_STANDBY in terms of regulator
framework) and as noone in mainline kernel switches vmmc2 regulator to
normal (REGULATOR_STATUS_NORMAL) mode, devices supplied by it does not
get enough power to operate normally.

Fix that by providing the correct functionality for initial mode setting
from the board DTS. Fix i2c access to powerbus while at it.

I will send a follow-up patch for N900 board DTS that sets initial
regulators mode once the $subject series is assumed to be ok.

Ivaylo Dimitrov (3):
  regulator: twl: Make sure we have access to powerbus before trying to
    write to it
  regulator: twl: Provide of_map_mode for twl4030
  regulator: twl: Regulator mode should not depend on regulator enabled
    state

 drivers/regulator/twl-regulator.c | 100 +++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 18 deletions(-)

-- 
1.9.1
