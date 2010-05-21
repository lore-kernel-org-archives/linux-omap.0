From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH v2] OMAP: Fix Memory leak
Date: Fri, 21 May 2010 03:44:19 -0500
Message-ID: <A24693684029E5489D1D202277BE8944557B5A7B@dlee02.ent.ti.com>
References: <1274422500-29955-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48596 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab0EUIo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 04:44:26 -0400
In-Reply-To: <1274422500-29955-1-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kumar, Satish" <satish.k@ti.com>, Tony Lindgren <tony@atomide.com>, vimal singh <vimal.newwork@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi Manjunath,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
> Sent: Friday, May 21, 2010 1:15 AM
> To: linux-omap@vger.kernel.org
> Cc: Kumar, Satish; Tony Lindgren; vimal singh
> Subject: [PATCH v2] OMAP: Fix Memory leak

The subject prefix doesn't help much to know which OMAP code you're
referring to. Maybe a more proper renaming could be:

omap: iovmm: Fix memory leak

Just do 'git log -p arch/arm/plat-omap/iovmm.c' to see the convention taken so far.

> 
> From: Satish <x0124230@ti.com>
> 
> The memory allocated for sgt structure is not freed on error
> when sg_alloc_table is called in sgtable_alloc().
> 
> Signed-off-by: Satish Kumar <x0124230@ti.com>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: vimal singh <vimal.newwork@gmail.com>

You're missing here the main code maintainer:

Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

I'm looping him in this time.

Regards,
Sergio

> ---
>  arch/arm/plat-omap/iovmm.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index e43983b..8ce0de2 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -140,8 +140,10 @@ static struct sg_table *sgtable_alloc(const size_t
> bytes, u32 flags)
>  		return ERR_PTR(-ENOMEM);
> 
>  	err = sg_alloc_table(sgt, nr_entries, GFP_KERNEL);
> -	if (err)
> +	if (err) {
> +		kfree(sgt);
>  		return ERR_PTR(err);
> +	}
> 
>  	pr_debug("%s: sgt:%p(%d entries)\n", __func__, sgt, nr_entries);
> 
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
