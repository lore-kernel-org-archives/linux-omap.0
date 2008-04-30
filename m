From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: 2430SDP: Use defines in asm/sizes.h
Date: Wed, 30 Apr 2008 12:19:08 +0300
Message-ID: <a0580c510804300219w8fdc9efkf905598be9b417e@mail.gmail.com>
References: <91846c6802efa889898a7c21ab1e74e2@felipebalbi.com>
	 <1209546469-32686-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:44958 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757855AbYD3JTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 05:19:10 -0400
Received: by wa-out-1112.google.com with SMTP id j37so204134waf.23
        for <linux-omap@vger.kernel.org>; Wed, 30 Apr 2008 02:19:09 -0700 (PDT)
In-Reply-To: <1209546469-32686-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wed, Apr 30, 2008 at 12:07 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> Instead of manually calculating the partition sizes, it's
>  better to use defines already set in include/asm-arm/sizes.h
>
>  Compile test only.
>
>  Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Acked-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

>  ---
>   arch/arm/mach-omap2/board-2430sdp-flash.c |   11 ++++++-----
>   1 files changed, 6 insertions(+), 5 deletions(-)
>
>  diff --git a/arch/arm/mach-omap2/board-2430sdp-flash.c b/arch/arm/mach-omap2/board-2430sdp-flash.c
>  index 47aa8bf..3428483 100644
>
> --- a/arch/arm/mach-omap2/board-2430sdp-flash.c
>  +++ b/arch/arm/mach-omap2/board-2430sdp-flash.c
>  @@ -38,25 +38,26 @@ static struct mtd_partition nand_partitions[] = {
>         {
>                 .name           = "X-Loader",
>                 .offset         = 0,
>  -               .size           = 4*(64*2048),  /* 0-3 blks reserved.
>  -                                                  Mandated by ROM code */
>  +               .size           = SZ_512K,       /* 0-3 blks reserved.
>  +                                                 * Mandated by ROM code
>
> +                                                 */
>                 .mask_flags     = MTD_WRITEABLE /* force read-only */
>         },
>         {
>                 .name           = "U-Boot",
>                 .offset         = MTDPART_OFS_APPEND,
>  -               .size           =  4*(64*2048),
>  +               .size           = SZ_512K,
>
>                 .mask_flags     = MTD_WRITEABLE /* force read-only */
>         },
>         {
>                 .name           = "U-Boot Environment",
>                 .offset         = MTDPART_OFS_APPEND,
>  -               .size           = 2*(64*2048),
>  +               .size           = SZ_256K,
>
>
>         },
>         {
>                 .name           = "Kernel",
>                 .offset         = MTDPART_OFS_APPEND,
>  -               .size           = 32*(64*2048),         /* 4*1M */
>  +               .size           = SZ_4M,                /* 4*1M */
>         },
>         {
>                 .name           = "File System",
>  --
>  1.5.5.1.99.gf0ec4
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Eduardo Bezerra Valentin
