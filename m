From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2/3: hwmod data: add gpmc
Date: Tue, 8 May 2012 09:36:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205080932560.9984@utopia.booyaka.com>
References: <1336481382-28583-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33598 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687Ab2EHPgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 11:36:21 -0400
In-Reply-To: <1336481382-28583-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, 8 May 2012, Afzal Mohammed wrote:

> This is patch 13/39 & 14/39 of v4 OMAP GPMC driver conversion
> series modified and squashed into one.

...

> +	/* HWMOD_INIT_NO_RESET can be removed once kernel is updated
> +	 * to configure GPMC for all peripherals, right now many
> +	 * peripherals depend on bootloader configuration, removing
> +	 * this flag would break GPMC on many boards
> +	 */

Thanks for combining these.   But since you're doing quite a bit of GPMC 
work, I think we should ensure that the kernel will configure the GPMC 
before accessing GPMC devices as part of this change.

See also 

   http://marc.info/?l=linux-omap&m=133649129220098&w=2


- Paul
