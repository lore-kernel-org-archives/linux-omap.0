From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib implementations
Date: Mon, 29 Aug 2011 11:23:34 -0700
Message-ID: <87bov8t6u1.fsf@ti.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1QqhM1-0003af-U5-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org> (Russell King's
	message of "Tue, 09 Aug 2011 09:08:01 +0100")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> writes:

> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
>
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

For OMAP:

Tested-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

Also goes for patches 12 & 13 also.

Kevin
