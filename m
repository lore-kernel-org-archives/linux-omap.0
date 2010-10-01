From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] scatterlist: define SG chain for arm architecture
Date: Thu, 30 Sep 2010 22:50:30 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F3E074E0@dlee06.ent.ti.com>
References: <1285903354-7378-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285903354-7378-1-git-send-email-x0095840@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Please discard this patch, it should have sent to linux-arm list.

Regards,
Fernando.

> 
> ________________________________________
> From: Guzman Lugo, Fernando
> Sent: Thursday, September 30, 2010 10:22 PM
> To: tony@atomide.com
> Cc: Hiroshi.DOYU@nokia.com; linux-kernel@vger.kernel.org; linux-omap@vger.ke
> rnel.org; Guzman Lugo, Fernando
> Subject: [PATCH] scatterlist: define SG chain for arm architecture
> 
> Define SG chain for ARM architecture in order to work
> with big buffers. This patch is needed in order to
> iovmm users can pass a big buffer to map it and ARM
> architecture has not issues using SG chain.
> 
> This change was suggested by FUJITA Tomonori.
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  arch/arm/include/asm/scatterlist.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/scatterlist.h b/arch/arm/include/asm/scatt
> erlist.h
> index 2f87870..3de0a0b 100644
> --- a/arch/arm/include/asm/scatterlist.h
> +++ b/arch/arm/include/asm/scatterlist.h
> @@ -5,4 +5,6 @@
>  #include <asm/types.h>
>  #include <asm-generic/scatterlist.h>
> 
> +#define ARCH_HAS_SG_CHAIN
> +
>  #endif /* _ASMARM_SCATTERLIST_H */
> --
> 1.6.3.3
> 