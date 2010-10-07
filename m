From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime api's
Date: Thu, 07 Oct 2010 10:37:03 -0700
Message-ID: <87vd5d9a68.fsf@deeprootsystems.com>
References: <1285078036-12789-1-git-send-email-rnayak@ti.com>
	<1285078036-12789-2-git-send-email-rnayak@ti.com>
	<1285078036-12789-3-git-send-email-rnayak@ti.com>
	<1285078036-12789-4-git-send-email-rnayak@ti.com>
	<1285078036-12789-5-git-send-email-rnayak@ti.com>
	<1285078036-12789-6-git-send-email-rnayak@ti.com>
	<20100927223645.GJ21564@trinity.fluff.org>
	<0680EC522D0CC943BC586913CF3768C003FF05981F@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF05988F@dbde02.ent.ti.com>
	<20100928233334.GS21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100928233334.GS21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org> (Ben Dooks's message
	of "Wed, 29 Sep 2010 00:33:34 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "linux-i2c@vger.kernel.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux@fluff.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali@linux-fr.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:

[...]

> As such, I should really go and read up all about this new runtime-pm
> and hwmod stuff before further commentign on the changes.

ping

>From the drivers perspective, you don't neet to know anything about
omap_hwmod.  You can think of this change as simply using the runtime PM
API instead of the clock API for enabling and idling the device.

With your ack (on this patch only) we'd like to merge this along with
the rest of the series for 2.6.37.

Kevin
