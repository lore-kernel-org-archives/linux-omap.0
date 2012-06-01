From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
Date: Fri, 01 Jun 2012 10:36:11 +0300
Message-ID: <4FC870EB.4060300@bitmer.com>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:42675 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501Ab2FAHiI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 03:38:08 -0400
In-Reply-To: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Matcovschi <oleg.matcovschi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk, jkrzyszt@tis.inet.pl

On 05/16/2012 12:35 AM, Oleg Matcovschi wrote:
> Use omap_disable_channel_irq() function instead of directly accessing CICR.
> The omap_disable_chanel_irq() function clears pending interrupts
> and disables interrupt on channel.
> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> status register.
> 
> 
> Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
> ---
> v1 initial revision
> v2 Review by Tony Lindgren
> ---
>  arch/arm/plat-omap/dma.c |   59 +++++++++++++++++++++------------------------
>  1 files changed, 28 insertions(+), 31 deletions(-)
> 
Tested on BeagleBoard by using mmc and audio

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
