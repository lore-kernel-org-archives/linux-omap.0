From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: Convert timers to use timer_setup()
Date: Thu, 09 Nov 2017 18:08:26 +0100
Message-ID: <15752127.NCT7iFVURk@amdc3058>
References: <CGME20171024152032epcas3p4976e268e33d58750b7c09380e857bba0@epcas3p4.samsung.com>
        <20171024152026.GA104655@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171024152026.GA104655@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Lechner <david@lechnology.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <seanpaul@chromium.org>, Jean Delvare <jdelvare@suse.de>, Hans de Goede <hdegoede@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, October 24, 2017 08:20:26 AM Kees Cook wrote:

> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> index 933619da1a94..e88447eac32c 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -513,16 +513,10 @@ pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
>  #ifdef PXA3XX_GCU_DEBUG_TIMER
>  static struct timer_list pxa3xx_gcu_debug_timer;
>  
> -static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
> +static void pxa3xx_gcu_debug_timedout(struct timer_list *unused)
>  {
> -	struct pxa3xx_gcu_priv *priv = (struct pxa3xx_gcu_priv *) ptr;
> -
>  	QERROR("Timer DUMP");

QERROR() macro is using priv so this code now fails to build.

[ Please compile these timer changes with PXA3XX_GCU_DEBUG and
  PXA3XX_GCU_DEBUG_TIMER defined. ]

Also please port your changes over fbdvev-for-next tree as
currently this patch doesn't apply (fbdev tree contains
"video: fbdev: pxa3xx_gcu: Use setup_timer and mod_timer"
cleanup).

> -	/* init the timer structure */
> -	init_timer(&pxa3xx_gcu_debug_timer);
> -	pxa3xx_gcu_debug_timer.function = pxa3xx_gcu_debug_timedout;
> -	pxa3xx_gcu_debug_timer.data = ptr;
>  	pxa3xx_gcu_debug_timer.expires = jiffies + 5*HZ; /* one second */
>  
>  	add_timer(&pxa3xx_gcu_debug_timer);
> @@ -530,7 +524,9 @@ static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
>  
>  static void pxa3xx_gcu_init_debug_timer(void)
>  {
> -	pxa3xx_gcu_debug_timedout((unsigned long) &pxa3xx_gcu_debug_timer);
> +	/* init the timer structure */
> +	timer_setup(&pxa3xx_gcu_debug_timer, pxa3xx_gcu_debug_timedout, 0);
> +	pxa3xx_gcu_debug_timedout(NULL);
>  }
>  #else
>  static inline void pxa3xx_gcu_init_debug_timer(void) {}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
