From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Wed, 11 Mar 2015 12:16:39 +0100
Message-ID: <1426072599.4244.98.camel@x220>
References: <20150309205157.GE5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150309205157.GE5140@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dave Jones <davej@codemonkey.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2015-03-09 at 13:51 -0700, Tony Lindgren wrote:
> --- /dev/null
> +++ b/drivers/phy/phy-dm816x-usb.c
> @@ -0,0 +1,295 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

So you probably want
    MODULE_LICENSE("GPL");

here.


Paul Bolle
