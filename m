From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Thu, 18 Feb 2010 12:02:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <20100217161509.GA13324@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54296 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728Ab0BRGdX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 01:33:23 -0500
In-Reply-To: <20100217161509.GA13324@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

 

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> Sent: Wednesday, February 17, 2010 9:45 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Liam Girdwood; Samuel Ortiz
> Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel 
> calculations in set/get voltage apis
> 
> On Wed, Feb 17, 2010 at 08:54:14PM +0530, Rajendra Nayak wrote:
> 
> >  		/* use the first in-range value */
> > -		if (min_uV <= uV && uV <= max_uV)
> > +		if (min_uV <= uV && uV <= max_uV) {
> > +			if (twl_class_is_6030())
> > +				/*
> > +				 * Use the below formula to 
> calculate vsel
> > +				 * mV = 1000mv + 100mv * (vsel - 1)
> > +				 */
> > +				vsel = (LDO_MV(mV) - 1000)/100 + 1;
> >  			return twlreg_write(info, 
> TWL_MODULE_PM_RECEIVER,
> >  							
> VREG_VOLTAGE, vsel);
> 
> This looks wrong - this code is inside a loop over vsel->voltage
> mappings, if that mapping is wrong and needs to be ignored (which is
> what this code is doing) then we shouldn't be looking at it at all.

Mark,

Not sure if I understood your comment completely, but here's how I think
it will work.

The for loop runs through all the valid voltages supported by the regulator
and and when it finds the first in-range value programs the VOLTAGE register.
For twl4030 the VOLTAGE register can be programmed with just the index
of the table since the mapping was something like
1800mV = 0x0
2800mV = 0x1
2900mV = 0x2
3000mV = 0x3

Now for twl6030 I just have added an additional vsel calulation part after
the in-range value is found, since using the table index directly as vsel
would not work.

regards,
Rajendra

> 