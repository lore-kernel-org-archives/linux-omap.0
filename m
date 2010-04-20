From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP:ls037v7dw01: Included slab.h file required for
 kzalloc
Date: Tue, 20 Apr 2010 17:41:06 +0300
Message-ID: <1271774466.2433.26.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1271756699-3161-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47610 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab0DTOlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 10:41:20 -0400
In-Reply-To: <1271756699-3161-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-04-20 at 11:44 +0200, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> With recent kernel changes, without inclusion of slab.h
> kernel build fails with,
> 
>   CC      drivers/video/omap2/displays/panel-sharp-ls037v7dw01.o
>   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c: In function
>   'sharp_ls_panel_probe':
>   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:93: error: implicit
>   declaration of function 'kzalloc'
>   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:93: warning:
>   assignment makes pointer from integer without a cast
>   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:106: error: implicit
>   declaration of function 'kfree'
>   make[4]: *** [drivers/video/omap2/displays/panel-sharp-ls037v7dw01.o] Error 1
>   make[3]: *** [drivers/video/omap2/displays] Error 2
>   make[2]: *** [drivers/video/omap2] Error 2
>   make[1]: *** [drivers/video] Error 2
>   make: *** [drivers] Error 2
> 
> 

I already added this include into the backlight patch you sent
previously.

 Tomi

> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> index d84feb0..7d9eb2b 100644
> --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> @@ -23,6 +23,7 @@
>  #include <linux/backlight.h>
>  #include <linux/fb.h>
>  #include <linux/err.h>
> +#include <linux/slab.h>
> 
>  #include <plat/display.h>
> 
> --
> 1.6.2.4
> 


