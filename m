From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: OMAP: dmtimer: Do not call PM runtime functions
 when not needed.
Date: Mon, 9 May 2016 12:36:24 -0700
Message-ID: <20160509193624.GH5995@atomide.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-6-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462634508-24961-6-git-send-email-ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160507 08:24]:
> once omap_dm_timer_start() is called, which calls omap_dm_timer_enable()
> and thus pm_runtime_get_sync(), it doesn't make sense to call PM runtime
> functions again before omap_dm_timer_stop is called(). Otherwise PM runtime
> functions called in omap_dm_timer_enable/disable lead to long and unneeded
> delays.
> 
> Fix that by implementing an "enabled" counter, so the PM runtime functions
> get called only when really needed.
> 
> Without that patch Nokia N900 IR TX driver (ir-rx51) does not function.

We should use pm_runtime for the refcounting though and call PM runtime
unconditionally. Can you try to follow the standard PM runtime usage
like this:

init:
pm_runtime_use_autosuspend(&timer->pdev->dev);
pm_runtime_set_autosuspend_delay(&timer->pdev->dev, 200);
pm_runtime_enable(&timer->pdev->dev);
...
enable:
pm_runtime_get_sync(&timer->pdev->dev);
...
disable:
pm_runtime_mark_last_busy(&timer->pdev->dev);
pm_runtime_put_autosuspend(&timer->pdev->dev);
...
exit:
pm_runtime_dont_use_autosuspend(&timer->pdev->dev);
pm_runtime_put_sync(&timer->pdev->dev);
pm_runtime_disable(&timer->pdev->dev);

No idea what the timeout should be, maybe less than 200 ms. Also we need
to test that off idle still works with timer1, that might need special
handling.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
