From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH resend] OMAP: DSS2: Replace strncmp() with sysfs_streq()
 in overlay_manager_store()
Date: Wed, 28 Jul 2010 19:27:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F08@dbde02.ent.ti.com>
References: <'> <1280298118-4295-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55473 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab0G1N6B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 09:58:01 -0400
In-Reply-To: <1280298118-4295-1-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Taneja, Archit
> Sent: Wednesday, July 28, 2010 11:52 AM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Taneja, Archit
> Subject: [PATCH resend] OMAP: DSS2: Replace strncmp() with 
> sysfs_streq() in overlay_manager_store()
> 
> In the function overlay_manager_store, the length of the string
> buf is used to comapre the 2 strings, there is a possibility of
> false positive match if buf is a prefix string of another manager.
> 
> The use of sysfs_streq() fixes this.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/overlay.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/overlay.c 
> b/drivers/video/omap2/dss/overlay.c
> index 8233658..244dca8
> --- a/drivers/video/omap2/dss/overlay.c
> +++ b/drivers/video/omap2/dss/overlay.c
> @@ -65,7 +65,7 @@ static ssize_t overlay_manager_store(struct 
> omap_overlay *ovl, const char *buf,
>  		for (i = 0; i < 
> omap_dss_get_num_overlay_managers(); ++i) {
>  			mgr = omap_dss_get_overlay_manager(i);
>  
> -			if (strncmp(buf, mgr->name, len) == 0)
> +			if (sysfs_streq(buf, mgr->name))

[sp] sysfs_streq() ignores trailing newlines during comparison. So,
     the possibility mentioned in the description still stays.

     I am not familiar with overall context; but wouldn't srtcmp()
     be the right choice? unless, of course, either of strings
     being compared are not null terminated.

>  				break;
>  
>  			mgr = NULL;
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 