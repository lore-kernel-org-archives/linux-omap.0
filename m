From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC] default machine descriptor for multiplatform
Date: Fri, 1 Feb 2013 17:17:33 +0530
Message-ID: <510BAB55.30603@ti.com>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131161823.GT2637@n2100.arm.linux.org.uk> <1731670.s76EGcEZ7m@wuerfel> <1638002.UJ7zfj1Wn5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57431 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab3BALqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 06:46:42 -0500
In-Reply-To: <1638002.UJ7zfj1Wn5@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

On Thursday 31 January 2013 11:21 PM, Arnd Bergmann wrote:
> This is what I think it would look like to do a default platform
> with an empty machine descriptor on ARM. It makes the few required
> entries in the descriptor optional by using the new irqchip_init()
> and clocksource_of_init() functions as defaults, and adds
> a fallback for the DT case to customize_machine to probe all
> the default devices.
>
> For the case that CONFIG_MULTIPLATFORM is enabled, it then
> adds a machine descriptor that never matches any machine but
> is used as a fallback if nothing else matches.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
This is indeed a nice update towards consolidation. Though
on OMAP, we need to do some work to effectively get rid
of machine, time and irq inits. Will add this task in my
TODO queue.

Regards,
Santosh

