From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAPFB: panel-sony-acx565akm: fix bad unlock balance
Date: Mon, 11 Nov 2013 20:37:30 +0200
Message-ID: <20131111183730.GA30010@blackmetal.musicnaut.iki.fi>
References: <1383773070-15114-1-git-send-email-aaro.koskinen@iki.fi>
 <5280DDA1.304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5280DDA1.304@ti.com>
Sender: stable-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Nov 11, 2013 at 03:37:37PM +0200, Tomi Valkeinen wrote:
> On 2013-11-06 23:24, Aaro Koskinen wrote:
> > When booting Nokia N900 smartphone with v3.12 + omap2plus_defconfig
> > (LOCKDEP enabled) and CONFIG_DISPLAY_PANEL_SONY_ACX565AKM enabled,
> > the following BUG is seen during the boot:
> > 
> > [    7.302154] =====================================
> > [    7.307128] [ BUG: bad unlock balance detected! ]
> > [    7.312103] 3.12.0-los.git-2093492-00120-g5e01dc7 #3 Not tainted
> > [    7.318450] -------------------------------------
> > [    7.323425] kworker/u2:1/12 is trying to release lock (&ddata->mutex) at:
> > [    7.330657] [<c031b760>] acx565akm_enable+0x12c/0x18c
> > [    7.335998] but there are no more locks to release!
> > 
> > Fix by removing the extra mutex_unlock().
> > 
> > Reported-by: Eduardo Valentin <eduardo.valentin@ti.com>
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/video/omap2/displays-new/panel-sony-acx565akm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> > index e6d56f7..72fe2a8 100644
> > --- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> > +++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> > @@ -616,7 +616,7 @@ static int acx565akm_enable(struct omap_dss_device *dssdev)
> >  
> >  	mutex_lock(&ddata->mutex);
> >  	r = acx565akm_panel_power_on(dssdev);
> > -	mutex_unlock(&ddata->mutex);
> > +	/* NOTE: acx565akm_panel_power_on() will unlock the mutex. */
> >  
> >  	if (r)
> >  		return r;
> > 
> 
> Hm why would you fix it like this? Why not remove the mutex_unlock from
> acx565akm_panel_power_on()? Looks to me like that one is the buggy one.

The unlock needs to be there because acx565akm_bl_update_status()
also locks the mutex. I'll send a new version where the mutex_lock()
is done inside acx565akm_panel_power_on().

A.
