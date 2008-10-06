From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [ANNOUNCE] New PM branch: pm-20081006
Date: Mon, 06 Oct 2008 17:45:30 +0300
Message-ID: <87myhhvl2t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:33326 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbYJFOpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 10:45:38 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2308015fkq.5
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 07:45:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

The latest PM branch, is now available in the linux-omap tree.  The
git-shortlog is below[1], but from a high level, this branch includes
support for

- full-chip retention in dynamic idle
- full-chip retention in suspend
- full-chip OFF in dynamic idle
- full-chip OFF in suspend

The choice of retention versus off-mode can be selected using
/sys/power/enable_off_mode (zero by default.)

Tested on 3430SDP.

To test:

# echo 1 > /sys/power/clocks_off_while_idle
# echo 1 > /sys/power/sleep_while_idle
# echo 1 > /sys/power/voltage_off_while_idle

and optionally for off-mode

# echo 1 > /sys/power/enable_off_mode

Kevin


[1] git shortlog:

Amit Kucheria (2): PM: Typo fix for clock_allow_idle HSMMC: Make
      driver support dynamic idle

Kalle Jokiniemi (3):
      OMAP3: Remove CONFIG_OMAP_SYSOFFMODE flag
      OMAP: Sysfs interface for enabling voltage off in idle
      OMAP3: OFF command integration

Kevin Hilman (5):
      ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
      PM: serial: ensure padconf wake-enable bits are set for UARTs
      ARM: OMAP3: PM: allow runtime enable/disable of OFF mode
      TEMP: Merge into IRQ save/restore patch
      ARM: OMAP3: PM: remove unused 'context_mem' var from sleep34xx.S

Paul Walmsley (1):
      OMAP2/3 PM: create the OMAP PM interface and add a default OMAP PM no-op layer.

Rajendra Nayak (16):
      OMAP3: Adds missing CM offset defs
      OMAP3: GPMC context save/restore
      OMAP3: Serial context save/restore
      OMAP3: GPIO context save/restore
      OMAP3: I2C context save/restore
      OMAP3: INTC context save/restore
      OMAP3: PRCM context save/restore
      OMAP3: Populate scratchpad contents
      OMAP3: SCM context save/restore
      OMAP3: SRAM restore function
      OMAP3: PER/NEON/CORE control in idle
      OMAP3: Restore MMU table entry
      OMAP3: MPU Off support
      OMAP3: CORE Off support
      OMAP3: Dynamic enable/disable of OFF support
      OMAP3: 3430SDP minimal kernel defconfig

Tero Kristo (2):
      PM: Added sleep support to UART
      PM debug support for 34xx
