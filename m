From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: armv7a Makefile: change -march flag to
	"armv7-a" so gcc 4.3.x works
Date: Mon, 16 Jun 2008 16:25:32 +0300
Message-ID: <20080616132531.GE8848@atomide.com>
References: <1213368351-10664-1-git-send-email-koen@openembedded.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51166 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbYFPNY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2008 09:24:57 -0400
Content-Disposition: inline
In-Reply-To: <1213368351-10664-1-git-send-email-koen@openembedded.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@openembedded.org>
Cc: linux-omap@vger.kernel.org

* Koen Kooi <koen@openembedded.org> [080613 17:48]:
> armv7a Makefile: change -march flag to "armv7-a" so gcc 4.3.x works, "armv7a" is a CSL-ism. CSL compilers accept both variants.
> 
> Tested with: gcc 4.2.4, 4.3.0, 4.3.1 and csl 2007q3, 2008q1

Can you please post this to linux-arm-kernel@lists.arm.linux.org.uk
mailing list?

Thanks,

Tony

> 
> Signed-off-by: Koen Kooi <koen@openembedded.org>
> ---
>  arch/arm/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 40a0b44..a3befbd 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -47,7 +47,7 @@ comma = ,
>  # Note that GCC does not numerically define an architecture version
>  # macro, but instead defines a whole series of macros which makes
>  # testing for a specific architecture or later rather impossible.
> -arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7a,-march=armv5t -Wa$(comma)-march=armv7a)
> +arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
>  arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
>  # Only override the compiler option if ARMv6. The ARMv6K extensions are
>  # always available in ARMv7
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
