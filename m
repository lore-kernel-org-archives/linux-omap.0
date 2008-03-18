From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Refresh palmtt_defconfig
Date: Tue, 18 Mar 2008 13:43:22 +0200
Message-ID: <20080318114322.GB7843@atomide.com>
References: <1205828404919-git-send-email-francisco.alecrim@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65132 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbYCRMnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 08:43:04 -0400
Content-Disposition: inline
In-Reply-To: <1205828404919-git-send-email-francisco.alecrim@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

* Francisco Alecrim <francisco.alecrim@indt.org.br> [080318 11:21]:
> Refresh palmtt_defconfig
> 
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> ---
>  arch/arm/configs/palmtt_defconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/palmtt_defconfig b/arch/arm/configs/palmtt_defconfig
> index 4a5fcb4..e54ced4 100644
> --- a/arch/arm/configs/palmtt_defconfig
> +++ b/arch/arm/configs/palmtt_defconfig
> @@ -252,8 +252,8 @@ CONFIG_FPE_NWFPE=y
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

Pushing today.

Tony
