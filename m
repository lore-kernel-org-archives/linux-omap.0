From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC 0/2] am33xx 0.950V core sleep mode
Date: Wed,  1 May 2013 12:02:25 -0700
Message-ID: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:47188 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab3EATCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 15:02:34 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx1so989238pab.40
        for <linux-omap@vger.kernel.org>; Wed, 01 May 2013 12:02:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patchset adds support for setting vdd core to 0.95V during
suspend. I wanted to get some comments on the DT usage and also
the location of the code, in sleep33xx.S. Since the am33xx PM code
is not yet merged, the patchset is based on ti-linux-3.8.y kernel
located at https://git.ti.com/ti-linux-kernel/ti-linux-kernel.

am33xx processors have a special VDD core operating point that can
lower power consumption, but the operating point has many
restrictions. One of the restrictions is that it does not support
any DDR3 clock rates, meaning that the memory controller must be
disabled to enter this operating point. For DDR2 systems, the
clock rate must be changed, which can only be done from internal
memory.

For these reasons, the mode is most useful during suspend. The
change must be done after the memory controller has been disabled.
The memory controller is disabled as the last step in the suspend
sequence, within sleep33xx.S.

The patchset basically adds a small I2C controller to sleep33xx.S,
allowing simple I2C messages to be sent to anything on the I2C1 bus.
It can support any am33xx platform so long as VDD core can be
controlled via simple writes on the I2C1 bus.

Since am33xx is a device tree platform, I needed to find a way to
integrate this into DT. I put the sleep and wake sequences as arrays
of binary bytes in the I2C1 node. I'm not sure where else it would
fit better, but I'm open to suggestions.

An example sequence is included for Beaglebone, where this patchset
has been tested.

Russ Dill (2):
  ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
  ARM: dts: add AM33XX vdd core opp50 suspend for Beaglebone.

 arch/arm/boot/dts/am335x-bone.dts |  25 +++++-
 arch/arm/mach-omap2/pm33xx.c      | 108 ++++++++++++++++++++++
 arch/arm/mach-omap2/pm33xx.h      |  23 +++++
 arch/arm/mach-omap2/sleep33xx.S   | 184 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 339 insertions(+), 1 deletion(-)

-- 
1.8.1.2

