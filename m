From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Tue, 30 Aug 2011 12:38:30 -0400
Message-ID: <1314722311.2344.64.camel@deneb.redhat.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609Ab1H3Qiq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 12:38:46 -0400
In-Reply-To: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ming.lei@canonical.com
Cc: greg@kroah.com, stern@rowland.harvard.edu, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Wed, 2011-08-31 at 00:03 +0800, ming.lei@canonical.com wrote:
> +/*
> + * Writing to dma coherent memory on ARM may be delayed via L2
> + * writing buffer, so introduce the helper which can flush L2 writing
> + * buffer into memory immediately, especially used to flush ehci
> + * descriptor to memory.
> + * */
> +#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
> +static inline void ehci_sync_mem()
> +{
> +       mb();
> +}
> +#else
> +static inline void ehci_sync_mem()
> +{
> +}
> +#endif
> +

I'm wondering if this doesn't really belong in the DMA API for any
future architectures that can't avoid prolonged write buffering to DMA
coherent memory. IIUC, ARM mitigates this for most drivers by including
an implicit write buffer flush in the mmio write routines. This takes
care of the drivers which write to a mmio device register after writing
something to shared DMA memory. IIUC, this doesn't help ehci because the
host controller is polling to see what the cpu writes to the shared
memory. Other hardware which polls shared memory like that will likely
have the same problem and could use buffer drain helpers as well.

--Mark


