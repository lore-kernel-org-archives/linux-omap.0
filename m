From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Fri, 22 Oct 2010 10:00:09 -0700
Message-ID: <20101022170008.GG9149@atomide.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57181 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757933Ab0JVRAO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 13:00:14 -0400
Content-Disposition: inline
In-Reply-To: <1287387875-14168-2-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [101018 00:41]:
> From: Simon Que <sque@ti.com>
> 
> Add driver for OMAP's Hardware Spinlock module.
> 
> The OMAP Hardware Spinlock module, initially introduced in OMAP4,
> provides hardware assistance for synchronization between the
> multiple processors in the device (Cortex-A9, Cortex-M3 and
> C64x+ DSP).

...

> +EXPORT_SYMBOL_GPL(omap_hwspin_trylock);
> +EXPORT_SYMBOL_GPL(omap_hwspin_lock_timeout);
> +EXPORT_SYMBOL_GPL(omap_hwspin_unlock);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_request);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_request_specific);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_free);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_get_id);

Please let's not add yet another omap specific layer that will
make it incrementally harder to have generic drivers.

Instead, we can do the omap specific locking in the
platform code and then the drivers can use the functions
passed in the platform_data if they're implemented.

Regards,

Tony
