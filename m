From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH, RFC] default machine descriptor for multiplatform
Date: Fri, 1 Feb 2013 12:34:30 +0000
Message-ID: <201302011234.30592.arnd@arndb.de>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk> <1638002.UJ7zfj1Wn5@wuerfel> <510BAB55.30603@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54349 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3BAMes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 07:34:48 -0500
In-Reply-To: <510BAB55.30603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

On Friday 01 February 2013, Santosh Shilimkar wrote:
> This is indeed a nice update towards consolidation. Though
> on OMAP, we need to do some work to effectively get rid
> of machine, time and irq inits. Will add this task in my
> TODO queue.

There is no urgent need to get all board files to have empty
machine descriptors, I would not expect that to happen for
the more complex platforms like omap any time soon.

You currently use quite a number of callbacks:

DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
        .reserve        = omap_reserve,
        .smp            = smp_ops(omap4_smp_ops),
        .map_io         = omap5_map_io,
        .init_early     = omap5_init_early,
        .init_irq       = omap_gic_of_init,
        .handle_irq     = gic_handle_irq,
        .init_machine   = omap_generic_init,
        .timer          = &omap5_timer,
        .dt_compat      = omap5_boards_compat,
        .restart        = omap44xx_restart,
MACHINE_END

and I see nothing wrong with that. For simpler platforms that
after migrating out init_irq and init_timer have only one
or two callbacks left, it may be more interesting to actually
go all the way and remove all of them if possible.

	Arnd
