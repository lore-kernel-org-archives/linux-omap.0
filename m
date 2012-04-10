From: Chris Ball <cjb@laptop.org>
Subject: Re: omap-hsmmc build broken with OF enabled in latest kernel
Date: Tue, 10 Apr 2012 10:03:27 -0400
Message-ID: <87obqzwuog.fsf@laptop.org>
References: <20120410095444.GO24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43287 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758806Ab2DJOD0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 10:03:26 -0400
In-Reply-To: <20120410095444.GO24211@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue, 10 Apr 2012 10:54:44 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rajendra Nayak <rnayak@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, "S, Venkatraman" <svenkatr@ti.com>

Hi,

On Tue, Apr 10 2012, Russell King - ARM Linux wrote:
> This commit:
>
> commit 46856a68dcb5f67c779d211fd6bcb5d7a2a7f19b
> Author: Rajendra Nayak <rnayak@ti.com>
> Date:   Mon Mar 12 20:32:37 2012 +0530
>
>     mmc: omap_hsmmc: Convert hsmmc driver to use device tree
>
>     Define dt bindings for the ti-omap-hsmmc, and adapt the driver to extract
>     data (which was earlier passed as platform_data) from device tree.
>
>     Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>     Acked-by: Rob Herring <rob.herring@calxeda.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
> breaks omap-hsmmc compilation:
>
> drivers/mmc/host/omap_hsmmc.c:1745: error: expected ',' or ';' before 'extern'
>
> +#ifdef CONFIG_OF
> +static u16 omap4_reg_offset = 0x100;
> +
> +static const struct of_device_id omap_mmc_of_match[] = {
> ...
> +}
> +MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
>
> There should be a ';' after the }.

Thanks, and sorry for breaking the build.  I've pushed a fix to mmc-next
and will send it out to Linus.

Surprisingly, this patch does not break my build with gcc-4.6.0 --
and I've just checked that line 1745 is being compiled by purposefully
introducing an(other) error to it, which *did* break my build.  I wonder
what's going on there; presumably it's the reason that no-one else saw
this earlier.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
