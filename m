From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] DT: EVM: add LEDs
Date: Wed, 28 Sep 2016 08:12:35 -0700
Message-ID: <20160928151234.c3x36lhnvk4potdy@atomide.com>
References: <cover.1474953969.git.hns@goldelico.com>
 <d68619a23d642eacf12fd0a3c51f19d006436cbe.1474953969.git.hns@goldelico.com>
 <20160927194904.4im7ukktg5afjmki@atomide.com>
 <21B97601-328A-41DC-84EE-AA15A6977E98@goldelico.com>
 <20160928033703.erwozguik4rie3cn@atomide.com>
 <6004B143-F64B-4DA9-A054-3F2AB3FC2346@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6004B143-F64B-4DA9-A054-3F2AB3FC2346-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160927 23:50]:
> Hi,
> 
> > Am 28.09.2016 um 05:37 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > 
> > * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160927 13:11]:
> >>> Am 27.09.2016 um 21:49 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> >>> How about this for defaults:
> >>> 
> >>> - heartbeat for led3
> >>> - cpu0 for led4
> >>> - cpu1 for led5
> >> 
> >> Good idea. Will try.
> >> 
> >> What I don't exactly know is if these gpios based on an I2C-expander
> >> can handle cpu activity triggers or if they are locked up if this i2c
> >> processing triggers another cpu activity...
> > 
> > Oh right, if the GPIOs are on the i2c bus
> 
> yes, they are all gpio9 which is the tca6424 on i2c5.
> 
> > it's probably not a good
> > idea :) Or at least will be inaccurate if the bus can sleep.
> 
> I have tested a little by writing to /sys/class/leds/.../trigger.
> 
> If I make one LED trigger by "cpu0" it is always on and if I make
> a second one triggered by "cpu1" the heartbeat becomes irregular.
> 
> So indeed this does not work.

So should we just leave the default trigger unpopulated then?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
