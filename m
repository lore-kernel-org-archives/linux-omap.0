From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: RE: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime suspend
Date: Mon, 31 Jan 2011 20:58:29 +0530
Message-ID: <266a2f0ec446d693cf9583681ca346e0@mail.gmail.com>
References: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com> <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1101311010580.1931-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Alan Stern [mailto:stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org]
> Sent: Monday, January 31, 2011 8:43 PM
> To: Rajendra Nayak
> Cc: Kevin Hilman; Ben Dooks; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs.
runtime suspend
>
> On Mon, 31 Jan 2011, Rajendra Nayak wrote:
>
> > Can you elaborate a bit more on how/why runtime PM transitions
> > are disabled during system suspend, and how is it taken care
> > of that a runtime resume of a device works however a subsequent
> > runtime (re)suspend does not?
>
> I'll answer for Kevin.  This is done by the PM core, in order to
> prevent runtime power transitions from interfering with a system power
> transition.  The PM core increments the device's usage_count; this
> prevents the device from being runtime-suspended but it allows
> runtime-resume calls to go through.

Thanks, I did remember seeing the pm_runtime_get_noresume()
in dpm_prepare(). Just did not correlate it was the same Kevin
was trying to say.

Regards,
Rajendra

>
> Alan Stern
