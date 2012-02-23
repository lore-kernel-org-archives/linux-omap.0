From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
Date: Thu, 23 Feb 2012 15:08:21 -0800
Message-ID: <20120223230821.GD18185@atomide.com>
References: <4F46C1AF.2040201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43444 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2BWXIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 18:08:24 -0500
Content-Disposition: inline
In-Reply-To: <4F46C1AF.2040201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

* Cousson, Benoit <b-cousson@ti.com> [120223 14:14]:
> The GPIO driver is still relying on internal OMAP IRQ defines that
> are not relevant anymore if OMAP is built with SPARSE_IRQ.

Great :)
 
> Please note that this patch is still RFC, because I do not know
> how to fix properly the ugly cpu_class_is_omap1 and the dependency
> with IH_MPUIO_BASE to detect a MPUIO.

Sounds like gpio_to_irq() needs to be set in the
arch/arm/*omap*/gpio*.c then.

Tony
