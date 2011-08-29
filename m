From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5 v4] mfd: omap: usb: Runtime PM support
Date: Mon, 29 Aug 2011 11:50:03 -0700
Message-ID: <87mxesrr1g.fsf@ti.com>
References: <1312899309-24067-1-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-2-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-3-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-4-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-5-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-6-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312899309-24067-6-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
	(Keshava Munegowda's message of "Tue, 9 Aug 2011 19:45:09 +0530")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:

> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>
> The usbhs core driver does not enable/disable the intefrace and
> fucntional clocks; These clocks are handled by hwmod and runtime pm,
> hence insted of the clock enable/disable, the runtime pm APIS are
> used. however,the port clocks are handled by the usbhs core.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

General comment: all usage of pm_runtime_put_sync() can likely be
replaced by the asynchronous versions.  I don't currently see why the
synchronous verions are needed here.

Other than that, the runtime PM parts of this look OK to me.  After
changing to asynchonous puts, feel free to add:

Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>


Also, after a quick glance, it looks like this version of the series
addresses the problems seen by Jassi Brar with the TLL reset[1].  Please
confirm.

Speaking of which, it's helpful to Cc folks who have had comments on
previous versions of your series so they are sure they're previous
issues are addressed.   I've Cc'd Jassi Brar.

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&m=130921260703865&w=2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
