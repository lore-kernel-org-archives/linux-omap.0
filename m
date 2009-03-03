From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 0/1] Regarding enable_irq_wake() and disable_irq_wake()
	functions
Date: Tue, 3 Mar 2009 11:02:42 +0900
Message-ID: <4d34a0a70903021802q45707e62w5c4ccb14558c731e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:25350 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbZCCCCp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 21:02:45 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1712402yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 18:02:43 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, David Brownell <david-b@pacbell.net>

Hi,

The following patch was made to remove waning message below.

[  755.708251] WARNING: at kernel/irq/manage.c:304 set_irq_wake+0x80/0xe4()
[  755.708251] Unbalanced IRQ 29 wake disable
[  755.708251] Modules linked in:
[  755.708282] [<c002efec>] (dump_stack+0x0/0x14) from [<c0057718>]
(warn_slowpath+0x70/0x8c)
[  755.708312] [<c00576a8>] (warn_slowpath+0x0/0x8c) from [<c007e4c8>]
(set_irq_wake+0x80/0xe4)
[  755.708343]  r3:0000001d r2:c0374eee
[  755.708343]  r7:80000093 r6:0000001d r5:00000000 r4:c03d0184
[  755.708374] [<c007e448>] (set_irq_wake+0x0/0xe4) from [<c003cbe4>]
(gpio_wake_enable+0xd8/0x114)
[  755.708404]  r9:ce7399b8 r8:00000000 r7:00000000 r6:00800000 r5:60000093
[  755.708435] r4:c03cc998
[  755.708435] [<c003cb0c>] (gpio_wake_enable+0x0/0x114) from
[<c007e3b4>] (set_irq_wake_real+0x38/0x3c)
[  755.708465]  r7:80000013 r6:000000b7 r5:00000000 r4:000000b7
[  755.708465] [<c007e37c>] (set_irq_wake_real+0x0/0x3c) from
[<c007e4e8>] (set_irq_wake+0xa0/0xe4)

First I tried to fix it by applying next patch, Because another GPIO
in same bank could enable or diable irq_wake twice in the original
code.

@@ -857,11 +857,13 @@ static int _set_gpio_wakeup(struct gpio_bank
*bank, int gpio, int enable)
 		}
 		spin_lock_irqsave(&bank->lock, flags);
 		if (enable) {
+			if (!bank->suspend_wakeup)
+				enable_irq_wake(bank->irq);
 			bank->suspend_wakeup |= (1 << gpio);
-			enable_irq_wake(bank->irq);
 		} else {
-			disable_irq_wake(bank->irq);
 			bank->suspend_wakeup &= ~(1 << gpio);
+			if (!bank->suspend_wakeup)
+				disable_irq_wake(bank->irq);
 		}
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;

But this was not the real problem. Current enable_irq_wake and
disable_irq_wake isn't working correctly since the set_wake field of
omap_irq_chip is NULL.

Is these functions for the future implementation in OMAP?

Anyway..., I removed it in the following patch, and I think this work
can be done in other OMAP device driver which is using
enable_irq_wake() and something like that.

-- 
Q1
