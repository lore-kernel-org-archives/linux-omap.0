From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH] staging: tidspbridge: use the right type for
 list_is_last
Date: Sun, 12 Dec 2010 16:23:32 +0200
Message-ID: <1292163812.2375.7.camel@atlantis.mindbit.ro>
References: <1291846823-31513-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:53454 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab0LLOXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Dec 2010 09:23:38 -0500
In-Reply-To: <1291846823-31513-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi Omar,

On Wed, 2010-12-08 at 16:20 -0600, Omar Ramirez Luna wrote:
> Removes the following warning:
> 
>   CC [M]  drivers/staging/tidspbridge/rmgr/rmm.o
> drivers/staging/tidspbridge/rmgr/rmm.c: In function 'rmm_alloc':
> drivers/staging/tidspbridge/rmgr/rmm.c:147: warning: passing
> 	argument 1 of 'list_is_last' from incompatible pointer type
> include/linux/list.h:170: note: expected 'const struct list_head *'
> 	but argument is of type 'struct rmm_ovly_sect *'
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  drivers/staging/tidspbridge/rmgr/rmm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/staging/tidspbridge/rmgr/rmm.c
> index aae8657..5a3f09c 100644
> --- a/drivers/staging/tidspbridge/rmgr/rmm.c
> +++ b/drivers/staging/tidspbridge/rmgr/rmm.c
> @@ -144,7 +144,7 @@ int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
>  			new_sect->addr = addr;
>  			new_sect->size = size;
>  			new_sect->page = segid;
> -			if (list_is_last(sect, &target->ovly_list))
> +			if (list_is_last(&sect->list_elem, &target->ovly_list))
>  				/* Put new section at the end of the list */
>  				list_add_tail(&new_sect->list_elem,
>  						&target->ovly_list);


Sorry, I added this warning by mistake, so ...

Acked-by: Ionut Nicu <ionut.nicu@mindbit.ro>

