From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: omap2+: stub out omap*_volt_data
Date: Mon, 10 Oct 2011 11:41:05 -0700
Message-ID: <87ipnwhepq.fsf@ti.com>
References: <1397689.kebELtC4N3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37786 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752990Ab1JJSlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 14:41:11 -0400
Received: by mail-yx0-f172.google.com with SMTP id 33so8234279yxt.17
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 11:41:10 -0700 (PDT)
In-Reply-To: <1397689.kebELtC4N3@wuerfel> (Arnd Bergmann's message of "Sat, 08
	Oct 2011 17:23:24 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Arnd Bergmann <arnd@arndb.de> writes:

> When CONFIG_PM_OPP is not set, the definitions for these variables
> are not available, so we should conditionally define them to
> NULL.
>
> arch/arm/mach-omap2/built-in.o: In function `omap3xxx_voltagedomains_init':
> voltagedomains3xxx_data.c:100: undefined reference to `omap36xx_vddmpu_volt_data'
> voltagedomains3xxx_data.c:100: undefined reference to `omap34xx_vddmpu_volt_data'
> voltagedomains3xxx_data.c:100: undefined reference to `omap36xx_vddcore_volt_data'
> voltagedomains3xxx_data.c:100: undefined reference to `omap34xx_vddcore_volt_data'
> arch/arm/mach-omap2/built-in.o: In function `omap44xx_voltagedomains_init':
> voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_mpu_volt_data'
> voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_iva_volt_data'
> voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_core_volt_data'
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kevin Hilman <khilman@ti.com>

> ---
> I got this build error only now after pulling in the latest omap series, but
> I cannot tell what caused it. It's also not clear to me if this is the correct
> solution. Please ack or provide a better fix.

This code was merged for v2.6.39, so not sure why this error is only
showing up for you now.  I just tried a !CONFIG_PM_OPP build on v2.6.39
and get the same errors, so it's been lingering.

Maybe you haven't had a randconfig that disabled CONFIG_PM_OPP before?

Anyways, the fix is fine with me.

Kevin
