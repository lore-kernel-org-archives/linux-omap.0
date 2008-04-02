From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Refresh palmz71_defconfig
Date: Wed, 2 Apr 2008 10:11:52 +0300
Message-ID: <20080402071152.GC31913@atomide.com>
References: <1206817231-22364-1-git-send-email-francisco.alecrim@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50230 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYDBHLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 03:11:55 -0400
Content-Disposition: inline
In-Reply-To: <1206817231-22364-1-git-send-email-francisco.alecrim@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

* Francisco Alecrim <francisco.alecrim@indt.org.br> [080329 21:08]:
> Refresh palmz71_defconfig

Pushing today.

Tony


> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> ---
>  arch/arm/configs/palmz71_defconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/palmz71_defconfig b/arch/arm/configs/palmz71_defconfig
> index 22017c8..6361922 100644
> --- a/arch/arm/configs/palmz71_defconfig
> +++ b/arch/arm/configs/palmz71_defconfig
> @@ -282,8 +282,8 @@ CONFIG_FPE_NWFPE=y
>  # Userspace binary formats
>  #
>  CONFIG_BINFMT_ELF=y
> -CONFIG_BINFMT_AOUT=y
> -CONFIG_BINFMT_MISC=y
> +# CONFIG_BINFMT_AOUT is not set
> +# CONFIG_BINFMT_MISC is not set
>  # CONFIG_ARTHUR is not set
>  
>  #
> -- 
> 1.5.4.23.gef5b9
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
