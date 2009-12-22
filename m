From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks enclosed
 under DEBUG_FS
Date: Tue, 22 Dec 2009 13:59:14 +0200
Message-ID: <1261483154.2108.86.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16901 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbZLVL7E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 06:59:04 -0500
In-Reply-To: <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Thu, 2009-12-17 at 16:18 +0100, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Which warning does this fix? I don't get any compiler warnings.

Can you change the name of the patch to a more standard one?

 Tomi

> ---
>  drivers/video/omap2/dss/core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 29497a0..2fabaf2 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -124,6 +124,7 @@ static void restore_all_ctx(void)
>  	dss_clk_disable_all_no_ctx();
>  }
>  
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
>  /* CLOCKS */
>  static void core_dump_clocks(struct seq_file *s)
>  {
> @@ -149,6 +150,7 @@ static void core_dump_clocks(struct seq_file *s)
>  				clocks[i]->usecount);
>  	}
>  }
> +#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
>  
>  static int dss_get_clock(struct clk **clock, const char *clk_name)
>  {


