From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap2/omapfb: make DBG() more resistant in if-else
 constructions
Date: Tue, 10 May 2011 15:07:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CDACEDC@dbde02.ent.ti.com>
References: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Niels de Vos <ndevos@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Niels de Vos
> Sent: Tuesday, May 10, 2011 2:51 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org; 
> linux-kernel@vger.kernel.org; Niels de Vos
> Subject: [PATCH] omap2/omapfb: make DBG() more resistant in 
> if-else constructions
> 
> When DBG() is used in a simple if-else, the resulting code path
> currently depends on the definition of DBG(). Inserting the 
> statement in
> a "do { ... } while (0)" prevents this possible misuse.
> 
> Signed-off-by: Niels de Vos <ndevos@redhat.com>
> 
> ---
> Note, I have not found any offenders, but a mistake can 
> easily be made.
> The following example shows what can go wrong if little intention is
> paid to the definition of the DBG() macro.
> 
> Example:
> 	if something_went_wrong()
> 		DBG("oh no, something went wrong!\n");
> 	else
> 		printk("all went fine\n");
> 
> Old result where the else is placed inside the first if-statment:
> 	if something_went_wrong() {
> 		if (omapfb_debug) {
> 			printk(KERN_DEBUG "oh no, something 
> went wrong!\n");
> 		} else {
> 			printk("all went fine\n");
> 		}
> 	}
> 
> New result where the else is an alternative to the first if-statement:
> 	if something_went_wrong() {
> 		do {
> 			if (omapfb_debug)
> 				printk(KERN_DEBUG "oh no, 
> something went wrong!\n");
> 		} while (0);
> 	} else {
> 		printk("all went fine\n");
> 	}
> ---
>  drivers/video/omap2/omapfb/omapfb.h |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb.h 
> b/drivers/video/omap2/omapfb/omapfb.h
> index 1305fc9..a01b0bb 100644
> --- a/drivers/video/omap2/omapfb/omapfb.h
> +++ b/drivers/video/omap2/omapfb/omapfb.h
> @@ -34,8 +34,10 @@
>  #ifdef DEBUG
>  extern unsigned int omapfb_debug;
>  #define DBG(format, ...) \
> -	if (omapfb_debug) \
> -		printk(KERN_DEBUG "OMAPFB: " format, ## __VA_ARGS__)
> +	do { \
> +		if (omapfb_debug) \
> +			printk(KERN_DEBUG "OMAPFB: " format, ## 
> __VA_ARGS__); \
> +	while (0)

A real good find. Wondering if it really didn't create any problems so far...

~sanjeev

>  #else
>  #define DBG(format, ...)
>  #endif
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 