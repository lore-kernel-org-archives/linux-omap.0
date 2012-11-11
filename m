From: Constantine Shulyupin <const@makelinux.com>
Subject: Porting board initialization for fdt
Date: Mon, 12 Nov 2012 00:38:37 +0200
Message-ID: <CAE7jHC-Z9wy=5HPzhZZpupcBVn862ERq1LRF9KQ=Ed7BXiDFBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tim.bird@am.sony.com, pandaboard@googlegroups.com
List-Id: linux-omap@vger.kernel.org

What is architecture and the best strategy to port board initialization to fdt?

Let's see for example omap4_ehci_init and usbhs_bdata @
arch/arm/mach-omap2/board-omap4panda.c.

How to perform board specific initializations?
Can omap4_ehci_init be converted to probe function of new platform
driver  omap4_ehci?
Where and how define GPIO, clock?
Should it be defined in of_dev_auxdata or in fdt?

Thanks

-- 
Constantine Shulyupin
http://www.MakeLinux.com/
Embedded Linux Systems
