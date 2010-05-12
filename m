From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
Date: Wed, 12 May 2010 17:59:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C54EF825@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D12CB@dbde02.ent.ti.com>
 <877hni5akk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59654 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0ELM3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 08:29:16 -0400
In-Reply-To: <877hni5akk.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

> 
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> Sent: Saturday, May 01, 2010 5:34 AM
> >> To: Varadarajan, Charulatha
> >> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com;
> tony@atomide.com
> >> Subject: Re: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
> >>
[...]
> >> >
> >> > +static int init_gpio_info(void)
> >> > +{
> >> > +   gpio_bank_bits = 32;
> >> > +
> >> > +   if (cpu_is_omap15xx()) {
> >> > +           gpio_bank_count = 2;
> >> > +           gpio_bank_bits = 16;
> >> > +   } else if (cpu_is_omap16xx()) {
> >> > +           gpio_bank_count = 5;
> >> > +           gpio_bank_bits = 16;
> >> > +   } else if (cpu_is_omap7xx())
> >> > +           gpio_bank_count = 7;
> >> > +   else if (cpu_is_omap242x())
> >> > +           gpio_bank_count = 4;
> >> > +   else if (cpu_is_omap243x())
> >> > +           gpio_bank_count = 5;
> >> > +   else if (cpu_is_omap34xx() || cpu_is_omap44xx())
> >> > +           gpio_bank_count = OMAP34XX_NR_GPIOS;
> >>
> >> Both the bank count and bank bits could be part of platform_data
> >> and set in the SoC specific init.  This is the GPIO driver part
> >> and we're trying to make this as SoC independent as possible.  Anytime
> >> you need to add a cpu_is* or #ifdef in this code indicates something
> >> that should be part of SoC specific init and passed in.
> >
> > bank count and bank bits are not specific to each device, but SoC specific.
> > Hence I did not consider passing it as part of platform_data, because this
> information would be duplicated across all devices in that SoC.
> >
> > It would be good if we have a way to pass the SoC specific data which is
> > common for all the devices rather than duplicating them by sending them via
> > platform_data.
> >
> > Anyways, I can move it to platform_data if there is no other way.
> 
> Probably the right place for the SoC specifics is attached to the SoC
> specific hwmod using the dev_attr pointer.  That struct can then
> be passed in via platform_data.
> 
> You can see how Thara did this for SmartReflex as an example.
> 

Using dev_attr for OMAP2PLUS is fine. How about OMAP1? 
1. To be implemented in a uniform way, may I get this info as 
part of platform_data? 
2. Use dev_attr for OMAP2PLUS and use platform_data for OMAP1? 

Any other way? Please suggest.
