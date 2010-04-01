From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 3/8] OMAP2:GPIO:Add support for early platform gpio
 device
Date: Thu, 1 Apr 2010 14:26:26 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4B8F296@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47527 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331Ab0DAI4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 04:56:37 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>



> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Thursday, April 01, 2010 2:24 PM
> To: 'felipe.balbi@nokia.com'
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com; tony@atomide.com
> Subject: RE: [PATCH 3/8] OMAP2:GPIO:Add support for early platform gpio device
> 
> 
> 
> > -----Original Message-----
> > From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> > Sent: Thursday, April 01, 2010 12:56 PM
> > To: Varadarajan, Charulatha
> > Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com;
> tony@atomide.com
> > Subject: Re: [PATCH 3/8] OMAP2:GPIO:Add support for early platform gpio device
> >
> > On Wed, Mar 31, 2010 at 02:23:54PM +0200, ext Charulatha V wrote:
> > >+static inline struct gpio_bank *omap2_get_gpio_bank(int gpio,
> > >+                                       struct gpio_bank *gpio_bank)
> > >+{
> > >+       if (cpu_is_omap24xx())
> > >+               return &gpio_bank[gpio >> 5];
> > >+       BUG();
> >
> > so if we build support omap 2420 and 3430 we will have a BUG() ??
> 
> Multi-OMAP build will not give a BUG(). If this function is called during non-3430
> OMAP arch, it will have a BUG().

A correction - it would give BUG() for non-24xx OMAP, if called.

> 
> >
> > --
> > balbi
