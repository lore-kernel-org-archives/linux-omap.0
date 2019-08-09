From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH 03/22] ARM: omap1: move omap15xx local bus handling to usb.c
Date: Fri, 09 Aug 2019 08:32:28 +0300
Message-ID: <87y302ewer.fsf@gmail.com>
References: <20190808212234.2213262-1-arnd@arndb.de> <20190808212234.2213262-4-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808212234.2213262-4-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The mach/memory.h file only exists to implement a dma offset for "Local
> Bus" devices, and that consists of the OHCI USB controller for practical
> purposes.
>
> The generic dma-mapping interface has gained this exact feature some
> years ago and can do it much more efficiently, so replace the complex
> __arch_virt_to_dma/__arch_dma_to_pfn/... logic with a much simpler boot
> time initialization.
>
> This should also make any code that performs dma mapping calls at
> runtime much more efficient, by eliminating the strcmp() along with
> the computation.
>
> Similar, a portion of the ohci-omap driver is just there for configuring
> the memory translation, this too can get moved into usb.c
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For all of these patches related to usb:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Thanks for cleaning this up, Arnd.

-- 
balbi
