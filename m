From: Kevin Hilman <khilman@ti.com>
Subject: Re: Module + offset calculations have to be signed in arch/arm/mach-omap2/pm-debug.c
Date: Fri, 06 May 2011 12:55:43 -0700
Message-ID: <87mxiz7ge8.fsf@ti.com>
References: <4DC2CED3.80206@gmail.com> <87liyljcnd.fsf@ti.com>
	<4DC2DC03.4020200@gmail.com> <87oc3hf1wk.fsf@ti.com>
	<4DC412ED.1070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38212 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089Ab1EFTzr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 15:55:47 -0400
Received: by mail-px0-f182.google.com with SMTP id 20so2947518pxi.41
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 12:55:46 -0700 (PDT)
In-Reply-To: <4DC412ED.1070805@gmail.com> (Peter Barada's message of "Fri, 06
	May 2011 11:25:33 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Peter,

Peter Barada <peter.barada@gmail.com> writes:

> On 05/05/2011 02:16 PM, Kevin Hilman wrote:
>>
>> In any case, you've found a real bug, and your patch is valid.  However,
>> it doesn't currently apply to mainline, and it looks like it's because
>> your patch is using spaces and the code being patched is using tabs.
>>
>> Also, you can simplify the changelog to to just describe the fix needed
>> due to using negative offsets in some PRM modules.
> I've attached a new patch to fix the tabs/changelog.

Thanks for the updated patch.

[...]

> From 6857bb52af1fcd90e64d3e6c45de3ff0f071be7a Mon Sep 17 00:00:00 2001
> From: Peter Barada <peter.barada@logicpd.com>
> Date: Fri, 6 May 2011 11:07:50 -0400
> Subject: [PATCH] Make offset in pm_module_def signed to allow negative offsets.

Please post in separate mail, and give subject a prefix like:

OMAP: PM debug: use signed offset in pm_module_def

Also, please Cc the linux-arm-kernel mailing list:
linux-arm-kernel@lists.infradead.org for patches intended for mainline.

> Since PRM module offsets can be negative (IVA2 is -0x800), offset in
> pm_module_def struct has to be signed.

OK, but...

> ---
>  arch/arm/mach-omap2/pm-debug.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git b/arch/arm/mach-omap2/pm-debug.c a/arch/arm/mach-omap2/pm-debug.c
> index b731ef3..125f565 100644
> --- b/arch/arm/mach-omap2/pm-debug.c
> +++ a/arch/arm/mach-omap2/pm-debug.c
> @@ -199,7 +199,7 @@ enum {
>  struct pm_module_def {
>  	char name[8]; /* Name of the module */
>  	short type; /* CM or PRM */
> -	short offset;
> +	unsigned short offset;

...this changes it from signed to unsigned.

>  	int low; /* First register address on this module */
>  	int high; /* Last register address on this module */
>  };

Kevin

