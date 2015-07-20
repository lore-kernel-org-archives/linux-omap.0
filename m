From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] input: touchscreen: pixcir_i2c_ts: Add support for
 optional wakeup interrupt
Date: Mon, 20 Jul 2015 02:48:03 -0700
Message-ID: <20150720094803.GY17550@atomide.com>
References: <1437115241-17859-1-git-send-email-vigneshr@ti.com>
 <1437115241-17859-2-git-send-email-vigneshr@ti.com>
 <20150717215122.GC39282@dtor-ws>
 <55AC7DA1.9050002@ti.com>
 <20150720060506.GV17550@atomide.com>
 <20150720063323.GC13092@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150720063323.GC13092@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Quadros, Roger" <rogerq-l0cyMroinI0@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Frodo Lai <frodo.lai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150719 23:36]:
> On Sun, Jul 19, 2015 at 11:05:07PM -0700, Tony Lindgren wrote:
> > * Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [150719 21:51]:
> > > On 7/18/2015 3:21 AM, Dmitry Torokhov wrote:
> > > > 
> > > > I wonder if driver core should be responsible for clearing wake irq and
> > > > also for clearing wakeup flag.
> > > > 
> > > 
> > > AFAICU, wakeup flag is deleted when struct device is deleted, hence,
> > > device_init_wakeup() call may not be required in .remove(). But,
> > > dev_pm_clear_wake_irq() can be moved to driver core.
> > 
> > Currently the lifecycle of struct wakeup_source is not necessarily
> > the same as the lifecycle struct device. I believe net and usb drivers
> > at least allocate it dynamically.
> 
> I am not sure if I follow. I was wondering if we should clear the wakeup
> IRQ setting on the driver unbinding. It does not mean that we'd be
> deleting wakeup_source, just that we'll clear wakeup irq setting from
> it.

Yes you're right we can do that. I was mostly commenting on why we
currently can't automate things further with devm.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
