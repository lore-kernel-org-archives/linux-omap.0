From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2 01/10] ARM: OMAP: mcbsp: Convert core driver to proper
 platform driver
Date: Tue, 28 Feb 2012 21:32:47 +0200
Message-ID: <4F4D2BDF.90907@bitmer.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com> <1330414820-4641-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:39857 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757256Ab2B1Tc2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 14:32:28 -0500
In-Reply-To: <1330414820-4641-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

On 02/28/2012 09:40 AM, Peter Ujfalusi wrote:
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -1354,8 +1354,9 @@ static struct platform_driver omap_mcbsp_driver = {
>  	},
>  };
>  
> -int __init omap_mcbsp_init(void)
> -{
> -	/* Register the McBSP driver */
> -	return platform_driver_register(&omap_mcbsp_driver);
> -}
> +module_platform_driver(omap_mcbsp_driver);
> +
> +MODULE_AUTHOR("Samuel Ortiz <samuel.ortiz@nokia.com>");

Minor, you shouldn't add expired email address here. No need to resend
though since this gets removed in 4/10.

-- 
Jarkko
