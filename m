From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4 3/4] OMAP2: DMA: Use errata flag for disabling
 buffering
Date: Mon, 4 Oct 2010 14:45:46 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA45@dbde02.ent.ti.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
 <1286180294-32618-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0JDJP4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 05:15:56 -0400
In-Reply-To: <1286180294-32618-4-git-send-email-peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Monday, October 04, 2010 1:48 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v4 3/4] OMAP2: DMA: Use errata flag for 
> disabling buffering

...

>  
>  /* Errata handling */
> +#define DMA_ERRATA_IFRAME_BUFFERING	(1 << 0)
>  static u16 dma_errata;
>  #define IS_DMA_ERRATA(id)	(dma_errata & (id))
>  

These macros should move to header file since these
macros will be used in mach-omap2/dma.c and plat-omap/dma.c
with upcoming dma hwmod series.

-Manjunath