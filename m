From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH] dspbridge: use linux memory allocator directly
Date: Wed, 2 Sep 2009 20:49:41 +0300
Message-ID: <20090902174941.GA25799@localhost>
References: <1251805173-15214-3-git-send-email-andy.shevchenko@gmail.com> <1251912430-23182-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52225 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbZIBRvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2009 13:51:08 -0400
Content-Disposition: inline
In-Reply-To: <1251912430-23182-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shevchenko Andriy (EXT-Teleca/Helsinki)" <ext-andriy.shevchenko@nokia.com>

On Wed, Sep 02, 2009 at 07:27:10PM +0200, ext Andy Shevchenko wrote:
> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> 
> Instead of MEM_Calloc()/MEM_Free() use kzalloc()/kfree() calls. Thus we get rid
> of mem.h dependency.
> 
> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/list.h |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
> index c9d9e49..cda1d21 100644
> --- a/arch/arm/plat-omap/include/dspbridge/list.h
> +++ b/arch/arm/plat-omap/include/dspbridge/list.h
> @@ -49,8 +49,8 @@
>  #define LIST_
>  
>  #include <dspbridge/host_os.h>
> -/* MEM_Calloc(), MEM_NONPAGED, MEM_Free() */
> -#include <dspbridge/mem.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
>  #include <linux/list.h>
>  
>  #define LST_ELEM            list_head
> @@ -85,9 +85,9 @@ struct LST_LIST {
>  static inline struct LST_LIST *LST_Create(void)
>  {
>  	struct LST_LIST *pList;
> +	gfp_t flags = (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL;
>  
> -	pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
> -		MEM_NONPAGED);
> +	pList = (struct LST_LIST *) kzalloc(sizeof(struct LST_LIST), flags);
>  	if (pList != NULL)
>  		INIT_LIST_HEAD(&pList->head);
>  
> @@ -116,7 +116,8 @@ static inline struct LST_LIST *LST_Create(void)
>   */
>  static inline void LST_Delete(struct LST_LIST *pList)
>  {
> -	MEM_Free(pList);
> +	if (pList != NULL)
> +		kfree(pList);

No need to check, since kfree does it for you.

--Imre

