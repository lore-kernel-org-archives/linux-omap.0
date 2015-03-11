From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Wed, 11 Mar 2015 08:20:15 -0700
Message-ID: <20150311152015.GW5264@atomide.com>
References: <20150309205157.GE5140@atomide.com>
 <1426072599.4244.98.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426072599.4244.98.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dave Jones <davej@codemonkey.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [150311 04:16]:
> On Mon, 2015-03-09 at 13:51 -0700, Tony Lindgren wrote:
> > --- /dev/null
> > +++ b/drivers/phy/phy-dm816x-usb.c
> > @@ -0,0 +1,295 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> 
> This states the license is GPL v2 or later.
> 
> > +MODULE_LICENSE("GPL v2");
> 
> So you probably want
>     MODULE_LICENSE("GPL");
> 
> here.

Oh, it should be just GPL v2 like most of the kernel. Probably copied
the header from some other phy driver, will update that instead.

Thanks,

Tony
