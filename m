From: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is... from
 driver
Date: Wed, 15 Jun 2011 19:27:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106151919070.2142@xanadu.home>
References: <1306973984-15165-1-git-send-email-khilman@ti.com> <20110615213637.GH15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110615213637.GH15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 15 Jun 2011, Ben Dooks wrote:

> On Wed, Jun 01, 2011 at 05:19:26PM -0700, Kevin Hilman wrote:
> > Ben, 
> > 
> > Please pull in this series from Andy Green for the next merge window.
> > 
> > v4 is simply a rebase of Andy's v3 against v3.0-rc1 with some basic
> > sanity testing against with the latest kernel.
> 
> These look much more like functionality changes than actual fixes, and
> are much more suited for inclusion into -next for once the next stable
> release is out.

What do you mean, exactly?  The merge window, as opposed to 
the -rc period, is good for functionality changes, no?

Those patches have been out for quite a while, and they got quite 
extensive testing in the OMAP tree, and in the kernel included with the 
Linaro 11.05 release as well.


Nicolas
