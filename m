From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 09/20] OMAP3: McBSP: Lower the maximum buffersize for
 McBSP1,3,4,5
Date: Thu, 30 Jul 2009 21:57:21 +0300
Message-ID: <20090730215721.a899e2f4.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:51254 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZG3S42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 14:56:28 -0400
In-Reply-To: <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

On Thu, 30 Jul 2009 15:49:32 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Do not allow applications to use the full buffer found on
> McBSP1,3,4,5. Using the full buffer in threshold mode causes
> the McBSP buffer to run dry, which can be observed as channels
> are switching (in reality the channels are shifting).
> 
...
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -129,7 +129,7 @@ static struct omap_mcbsp_platform_data
> omap34xx_mcbsp_pdata[] = { .rx_irq		=
> INT_24XX_MCBSP1_IRQ_RX, .tx_irq		=
> INT_24XX_MCBSP1_IRQ_TX, .ops		= &omap2_mcbsp_ops,
> -		.buffer_size	= 0x7F,
> +		.buffer_size	= 0x6F,
>  	},

Is it possible that also McBSP2 would require that maximum burst
transmit size should be 0x10 smaller than size of internal buffer/fifo?

-- 
Jarkko
