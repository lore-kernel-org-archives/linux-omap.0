From: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Subject: Re: [PATCH 03/13] DSPBRIDGE: Moving functions from mem.c to drv.c
Date: Fri, 16 Apr 2010 12:36:58 +0200
Message-ID: <20100416103658.GA18995@lit.local.igalia.com>
References: <818EF96F5A7CC84789DD014773DB09548F6481CF@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.mundo-r.com ([212.51.32.191]:41461 "EHLO
	smtp3.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331Ab0DPKrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 06:47:17 -0400
Content-Disposition: inline
In-Reply-To: <818EF96F5A7CC84789DD014773DB09548F6481CF@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On Thu, Apr 08, 2010 at 06:47:13PM -0500, Gomez Castellanos, Ivan wrote:

> +/*
> + *  ======== mem_flush_cache ========
> + *  Purpose:
> + *      Flush cache
> + */
> +void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushType)
> +{
> +       if (!pMemBuf)
> +               return;
> +
> +       switch (FlushType) {
> +               /* invalidate only */
> +       case PROC_INVALIDATE_MEM:
> +               dmac_inv_range(pMemBuf, pMemBuf + byte_size);
> +               outer_inv_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
> +                                                         byte_size));
> +               break;
> +               /* writeback only */
> +       case PROC_WRITEBACK_MEM:
> +               dmac_clean_range(pMemBuf, pMemBuf + byte_size);
> +               outer_clean_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
> +                                                           byte_size));
> +               break;
> +               /* writeback and invalidate */
> +       case PROC_WRITEBACK_INVALIDATE_MEM:
> +               dmac_flush_range(pMemBuf, pMemBuf + byte_size);
> +               outer_flush_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
> +                                                           byte_size));
> +               break;
> +       }

In the commit 702b94bff3c50542a6e4ab9a4f4cef093262fe65 (2.6.34) the functions
dmac_inv_range and dmac_clean_range were removed.

I'm wondering how to fix this in order to rebase to 2.6.34.

Thanks

vmjl
