From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv11 4/6] i2c: omap: Remove the definition of SYSS_RESETDONE_MASK
Date: Fri, 13 Jul 2012 16:35:10 +0530
Message-ID: <500000E6.4050606@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com> <1340896292-12112-5-git-send-email-shubhrajyoti@ti.com> <20120712122053.GD2194@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120712122053.GD2194-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 12 July 2012 05:50 PM, Wolfram Sang wrote:
>> +#include <plat/omap_hwmod.h>
> Hmmm, so far the driver has no plat/mach dependencies and now this gets
> added. Need to think about it a bit more...
OK .
