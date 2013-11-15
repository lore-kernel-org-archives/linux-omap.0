From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 9/8] i2c: Fix device tree binding for i2c-cbus-gpio
Date: Fri, 15 Nov 2013 20:49:46 +0200
Message-ID: <20131115184946.GB10997@blackmetal.musicnaut.iki.fi>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <20131114230842.GU10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131114230842.GU10317-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Nov 14, 2013 at 03:08:42PM -0800, Tony Lindgren wrote:
> Looks like we're missing two lines needed to make it
> work properly with device tree.
> 
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>

You can change this to: Tested-by: <aaro.koskinen-X3B1VOXEql0@public.gmane.org>

I booted DT-N800 with Tony's patches, and it works.

Thanks,

A.
