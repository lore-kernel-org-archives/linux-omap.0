From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v4 4/7] ARM: l2c: Add support for overriding prefetch
 settings
Date: Fri, 19 Sep 2014 11:50:01 +0200
Message-ID: <20140919095000.GF29620@piout.net>
References: <1409062680-15906-1-git-send-email-t.figa@samsung.com>
 <1409062680-15906-5-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36007 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751008AbaISJuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2014 05:50:05 -0400
Content-Disposition: inline
In-Reply-To: <1409062680-15906-5-git-send-email-t.figa@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, tony@atomide.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, drake@endlessm.com, loeliger@gmail.com, santosh.shilimkar@ti.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

On 26/08/2014 at 16:17:57 +0200, Tomasz Figa wrote :
> Firmware on certain boards (e.g. ODROID-U3) can leave incorrect L2C prefetch
> settings configured in registers leading to crashes if L2C is enabled
> without overriding them. This patch introduces bindings to enable
> prefetch settings to be specified from DT and necessary support in the
> driver.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

It is working and useful on Atmel's sama5d4 were the bootloader is not
configuring the L2C prefetch. However, I'm wondering whether we should
add support for setting L310_PREFETCH_CTRL_DATA_PREFETCH and
L310_PREFETCH_CTRL_INSTR_PREFETCH. I'm currently doing it by using
".l2c_aux_val    = L310_AUX_CTRL_DATA_PREFETCH |
L310_AUX_CTRL_INSTR_PREFETCH" (those are the same bits) but this has the
disadvantage of displaying the "L2C: platform modifies aux control
register:" twice.

> +	if (!of_property_read_u32(np, "arm,prefetch-offset", &val)) {
> +		prefetch &= ~L310_PREFETCH_CTRL_OFFSET_MASK;
> +		prefetch |= val & L310_PREFETCH_CTRL_OFFSET_MASK;
> +	}
> +

While you use val directly here, later, while printing the offset, val +
1 is used. Maybe it would be better to have the same number in both
places, else you end up with having "arm,prefetch-offset = <1>" in your
DT and the kernel printing "L2C-310 ID prefetch enabled, offset 2
lines".



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
