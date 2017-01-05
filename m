From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-chilisom: Wakeup from RTC-only state by
 power on event
Date: Thu, 5 Jan 2017 08:47:06 -0800
Message-ID: <20170105164706.GE4310@atomide.com>
References: <20161209113327.19727-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161209113327.19727-1-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [161209 03:33]:
> On chiliSOM TPS65217 nWAKEUP pin is connected to AM335x internal RTC
> EXT_WAKEUP input. In RTC-only state TPS65217 is notifying about power on
> events (such as power buton presses) by setting nWAKEUP output
> low. After that it waits 5s for proper device boot. Currently it doesn't
> happen, as the processor doesn't listen for such events. Consequently
> TPS65217 changes state from SLEEP (RTC-only state) to OFF.
> 
> Enable EXT_WAKEUP input of AM335x's RTC, so the processor can properly
> detect power on events and recover immediately from RTC-only states,
> without powering off RTC and losing time.

Applying into omap-for-v4.11/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
