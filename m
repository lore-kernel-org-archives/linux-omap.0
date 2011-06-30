From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] Update Nook Color machine 3284 to common Encore
 name.
Date: Thu, 30 Jun 2011 06:35:38 -0700
Message-ID: <20110630133537.GP23145@atomide.com>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
 <1308066307-415-4-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:47573 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751057Ab1F3Nfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 09:35:43 -0400
Content-Disposition: inline
In-Reply-To: <1308066307-415-4-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: green@linuxhacker.ru, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* green@linuxhacker.ru <green@linuxhacker.ru> [110614 08:42]:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Machine database already updated:
> http://www.arm.linux.org.uk/developer/machines/list.php?id=3284
> 
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Russell, do have some immutable branch containing the mach-types changes
that I could pull for my devel-board branch for this?

If you want me to apply this one along with the related board-*.c
changes please ack.

Regards,

Tony



> ---
>  arch/arm/tools/mach-types |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 3b3776d..fff68d0 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -910,7 +910,7 @@ omapl138_case_a3	MACH_OMAPL138_CASE_A3	OMAPL138_CASE_A3	3280
>  uemd			MACH_UEMD		UEMD			3281
>  ccwmx51mut		MACH_CCWMX51MUT		CCWMX51MUT		3282
>  rockhopper		MACH_ROCKHOPPER		ROCKHOPPER		3283
> -nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
> +encore			MACH_ENCORE		ENCORE			3284
>  hkdkc100		MACH_HKDKC100		HKDKC100		3285
>  ts42xx			MACH_TS42XX		TS42XX			3286
>  aebl			MACH_AEBL		AEBL			3287
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
