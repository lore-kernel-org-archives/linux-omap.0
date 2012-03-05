From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/6] gpio/omap: Cleanup and adaptation to Device Tree
Date: Mon, 5 Mar 2012 23:33:32 +0100
Message-ID: <4F553F3C.4030909@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51046 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757149Ab2CEWdj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 17:33:39 -0500
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Grant,

Do you have any comment on this latest update?

I've just seen your that your gpio/next includes irqdomain/next, so I 
guess that I can base my pull request on it directly.

Thanks,
Benoit

On 2/24/2012 11:21 PM, Benoit Cousson wrote:
> Hi Grant,
>
> Here are a couple of GPIO cleanup + the DT adaptation patches.
> This update (compared to v1 [1]) is adding an extra fix for SPARSE_IRQ support
> and add the second cell in the binding for GPIO IRQ type that was missing
> previously whereas the driver does support it.
>
> This series is based on 3.3-rc4 + for_3.4/dt_base branch to get
> the needed cleanup and fixes for OMAP.
>
> The interrupt controller support is using irq_domain_add_legacy for
> the moment and will be updated next to use irqchip irq_domain.
>
> It requires the irq_domain generalization and refinement series
> available at:
>    git://git.secretlab.ca/git/linux-2.6 irqdomain/next
>
> It requires as well Tarun's GPIO cleanup series available at:
>    git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_cleanup_fixes_v9
>
> This series is available here for reference:
>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_gpio
>
> Regards,
> Benoit
>
> [1] http://www.spinics.net/lists/linux-omap/msg64694.html
>
>
> Benoit Cousson (6):
>    gpio/omap: Remove bank->id information and misc cleanup
>    gpio/omap: Use devm_ API and add request_mem_region
>    gpio/omap: Add DT support to GPIO driver
>    gpio/omap: Fix IRQ handling for SPARSE_IRQ
>    arm/dts: OMAP4: Add gpio nodes
>    arm/dts: OMAP3: Add gpio nodes
>
>   .../devicetree/bindings/gpio/gpio-omap.txt         |   36 ++++
>   arch/arm/boot/dts/omap3.dtsi                       |   54 +++++
>   arch/arm/boot/dts/omap4.dtsi                       |   54 +++++
>   arch/arm/mach-omap2/gpio.c                         |    8 +-
>   arch/arm/plat-omap/include/plat/gpio.h             |   22 +--
>   drivers/gpio/gpio-omap.c                           |  208 ++++++++++++++------
>   6 files changed, 304 insertions(+), 78 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt
>

