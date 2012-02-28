From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/6] arm: omap4: prm: fix interrupt register offsets
Date: Mon, 27 Feb 2012 16:25:57 -0800
Message-ID: <87k437st0q.fsf@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
	<1330003320-17400-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48859 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754565Ab2B1A0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 19:26:07 -0500
Received: by mail-pw0-f44.google.com with SMTP id wz17so1203872pbc.3
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 16:25:58 -0800 (PST)
In-Reply-To: <1330003320-17400-5-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 23 Feb 2012 15:21:58 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Tero Kristo <t-kristo@ti.com> writes:

> Previous code used wrong instance for the interrupt register access.
> Use the right one which is OCP_SOCKET.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/prm44xx.c |   21 +++++++++++----------
>  1 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index 1557647..a6efbdf 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -145,8 +145,9 @@ static inline u32 _read_pending_irq_reg(u16 irqen_offs, u16 irqst_offs)
>  	u32 mask, st;
>  
>  	/* XXX read mask from RAM? */
> -	mask = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, irqen_offs);
> -	st = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, irqst_offs);
> +	mask = omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
> +		irqen_offs);

nit: indentaion.  this line should be indented and star at the same
place as OMAP4430_PRM_OCP....


Kevin
