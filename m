From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Fri, 13 Jan 2017 12:24:20 +0300
Message-ID: <17c98bce-b8fd-33d9-f9f1-65f114306eed@cogentembedded.com>
References: <20170112213016.19367-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170112213016.19367-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello!

On 1/13/2017 12:30 AM, Tony Lindgren wrote:

> Commit fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> together with recent MUSB changes allowed USB and DMA on BeagleBone to idle
> when no cable is connected. But looks like few corner case issues still
> remain.
>
> Looks like just by repluging USB cable about ten or so times on BeagleBone

    Re-plugging.

> when configured in USB peripheral mode we can get warnings and eventually
> trigger an oops in cppi41 DMA:
>
> WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:1154 cppi41_runtime_suspend+
> x28/0x38 [cppi41]
> ...
>
> WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:452
> push_desc_queue+0x94/0x9c [cppi41]
> ...
>
> Unable to handle kernel NULL pointer dereference at virtual
> address 00000104
> pgd = c0004000
> [00000104] *pgd=00000000
> Internal error: Oops: 805 [#1] SMP ARM
> ...
> [<bf0d92cc>] (cppi41_runtime_resume [cppi41]) from [<c0589838>]
> (__rpm_callback+0xc0/0x214)
> [<c0589838>] (__rpm_callback) from [<c05899ac>] (rpm_callback+0x20/0x80)
> [<c05899ac>] (rpm_callback) from [<c0589460>] (rpm_resume+0x504/0x78c)
> [<c0589460>] (rpm_resume) from [<c058a1a0>] (pm_runtime_work+0x60/0xa8)
> [<c058a1a0>] (pm_runtime_work) from [<c0156120>] (process_one_work+0x2b4/0x808)
>
> This is because of a race with PM runtime and cppi41_dma_issue_pending()
> as reported by Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> in earlier
> set of patches. Based on mailing list discussions we however came to the
> conclusion that a different fix from Alexandre's fix is needed in order
> to guarantee that DMA is really active when we try to use it.
>
> To fix the issue, we need to add a driver specific flag as we otherwise
> can have -EINPROGRESS state set by PM runtime and can't rely on

     Runtime PM.

> pm_runtime_active() to tell us when we can use the DMA.
>
> For reference, this is also documented in Documentation/power/runtime_pm.txt
> in the example at the end of the file as pointed out by Grygorii Strashko
> <grygorii.strashko-l0cyMroinI0@public.gmane.org>.
>
> So let's fix the issue by introducing atomic_t active that gets toggled
> in runtime_suspend() and runtime_resume(). And then let's replace the
> pm_runtime_active() checks with atomic_read().
>
> Note that we may also get transactions queued while in -EINPROGRESS
> state. So we need to check for new elements in cppi41_runtime_resume()
> by replacing list_for_each_entry_safe() with the commonly used test for
> while (!list_empty(&cdd->pending)).
>
> Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
> Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> Reported-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
[...]
> @@ -320,7 +323,8 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  			int error;
>
>  			error = pm_runtime_get(cdd->ddev.dev);
> -			if (error < 0)
> +			if (((error != -EINPROGRESS) && error < 0) ||

    Hum, the innermost parens are inconsistent: around != but not around <.

[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
