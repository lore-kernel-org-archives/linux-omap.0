From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx
 devices
Date: Wed, 5 Dec 2012 09:16:16 -0800
Message-ID: <20121205171616.GE21682@atomide.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
 <1354460467-28006-5-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354460467-28006-5-git-send-email-tom.leiming@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Ming Lei <tom.leiming@gmail.com> [121202 07:05]:
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c

...

> +
> +static struct notifier_block usb_port_nb = {
> +	.notifier_call = device_notify,
> +};
> +

We'll be flipping omap4 over to be device tree only soon.
So let's not make the conversion more complex by adding more
platform code.

This means that for am33xx, omap4, and omap5 this code
can be device tree only code.

Regards,

Tony
