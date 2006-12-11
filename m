From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Fix sx1 build failure
Date: Mon, 11 Dec 2006 14:04:57 -0800
Message-ID: <20061211220456.GD31722@atomide.com>
References: <3a5b1be00612041016j653fe738m9b3f77c6400e95d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3a5b1be00612041016j653fe738m9b3f77c6400e95d6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal.shah802003@gmail.com>
Cc: linux-omap-open-source <linux-omap-open-source@linux.omap.com>, vovan888@gmail.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal.shah802003@gmail.com> [061204 10:18]:
> Patch from Vladimir Ananiev.
> 
> -- 
> ---Komal Shah
> http://komalshah.blogspot.com

> From 7734bbdac6cf4f2e670de5caa368f58f258978b4 Mon Sep 17 00:00:00 2001
> From: Komal Shah <komal_shah802003@yahoo.com>
> Date: Mon, 4 Dec 2006 23:39:21 +0530
> Subject: [PATCH] ARM: OMAP: Fix sx1 build failure
> 
> sound/arm/omap/omap-alsa-sx1.c:32: error: `CN_IDX_SX1SND' undeclared
> here (not in a function)
> sound/arm/omap/omap-alsa-sx1.c:32: error: initializer element is not constant
> sound/arm/omap/omap-alsa-sx1.c:32: error: (near initialization for
> 					   `cn_sx1snd_id.idx')
> sound/arm/omap/omap-alsa-sx1.c:32: error: `CN_VAL_SX1SND' undeclared
> here (not in a function)
> sound/arm/omap/omap-alsa-sx1.c:32: error: initializer element is not constant
> sound/arm/omap/omap-alsa-sx1.c:32: error: (near initialization for
> 					   `cn_sx1snd_id.val')
> 
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> Signed-off-by: Vladimir Ananiev <vovan888@gmail.com>
> ---
>  include/linux/connector.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index 4c02119..ba49a01 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -36,9 +36,13 @@
>  #define CN_VAL_CIFS                     0x1
>  #define CN_W1_IDX			0x3	/* w1 communication */
>  #define CN_W1_VAL			0x1
> +#define CN_IDX_SX1SND			0x4
> +#define CN_VAL_SX1SND			0x1
> +#define CN_IDX_SX1PM			0x5
> +#define CN_VAL_SX1PM			0x1
>  
>  
> -#define CN_NETLINK_USERS		4
> +#define CN_NETLINK_USERS		6
>  
>  /*
>   * Maximum connector's message size.

Pushing this. This should be sent to the appropriate list or LKML for
integration BTW.

Tony
