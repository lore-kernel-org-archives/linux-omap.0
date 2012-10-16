From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [RESEND] [PATCH 3.6.0- 3/6] ARM/pxa: use module_platform_driver
 macro
Date: Tue, 16 Oct 2012 12:59:34 +0200
Message-ID: <507D3E16.2050901@compulab.co.il>
References: <1350025880-30551-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:44074 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840Ab2JPK7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 06:59:44 -0400
In-Reply-To: <1350025880-30551-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, paul@pwsan.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, juha.yrjola@nokia.com, dsaxena@plexity.net, mpm@selenic.com, herbert@gondor.apana.org.au

On 10/12/12 09:11, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch removes some code duplication by using
> module_platform_driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/mach-pxa/pxa3xx-ulpi.c |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> index 7dbe3cc..e329cce 100644
> --- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> +++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> @@ -384,18 +384,7 @@ static struct platform_driver pxa3xx_u2d_ulpi_driver = {
>          .probe          = pxa3xx_u2d_probe,
>          .remove         = pxa3xx_u2d_remove,
>  };
> -
> -static int pxa3xx_u2d_ulpi_init(void)
> -{
> -	return platform_driver_register(&pxa3xx_u2d_ulpi_driver);
> -}
> -module_init(pxa3xx_u2d_ulpi_init);
> -
> -static void __exit pxa3xx_u2d_ulpi_exit(void)
> -{
> -	platform_driver_unregister(&pxa3xx_u2d_ulpi_driver);
> -}
> -module_exit(pxa3xx_u2d_ulpi_exit);
> +module_platform_driver(pxa3xx_u2d_ulpi_driver);
>  
>  MODULE_DESCRIPTION("PXA3xx U2D ULPI driver");
>  MODULE_AUTHOR("Igor Grinberg");

-- 
Regards,
Igor.
