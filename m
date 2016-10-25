From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Tue, 25 Oct 2016 10:32:37 +0200
Message-ID: <20161025083237.GF12024@localhost>
References: <20161020153749.GC12413@localhost>
 <20161021070848.rum7wrlihjayqdbh@atomide.com>
 <20161021092530.GO2765@localhost>
 <20161021094904.q66kjsl33yzf2kir@atomide.com>
 <20161021110725.GA5192@localhost>
 <20161021112745.lancojpgv4h6aqpw@atomide.com>
 <20161024173538.26xvlitxiwjmh4fx@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161024173538.26xvlitxiwjmh4fx-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 24, 2016 at 10:35:38AM -0700, Tony Lindgren wrote:

> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Mon, 24 Oct 2016 09:18:02 -0700
> Subject: [PATCH] usb: musb: Fix sleeping function called from invalid
>  context for hdrc glue
> 
> Commit 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> glue layer") wrongly added a call for pm_runtime_get_sync to otg_timer
> that runs in softirq context. That causes a "BUG: sleeping function called
> from invalid context" every time when polling the cable status:
> 
> [<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
> [<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
> [<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
> [<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
> [<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
> [<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)
> 
> I did not notice that as I did not have CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> 
> Let's fix the issue by adding dsps_check_status() and dsps_runtime_resume()
> functions. And let's have otg_timer() check for the PM runtime status, and
> if not already enabled, have dsps_runtime_resume() call dsps_check_status()
> directly.

While this makes the sleeping-while-atomic warning go away, it does not
seem correct. In case we were suspended, the glue layer will now call
dsps_check_status while the controller (child) is still suspended:

[    8.577538] musb-hdrc musb-hdrc.0.auto: otg_timer
[    8.582642] musb-dsps 47401400.usb: dsps_runtime_resume
[    8.600651] musb-hdrc musb-hdrc.0.auto: dsps_check_status
[    8.630617] musb-hdrc musb-hdrc.0.auto: musb_runtime_resume

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
