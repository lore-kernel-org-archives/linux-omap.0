From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() or
 __vmalloc()
Date: Tue, 27 Apr 2010 20:06:12 -0500
Message-ID: <4BD78A04.8020905@ti.com>
References: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44210 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739Ab0D1BGS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:06:18 -0400
In-Reply-To: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 4/8/2010 6:43 PM, Gomez Castellanos, Ivan wrote:
>  From 0306e1ff7c9160dbc5eb9fffcd789a40bea0debb Mon Sep 17 00:00:00 2001
> From: Ivan Gomez Castellanos<ivan.gomez@ti.com>
> Date: Fri, 19 Mar 2010 16:43:26 -0600
> Subject: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() or __vmalloc()
>
> This is needed because the file drivers/dsp/bridge/services/mem.c
> is going to be deleted. The changes should be as follows:
>
> mem_calloc(x, MEM_PAGED) ==>  kzalloc(x, GFP_KERNEL)
> mem_calloc(x, MEM_NONPAGED) ==>  kzalloc(x, GFP_KERNEL)
> mem_calloc(x, MEM_MEM_LARGEVIRTMEM) ==>
> __vmalloc(x, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
>
> If running in atomic context, then the GFP_KERNEL argument
> is changed to GFP_ATOMIC.
>
> Signed-off-by: Ivan Gomez Castellanos<ivan.gomez@ti.com>
> ---

Rebased and pushed the entire series.

- omar

