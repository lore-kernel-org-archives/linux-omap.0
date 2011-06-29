From: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: [PATCH 0/2] RETU meets Sparse IRQ
Date: Wed, 29 Jun 2011 22:18:57 +0100
Message-ID: <c1c24abe84b7634c6751d51e88213424@doppler.thel33t.co.uk>
References: <1309348011-23141-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from doppler.thel33t.co.uk ([193.110.88.198]:58843 "EHLO
	doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab1F2VTA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 17:19:00 -0400
In-Reply-To: <1309348011-23141-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, 29 Jun 2011 14:46:49 +0300, Felipe Balbi wrote:
> now with Sparse IRQ numbering, we don't need
> to add a bunch of defines in <plat/irqs.h>
>
> Compile tested with omap2plus_defconfig (+cbus)
> and omap1_defconfig (+cbus).
>
> Felipe Balbi (2):
>   cbus: retu: use sparse IRQ numbering
>   cbus: retu: stop polluting <plat/irqs.h>
>
>  arch/arm/mach-omap1/board-nokia770.c   |    2 --
>  arch/arm/mach-omap2/board-n8x0.c       |    2 --
>  arch/arm/plat-omap/include/plat/irqs.h |   10 +---------
>  drivers/cbus/retu.c                    |   25 
> ++++++++++++++++---------
>  include/linux/platform_data/cbus.h     |    2 --
>  5 files changed, 17 insertions(+), 24 deletions(-)

Tested-by: Leigh Brown <leigh@solinno.co.uk>

Booted fine on my N810.

Regards,

Leigh.

