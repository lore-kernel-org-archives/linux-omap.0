From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 4/5] drivers/rtc/rtc-ds1307.c: Support optional wakeup
 interrupt source
Date: Wed, 24 Jun 2015 03:54:21 -0700
Message-ID: <20150624105421.GD4156@atomide.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
 <1435076114-12416-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435076114-12416-5-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150623 09:21]:
> With the recent pinctrl-single changes, SoCs such as Texas
> Instrument's OMAP processors can treat wake-up events from deeper idle
> states as interrupts.
> 
> Let's add support for the optional second interrupt for wake-up using
> the generic wakeirq support added in commit 4990d4fe327b ("PM /
> Wakeirq: Add automated device wake IRQ handling")
> 
> Finally, to pass the wake-up interrupt in the dts file,
> interrupts-extended property needs to be passed.
> 
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> support for optional wake-up") + ee83bd3b6483 ("serial: omap: Switch
> wake-up interrupt to generic wakeirq")

The wakeirq related changes look good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
