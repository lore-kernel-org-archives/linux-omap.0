From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: BCM2048 bluetooth connected over OMAP serial
Date: Wed, 10 Dec 2014 18:02:42 +0100
Message-ID: <11367725.nphhSzdtpK@wuerfel>
References: <20141210164333.GA3154@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:65219 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbaLJRDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2014 12:03:18 -0500
In-Reply-To: <20141210164333.GA3154@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

On Wednesday 10 December 2014 17:43:33 Pavel Machek wrote:
> 
> So, there's bluetooth chip that's connected to the SoC by UART and some
> GPIOs. What would be right representation in the device tree?
> Something like this?
> 
>         bluetooth {
>                   compatible = "broadcom,bcm2048";
>                   uart = <&uart2>;
>                   reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
>                   host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
>                   bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */
>                   chip-type = >;
>                   bt-sysclk = <2>;
>                   reset-gpio-shared = <0>;
>         };
> 
> Is there some way to prevent OMAP tty driver from binding to the
> device and exporting the device to userspace?

I think from the driver perspective, you want this to be a tty line
discipline rather than a driver that attaches to the physical
uart.

For the DT representation, I fear we haven't got a precedent. A uart
phandle sounds reasonable, but there might be other ways to do it
and we should consider if there are better alternatives. It could
possibly be a child node of the uart, but that would require other
infrastructure in the kernel because we don't currently create
devices for those.

	Arnd
