From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 05/18] OMAP: GPIO: cleanup datain,dataout,set dir funcs
Date: Fri, 22 Apr 2011 08:22:59 -0700
Message-ID: <8739laz4x8.fsf@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
	<1303470512-19671-6-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35324 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204Ab1DVPXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 11:23:03 -0400
Received: by pzk32 with SMTP id 32so386496pzk.28
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 08:23:01 -0700 (PDT)
In-Reply-To: <1303470512-19671-6-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Fri, 22 Apr 2011 16:38:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com

Charulatha V <charu@ti.com> writes:

> * Define gpio register offsets in SoC specific GPIO files and use
>   these register offsets while doing register read/write
> * Remove the usage of CONFIG_ARCH_* checks and cpu_is* checks from
>   the below functions
> 	_set_gpio_direction
> 	_set_gpio_dataout
> 	_get_gpio_dataout
> 	_get_gpio_datain
> * MPUIO is a common gpio bank->method for OMAP15xx, OMAP16xx and
>   OMAP7xx SoCs. Each of these SoCs has one bank with MPUIO type.
>   Hence handle MPUIO type GPIO banks in GPIO driver.
>
> Note: After the complete driver is cleaned up, the register offset
> macros defined in OMAP GPIO driver would be removed
>
> Signed-off-by: Charulatha V <charu@ti.com>

IMO, this isn't quite the direction we want to go for this cleanup.  

Register offsets should indeed be in SoC specific files, but rather than
the driver calling pdata function pointers for the functions, the
register offsets should instead be passed into the driver so the driver
can have common functions.

Also, MPUIO doesn't need to be treated as a special case.   From the
GPIO driver perspective, it's just another GPIO bank.  On some SoCs, it
happens to have a different width and stride, but the drive should
handle that.

I've also started on a GPIO cleanup (currently posted to linux-omap
only) and I've taken a different approach.

After I finish reviewing your series, I'll have some more ideas on
how we might combine our efforts here.

Kevin
