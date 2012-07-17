From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Tue, 17 Jul 2012 02:59:04 -0500
Message-ID: <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com> <1339428387-4800-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:38192 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab2GQH71 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 03:59:27 -0400
Received: by weyx10 with SMTP id x10so76640wey.10
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 00:59:25 -0700 (PDT)
In-Reply-To: <1339428387-4800-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Couple of minor comments:
On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
[...]
>  /**
> + * _omap4_update_context_lost - increment hwmod context loss counter if
> + * hwmod context was lost, and clear hardware context loss reg
> + * @oh: hwmod to check for context loss
> + *
> + * If the PRCM indicates that the hwmod @oh lost context, increment
> + * our in-memory context loss counter, and clear the RM_*_CONTEXT
> + * bits. No return value.
> + */
> +static void _omap4_update_context_lost(struct omap_hwmod *oh)
> +{
> +       u32 r;
> +
> +       if (oh->prcm.omap4.context_offs == USHRT_MAX)
> +               return;
would'nt it be better to return a dummy incremental counter instead of
returning no context loss (count = 0)?

> +
> +       r = omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
> +                                       oh->clkdm->pwrdm.ptr->prcm_offs,
> +                                       oh->prcm.omap4.context_offs);
> +
> +       if (!r)
> +               return;
> +
> +       oh->prcm.omap4.context_lost_counter++;
need to be careful about counter overflow.


Regards,
Nishanth Menon
