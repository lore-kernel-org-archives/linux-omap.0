From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH 4/8] OMAP: DSS2: OMAP4 Secondary LCD Channel DISPC
 Registers
Date: Thu, 1 Jul 2010 10:28:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007011027070.1550@utopia.booyaka.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com> <1277980285-20996-2-git-send-email-archit@ti.com> <1277980285-20996-3-git-send-email-archit@ti.com> <1277980285-20996-4-git-send-email-archit@ti.com>
 <1277980285-20996-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45040 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab0GAQ23 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 12:28:29 -0400
In-Reply-To: <1277980285-20996-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, "Semwal, Sumit" <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

On Thu, 1 Jul 2010, Archit Taneja wrote:

> From: Semwal, Sumit <sumit.semwal@ti.com>
> 
> Introduce OMAP4 DISPC base address and Secondary LCD Channel registers, use them
> in register dumps.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   42 ++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 41 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 5ecdc00..08b36d6
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -41,9 +41,13 @@
>  #include "dss.h"
>  
>  /* DISPC */
> +#ifdef CONFIG_ARCH_OMAP4
> +#define DISPC_BASE			0x58001000
> +#define DISPC_SZ_REGS			SZ_16K
> +#else
>  #define DISPC_BASE			0x48050400
> -
>  #define DISPC_SZ_REGS			SZ_1K
> +#endif

This will break multi-OMAP builds.  Instead, get the DISPC_BASE at runtime 
through platform_get_resource*().


- Paul
