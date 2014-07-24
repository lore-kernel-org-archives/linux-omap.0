From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] gpu: drm: omapdrm: Use %pad format for values of the
 dma_addr_t type
Date: Thu, 24 Jul 2014 11:11:15 -0700
Message-ID: <1406225475.27221.59.camel@joe-AO725>
References: <1406224686-4857-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1406224686-4857-1-git-send-email-matwey@sai.msu.ru>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: matwey@sai.msu.ru
Cc: matwey.kornilov@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2014-07-24 at 21:58 +0400, matwey@sai.msu.ru wrote:
> The format change is to fix the following compilation issue:

Just a trivial note:

> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
[]
> @@ -791,7 +791,7 @@ int omap_gem_get_paddr(struct drm_gem_object *obj,
>  			omap_obj->paddr = tiler_ssptr(block);
>  			omap_obj->block = block;
>  
> -			DBG("got paddr: %08x", omap_obj->paddr);
> +			DBG("got paddr: %pad", &(omap_obj->paddr));

&foo->bar does not need parentheses.

Most uses in the kernel do not have them.
It seems to be ~25:1 without to with.

> @@ -985,9 +985,9 @@ void omap_gem_describe(struct drm_gem_object *obj, struct seq_file *m)
>  
>  	off = drm_vma_node_start(&obj->vma_node);
>  
> -	seq_printf(m, "%08x: %2d (%2d) %08llx %08Zx (%2d) %p %4d",
> +	seq_printf(m, "%08x: %2d (%2d) %08llx %pad (%2d) %p %4d",
>  			omap_obj->flags, obj->name, obj->refcount.refcount.counter,
> -			off, omap_obj->paddr, omap_obj->paddr_cnt,
> +			off, &(omap_obj->paddr), omap_obj->paddr_cnt,

etc...
