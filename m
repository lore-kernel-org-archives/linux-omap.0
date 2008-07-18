From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/9] TWL4030 bugfixes and cleanups
Date: Thu, 17 Jul 2008 19:34:48 -0600
Message-ID: <20080718013205.18943.34047.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49360 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbYGRBfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 21:35:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

At boot, twl_init_irq() tries to mask off all TWL4030 secondary
interrupts and clear them, since no secondary interrupt handlers are
registered yet (that happens later in the boot).

However, this code is flawed.  MADC, BCI, keypad, and GPIO ISRs are
either not cleared or are incompletely cleared.  Some BCI register
addresses are nonsensical.  And some code attempts to clear ISRs
before masking IMRs, which is race-prone (an interrupt could occur
after the ISR clear, but before the mask).

These problems can cause large numbers of boot messages similar to
this:

    TWL4030 module irq 368 is disabled but can't be masked!

observed during boot on the BeagleBoard here.  The actual IRQ number
sometimes varied depending on which interrupt was unacknowledged.

This series fixes these issues and does some code cleanup, saving 336
bytes.  The __init changes cause an extra 4KB page to be freed after
kernel init on Beagle.

Thanks to Philip Balister <philip@balister.org>, Koen Kooi
<k.kooi@student.utwente.nl>, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.org>, =
Steve
Sakoman <sakoman@gmail.com> and others on #beagle for help tracing
these problems.

Tested on BeagleBoard rev B4 (3530ES2.2).

- Paul

---

Paul Walmsley (9):
      TWL4030: convert early interrupt mask/clear funcs to use array
      TWL4030: use symbolic ISR/IMR register names during twl_init_irq(=
)
      TWL4030: move TWL module register defs into separate include file=
s
      TWL4030: change init-time IMR mask code to WARN if error
      TWL4030: read and write module ISRs to clear them at init
      TWL4030: clear MADC interrupt status registers upon init
      TWL4030: use correct register addresses for BCI IMR registers
      TWL4030: clear TWL GPIO interrupt status registers
      TWL4030: remove superfluous PWR interrupt status clear before mas=
king


 drivers/i2c/chips/twl4030-core.c   |  335 ++++++++++++++++++++--------=
--------
 drivers/i2c/chips/twl4030-gpio.c   |   48 -----
 drivers/i2c/chips/twl4030-pwrirq.c |   15 +-
 include/linux/i2c/twl4030-gpio.h   |   76 ++++++++
 include/linux/i2c/twl4030-pwrirq.h |   37 ++++
 5 files changed, 303 insertions(+), 208 deletions(-)
 create mode 100644 include/linux/i2c/twl4030-gpio.h
 create mode 100644 include/linux/i2c/twl4030-pwrirq.h

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
