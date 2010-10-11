From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: serial: Fix the boot-up crash/reboot without
 CONFIG_PM
Date: Mon, 11 Oct 2010 10:55:28 -0700
Message-ID: <20101011175528.GC25462@atomide.com>
References: <1286795118-11490-1-git-send-email-santosh.shilimkar@ti.com>
 <8739scu6rp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52625 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab0JKRzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 13:55:33 -0400
Content-Disposition: inline
In-Reply-To: <8739scu6rp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [101011 07:37]:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> >
> > This is happening because 'omap_serial_init()' is hanging in the boot.
> > On OMAP3 the watchdog is generating reboot because devices_init doesn't
> > happens where as on OMAP4 it just hangs without reboot.
> > The uart clock is not getting enabled after omap_device_idle as part
> > of omap_serial_init.
> > The omap_device_idle(will disable the clock) then omap_uart_block_sleep()
> > should enable clock back disabled during the boot up phase.
> > But omap_uart_block_sleep() stuffed version is binded only under
> > CONFIG_PM and other version is just empty. Hence it is not enabling
> > clock back as expected
> >
> > This patch adds uart clock enable code to omap_uart_block_sleep() function
> > built with CONFIG_PM disabled.
> > Thanks to Charulatha and Govindraj for their help on this debug.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> 
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> This is a regression fix, so we should queue this for 2.6.37.

Thanks, adding to omap-for-linus.

Regards,

Tony
