From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v2 2/4] drivers: hwspinlock: add OMAP implementation
Date: Wed, 24 Nov 2010 01:23:27 +0200
Message-ID: <1290554607.3647.12.camel@atlantis.mindbit.ro>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	 <1290526740-27624-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:37664 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab0KWXYD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 18:24:03 -0500
In-Reply-To: <1290526740-27624-3-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Hi Ohad,

On Tue, 2010-11-23 at 17:38 +0200, Ohad Ben-Cohen wrote:
> From: Simon Que <sque@ti.com>
> 
> Add hwspinlock support for the OMAP4 Hardware Spinlock device.
> 

<snip>

> +
> +	io_base = ioremap(res->start, resource_size(res));
> +	if (!io_base) {
> +		ret = -ENOMEM;
> +		goto free_state;
> +	}
> +
> +	/* Determine number of locks */
> +	i = readl(io_base + SYSSTATUS_OFFSET);
> +	i >>= SPINLOCK_NUMLOCKS_BIT_OFFSET;
> +
> +	/* exactly one of the four least significant bits must be 1 */
> +	if (!i || !is_power_of_2(i) || i > 8) {
> +		ret = -EINVAL;
> +		goto iounmap_base;
> +	}
> +

At iounmap_base you unmap state->io_base, but that's set only after this
check. You should probably iounmap(io_base).

Regards,
Ionut.


