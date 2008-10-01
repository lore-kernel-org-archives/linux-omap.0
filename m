From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2.6.27-rc8 1/2] drivers/mfd/twl4030-core.c
Date: Wed, 1 Oct 2008 13:19:25 -0700
Message-ID: <200810011319.26780.david-b@pacbell.net>
References: <200810011144.20510.david-b@pacbell.net> <20081001124407.aa090ccd.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:34472 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753667AbYJAUT3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 16:19:29 -0400
In-Reply-To: <20081001124407.aa090ccd.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Samuel Ortiz <sameo@openedhand.com>, lkml <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Wednesday 01 October 2008, Randy Dunlap wrote:

> > +	  These multi-function chps are found on many OMAP2 and OMAP3
> 
> 	                       chips

Indeed ... although if e e cummings could write poetry without
uppercase, surely in this modern age some literature will be
forthcoming that uses no vwls?  (Oh wait.  That's Hebrew.  ;)


> > --- /dev/null
> > +++ b/include/linux/i2c/twl4030-madc.h
> > @@ -0,0 +1,134 @@
> > +/*
> > + * include/linux/i2c/twl4030-madc.h
> > + *
> > + * TWL4030 MADC module driver header
> > + *
> > + * Copyright (C) 2008 Nokia Corporation
> > + * Mikko Ylinen <mikko.k.ylinen@nokia.com>
> 
> 
> > +#define TWL4030_MADC_IOC_MAGIC '`'
> 
> Add that to Documentation/ioctl-number.txt (?)

Actually one of my own review comments is that this header
should become unneccessary ... and everything associated
with it be dealt with when this Multi-channel ADC driver
gets pushed upstream.  IRQ initialization needs to be done
in the core, but none of the other MADC stuff matters here.

Thanks.


- Dave
