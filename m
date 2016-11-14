From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] usb: musb: Add missing pm_runtime_disable and drop
 2430 PM timeout
Date: Mon, 14 Nov 2016 16:57:09 +0100
Message-ID: <20161114155709.GU14744@localhost>
References: <20161111184302.2438-1-tony@atomide.com>
 <20161111184302.2438-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161111184302.2438-6-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 11, 2016 at 10:43:01AM -0800, Tony Lindgren wrote:
> We are missing pm_runtime_disable() in 2430 glue layer. Further,
> we only need to enable PM runtime and disable it on exit. With
> musb_core.c doing PM, the glue layer as a parent will always be
> active when musb_core.c is active.

In fact, we have to do this way to avoid a crash in omap2430_remove().

> This fixes host enumeration issues with some devices as reported
> by Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>.
> 
> If changes are needed to the autosuspend timeout, it should be
> done in musb_core.c.
> 
> Reported-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> Fixes: 87326e858448 ("usb: musb: Remove extra PM runtime calls from
> 2430 glue layer")
> Tested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> @@ -535,10 +536,7 @@ static int omap2430_remove(struct platform_device *pdev)
>  {
>  	struct omap2430_glue *glue = platform_get_drvdata(pdev);
>  
> -	pm_runtime_get_sync(glue->dev);
>  	platform_device_unregister(glue->musb);
> -	pm_runtime_put_sync(glue->dev);

Holding an RPM reference while deregistering the child, would lead to a
crash in omap2430_runtime_suspend() which dereferences the now freed
child's driver data on put.

Unable to handle kernel paging request at virtual address 6b6b6f17
...
[<c05453d4>] (omap2430_runtime_suspend) from [<c0481410>] (pm_generic_runtime_suspend+0x3c/0x48)
[<c0481410>] (pm_generic_runtime_suspend) from [<c0121028>] (_od_runtime_suspend+0x1c/0x30)
[<c0121028>] (_od_runtime_suspend) from [<c04833b0>] (__rpm_callback+0x3c/0x70)
[<c04833b0>] (__rpm_callback) from [<c0483414>] (rpm_callback+0x30/0x90)
[<c0483414>] (rpm_callback) from [<c0483984>] (rpm_suspend+0x118/0x6b4)
[<c0483984>] (rpm_suspend) from [<c04840f4>] (rpm_idle+0x104/0x440)
[<c04840f4>] (rpm_idle) from [<c04844ac>] (__pm_runtime_idle+0x7c/0xb0)
[<c04844ac>] (__pm_runtime_idle) from [<c0545458>] (omap2430_remove+0x38/0x58)
[<c0545458>] (omap2430_remove) from [<c047b2bc>] (platform_drv_remove+0x34/0x4c)

> -	pm_runtime_dont_use_autosuspend(glue->dev);
>  	pm_runtime_disable(glue->dev);
>  
>  	return 0;

This might be worth mentioning in the commit message, but feel free to
add

Reviewed-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

either way.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
