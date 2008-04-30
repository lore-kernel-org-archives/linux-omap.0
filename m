From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] ARM: OMAP: 2430SDP: Use defines in asm/sizes.h
Date: Wed, 30 Apr 2008 04:06:31 -0500
Message-ID: <91846c6802efa889898a7c21ab1e74e2@felipebalbi.com>
References: <1209545030-31637-1-git-send-email-felipe.balbi@nokia.com> <a0580c510804300204l32781bb5vb34ef91931718b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60627 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYD3JGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 05:06:33 -0400
In-Reply-To: <a0580c510804300204l32781bb5vb34ef91931718b8a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org



On Wed, 30 Apr 2008 12:04:30 +0300, "Eduardo Valentin"
<edubezval@gmail.com> wrote:
> On Wed, Apr 30, 2008 at 11:43 AM, Felipe Balbi <felipe.balbi@nokia.com>
> wrote:
>> Instead of manually calculating the partition sizes, it's
>>  better to use defines already set in include/asm-arm/sizes.h
>>
>>  Compile test only.
>>
>>  Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>>  ---
>>   arch/arm/mach-omap2/board-2430sdp-flash.c |   11 ++++++-----
>>   1 files changed, 6 insertions(+), 5 deletions(-)
>>
>>  diff --git a/arch/arm/mach-omap2/board-2430sdp-flash.c
> b/arch/arm/mach-omap2/board-2430sdp-flash.c
>>  index 47aa8bf..f645051 100644
>>  --- a/arch/arm/mach-omap2/board-2430sdp-flash.c
>>  +++ b/arch/arm/mach-omap2/board-2430sdp-flash.c
>>  @@ -38,25 +38,26 @@ static struct mtd_partition nand_partitions[] = {
>>         {
>>                 .name           = "X-Loader",
>>                 .offset         = 0,
>>  -               .size           = 4*(64*2048),  /* 0-3 blks reserved.
>>  -                                                  Mandated by ROM code
> */
>>  +               .size           = SZ_128K,       /* 0-3 blks reserved.
> 
> I' m sure you meant
> +               .size           = SZ_512K,       /* 0-3 blks reserved.
> here.

eheh, true :-p

crap, I can't do simple math anymore :-p
I'll resend it.

> 
> 
>>  +                                                 * Mandated by ROM
> code
>>  +                                                 */
>>                 .mask_flags     = MTD_WRITEABLE /* force read-only */
>>         },
>>         {
>>                 .name           = "U-Boot",
>>                 .offset         = MTDPART_OFS_APPEND,
>>  -               .size           =  4*(64*2048),
>>  +               .size           = SZ_128K,
> 
> Here as well.
> 
>>                 .mask_flags     = MTD_WRITEABLE /* force read-only */
>>         },
>>         {
>>                 .name           = "U-Boot Environment",
>>                 .offset         = MTDPART_OFS_APPEND,
>>  -               .size           = 2*(64*2048),
>>  +               .size           = SZ_128K,
> 
> And here
> +               .size           = SZ_256K,
> 
>>         },
>>         {
>>                 .name           = "Kernel",
>>                 .offset         = MTDPART_OFS_APPEND,
>>  -               .size           = 32*(64*2048),         /* 4*1M */
>>  +               .size           = SZ_4M,                /* 4*1M */
>>         },
>>         {
>>                 .name           = "File System",
>>  --
>>  1.5.5.1.99.gf0ec4
>>
>>  --
>>  To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
>>  the body of a message to majordomo@vger.kernel.org
>>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
> 
> --
> Eduardo Bezerra Valentin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

