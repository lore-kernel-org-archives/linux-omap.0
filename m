From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 14/14] OMAP2PLUS: Enable various options in defconfig
Date: Mon, 8 Nov 2010 11:24:24 -0800
Message-ID: <20101108192424.GS9264@atomide.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
 <1288366708-32302-15-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55991 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab0KHTYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 14:24:31 -0500
Content-Disposition: inline
In-Reply-To: <1288366708-32302-15-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

* Thara Gopinath <thara@ti.com> [101029 08:30]:
> This patch enables Smartreflex and Cpu Freq in the
> omap2plus defconfig.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/configs/omap2plus_defconfig |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index ccedde1..b7888ae 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -291,3 +291,7 @@ CONFIG_CRC_T10DIF=y
>  CONFIG_CRC_ITU_T=y
>  CONFIG_CRC7=y
>  CONFIG_LIBCRC32C=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_OMAP_SMARTREFLEX=y
> +CONFIG_OMAP_SMARTREFLEX_CLASS3=y

Has this been tested to run reliably for several days and on which
hardware?

The reason I'm asking is that AFAIK smartreflex has not been enabled
for any production device so far.

Regards,

Tony
