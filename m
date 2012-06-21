From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 03/13] I2C: OMAP: Remove reset at init
Date: Thu, 21 Jun 2012 12:33:44 +0530
Message-ID: <4FE2C750.3020803@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com> <1340029828-20751-4-git-send-email-shubhrajyoti@ti.com> <20120620102905.GC12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120620102905.GC12766-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 20 June 2012 03:59 PM, Tony Lindgren wrote:
> See the comments regarding driver specific resets in hwmod code.
you mean omap_hwmod.c
>
> The way to set this up is to have a shared inline function in
> i2c-omap.h that both the driver and hwmod code can use.
hwmod reset function uses oh (omap_hwmod).

How could the driver also pass oh ?
Could we keep a local copy in driver data?
> Eventually hwmod code will do the reset only in late initcall
> if no driver is loaded for the device in question.
