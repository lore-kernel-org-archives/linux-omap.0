From: Olivier Gayot <ogayot-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] usb: musb_dsps: fix the exit routine for debugfs
Date: Thu, 24 Apr 2014 11:07:34 +0200
Message-ID: <20140424110734.1f83b52c@blinky>
References: <1398267583-19159-1-git-send-email-ogayot@baylibre.com>
 <20140423155529.GL9593@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140423155529.GL9593-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ok, thank you, I didn't notice the existing thread.

On Wed, 23 Apr 2014 10:55:29 -0500
Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:

> On Wed, Apr 23, 2014 at 05:39:43PM +0200, Olivier Gayot wrote:
> > The following commit introduced the debugfs :
> > 
> > 40f099e32c2a06bad7d75683421e30fcc74924cd
> > Author: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Date:   Fri Jan 17 10:22:35 2014 +0100
> > 
> >     usb: musb: dsps, debugfs files
> > 
> > Unfortunately, a forgotten call to a cleanup function prevents the
> > probing of musb in case of deferred probe.
> > 
> > Because musb_init_controller() often retries and creates a new
> > debugfs directory each time it is called, we need to remove that
> > directory in case the initialization fails. Otherwise, the
> > debugfs_create_dir() fails at subsequent calls because the
> > directory already exists.
> > 
> > Fixed by calling debugfs_remove_recursive() in the exit function.
> > 
> > Signed-off-by: Olivier Gayot <ogayot-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > Cc: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/usb/musb/musb_dsps.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/musb/musb_dsps.c
> > b/drivers/usb/musb/musb_dsps.c index 3372ded..c3de0a5 100644
> > --- a/drivers/usb/musb/musb_dsps.c
> > +++ b/drivers/usb/musb/musb_dsps.c
> > @@ -471,6 +471,8 @@ static int dsps_musb_exit(struct musb *musb)
> >  
> >  	del_timer_sync(&glue->timer);
> >  
> > +	debugfs_remove_recursive(glue->dbgfs_root);
> > +
> >  	usb_phy_shutdown(musb->xceiv);
> >  	return 0;
> 
> First of all this commit is wrong, second of all I already have the
> proper commit:
> 
> commit 0fca91b8a446d4a38b8f3d4772c4a8665ebcd7b2
> Author: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date:   Wed Apr 2 11:46:51 2014 +0200
> 
>     usb: musb: dsps: move debugfs_remove_recursive()
>     
>     When the platform initialization fails due to missing resources,
> it will return -EPROBE_DEFER after dsps_musb_init() has been called.
>     
>     dsps_musb_init() calls dsps_musb_dbg_init() to allocate the
> debugfs nodes. At a later point in time, the probe will be retried,
> and dsps_musb_dbg_init() will be called again. debugfs_create_dir()
> will fail this time, as the node already exists, and so the entire
> device probe will fail with -ENOMEM.
>     
>     Fix this by moving debugfs_remove_recursive() from dsps_remove()
> to the plaform's exit function, so it will be cleanly torn down when
> the probe fails. It also feels more natural this way, as .exit is the
> counterpart to .init.
>     
>     Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>     Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> 
> diff --git a/drivers/usb/musb/musb_dsps.c
> b/drivers/usb/musb/musb_dsps.c index 3372ded..e2fd263 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -470,8 +470,9 @@ static int dsps_musb_exit(struct musb *musb)
>  	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
>  
>  	del_timer_sync(&glue->timer);
> -
>  	usb_phy_shutdown(musb->xceiv);
> +	debugfs_remove_recursive(glue->dbgfs_root);
> +
>  	return 0;
>  }
>  
> @@ -708,8 +709,6 @@ static int dsps_remove(struct platform_device
> *pdev) pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> -	debugfs_remove_recursive(glue->dbgfs_root);
> -
>  	return 0;
>  }
>  
> 
> a pull request has already been sent to Greg, should be in v3.15-rc3
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
