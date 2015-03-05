From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/15] twl4030_charger: allow max_current to be managed
 via sysfs.
Date: Thu, 5 Mar 2015 09:17:51 +0100
Message-ID: <20150305081751.GA9093@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043351.4243.46323.stgit@notabene.brown>
 <20150302210525.GN13270@amd>
 <20150305172600.30951e70@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150305172600.30951e70@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> > Is this in uA or mA? uA. Ok.
> 
> uA, now described in Documentation/ABI/testing/sysfs-class-power-twl4030
> 
> +What: /sys/class/power_supply/twl4030_ac/max_current
> +      /sys/class/power_supply/twl4030_usb/max_current
> +Description:
> +       Read/Write limit on current which which may
> +       be drawn from the ac (Accessory Charger) or
> +       USB port.
> +
> +       Value is in micro-Amps.
> +
> +       Value is set automatically to an appropriate
> +       value when a cable is plugged on unplugged.
> +
> +       Value can the set by writing to the attribute.
> +       The change will only persist until the next
> +       plug event.  These event are reported via udev.

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
