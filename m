From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] genirq: fix handle_bad_irq kerneldoc comment
Date: Tue, 06 Oct 2015 22:59:40 +0200
Message-ID: <5400000.cD19rmgWjV@wuerfel>
References: <201510070422.sqnilsXm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201510070422.sqnilsXm%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kbuild test robot <lkp@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, kbuild-all@01.org, Austin Schuh <austin@peloton-tech.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

A recent cleanup removed the 'irq' parameter from many functions, but
left the documentation for this in place for at least one function.

This removes it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: bd0b9ac405e1 ("genirq: Remove irq argument from irq flow handlers")
---
On Wednesday 07 October 2015 04:51:56 kbuild test robot wrote:
> [auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]
> 
> reproduce: make htmldocs
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/irq/handle.c:31: warning: Excess function parameter 'irq' description in 'handle_bad_irq'
> >> kernel/irq/handle.c:1: warning: no structured comments found

This seems to be an unrelated bug, not sure why it wasn't caught earlier:

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 142bbf3b607f..a302cf9a2126 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -22,7 +22,6 @@
 
 /**
  * handle_bad_irq - handle spurious and unhandled irqs
- * @irq:       the interrupt number
  * @desc:      description of the interrupt
  *
  * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
