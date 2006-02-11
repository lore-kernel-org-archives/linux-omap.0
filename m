From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] omap camera
Date: Sat, 11 Feb 2006 05:50:04 -0800 (PST)
Message-ID: <20060211135004.8723.qmail@web32905.mail.mud.yahoo.com>
References: <43ECFF9B.80509@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43ECFF9B.80509@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Cohen <david.cohen@indt.org.br>, "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- David Cohen <david.cohen@indt.org.br> wrote:

> diff --git a/drivers/media/video/omap/omap24xxcam.c
> b/drivers/media/video/omap/omap24xxcam.c
> new file mode 100644
> index 0000000..8133804

> +#include <asm/arch/display.h>

Where is this dispc library? It still needs discussion with Imre on how
we can integrate video out driver.

> */
> +#ifdef CONFIG_OMAP24XX_DPM
> +#define omap24xxcam_suspend_lockout(s,f) \
> +	if ((s)->suspended) {\
> +		if ((f)->f_flags & O_NONBLOCK)\
> +			return -EBUSY;\
> +		wait_event_interruptible((s)->suspend_wq,\
> +					(s)->suspended == 0);\
> +	}
> +#else
> +#define omap24xxcam_suspend_lockout(s, f) do {} while(0)
> +#endif

You may want to remove this for a while, until we come up with PM 
support for OMAP2.

> +		/* always use the rising edger to trigger the acquisition
> +		   in NOBT modes. This is recommended */
> +		cam->cc_ctrl |= CC_CTRL_NOBT_SYNCHRO;

s/edger/edge 

> +					omap2_disp_get_panel_size(
> +					 omap2_disp_get_output_dev(cam->vid_preview),
> +				  	 &(cam->fbuf.fmt.width),
> +				  	 &(cam->fbuf.fmt.height));

Hmm...This patch doesn't have these functions.

> +					/* Get the panel parameters.
> +					 * They can change from LCD to TV
> +					 * or TV to LCD
> +					 */
> +					omap2_disp_get_panel_size(
> +					 omap2_disp_get_output_dev(cam->vid_preview),
> +				  	 &(cam->fbuf.fmt.width),
> +				  	 &(cam->fbuf.fmt.height));

Ditto...

> +					omap2_disp_get_dss();
> +
> +					/* Turn on the overlay window */
> +					omap2_disp_config_vlayer(cam->
> +								 vid_preview,
> +								 &cam->pix,
> +								 &cam->crop,
> +								 &cam->win, -1,
> +								 0);
> +					omap2_disp_start_vlayer(cam->
> +								vid_preview,
> +								&cam->pix,
> +								&cam->crop,
> +								cam->
> +								overlay_base_phys,
> +								-1, 0);
> +					cam->previewing = fh;

Ditto..And all other places where you have dispc library dependancy. 
My suggestion is to leave those code references right now, and to
have camera code working with file dump or previewing through 
fb driver, which can be handled then in user space application until
we sort out video out driver integration. But it can be further delayed
if we don't like OMAP2 dipsc hardware based color-space conversion,
overlays ...and don't want to use it completely :)

>  
> +	/* These are for power management */
>  	int (*power_on)(void *);
>  	int (*power_off)(void *);

You might want to add power functions through GPIO expander for H4 EVM.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
