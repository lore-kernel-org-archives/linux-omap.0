From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Thu, 18 Feb 2010 15:49:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03215B1172@dbde02.ent.ti.com>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <20100217161509.GA13324@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
 <20100218094814.GD3315@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244Ab0BRKTn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 05:19:43 -0500
In-Reply-To: <20100218094814.GD3315@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

 

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> Sent: Thursday, February 18, 2010 3:18 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Liam Girdwood; Samuel Ortiz
> Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel 
> calculations in set/get voltage apis
> 
> On Thu, Feb 18, 2010 at 12:02:49PM +0530, Nayak, Rajendra wrote:
> 
> > > This looks wrong - this code is inside a loop over vsel->voltage
> > > mappings, if that mapping is wrong and needs to be 
> ignored (which is
> > > what this code is doing) then we shouldn't be looking at 
> it at all.
> 
> > Not sure if I understood your comment completely, but 
> here's how I think
> > it will work.
> 
> > The for loop runs through all the valid voltages supported 
> by the regulator
> > and and when it finds the first in-range value programs the 
> VOLTAGE register.
> > For twl4030 the VOLTAGE register can be programmed with 
> just the index
> > of the table since the mapping was something like
> 
> > 1800mV = 0x0
> > 2800mV = 0x1
> > 2900mV = 0x2
> > 3000mV = 0x3
> 
> > Now for twl6030 I just have added an additional vsel 
> calulation part after
> > the in-range value is found, since using the table index 
> directly as vsel
> > would not work.
> 
> Right, but this means that the code is looking at one table 
> of values to
> find a voltage it likes and then picking the actual selector from
> another set of values.  This means that depending on the actual
> differences it may either pick a value which isn't valid for 
> the TWL6030
> or omit values which the TWL6030 can actually support.  
> Either way from
> a code inspection point of view the code doesn't look good due to the
> mismatch between the two sets of selectors.
> 
> The TWL6030 case should be doing something more like other regulator
> drivers with straightforward mappings between selector and 
> voltage (most
> of them) and not using the TWL4030 value table.

The code is'nt looking into twl4030 tables for finding the valid
voltage for twl6030. There are seperate tables for twl4030 and twl6030
regulators with all the valid supported voltages.

The difference is, in case of twl4030 once you find a valid voltage
from the right table you could just use the table index to program
the register on twl4030.
In case of twl6030, once you find a valid voltage, again from the right
table (meant for twl6030) you still need to derive
what value needs to be programmed in the register, so twl6030 understands
it. Using the table index does not help.

Example:
In case of TWL4030
static const u16 VAUX1_VSEL_table[] = {
        2500, 2800, 3000, 3000, 3000, 3000,
};

If the request is to set 2800mv, look up the table,
once found program the VOLTAGE register with the table
index. In this case 0x1.

So the mapping is
VOLTAGE_REG=0x0, VAUX1=2500mv
VOLTAGE_REG=0x1, VAUX1=2800mv
VOLTAGE_REG=0x2, VAUX1=3000mv

In case of TWL6030
static const u16 VAUX1_6030_VSEL_table[] = {
        1000, 1300, 1800, 2500,
        2800, 2900, 3000, 3000,
};

if the request is to set 2800mv, look up the table,
once found calulate the value to be programmed
value = (2800 - 1000)/100 + 1 = 0x13

So here the mapping is
VOLTAGE_REG=0x10, VAUX1=2500mv
VOLTAGE_REG=0x13, VAUX1=2800mv
VOLTAGE_REG=0x15, VAUX1=3000mv

Without this patch the code goes ahead and programs
the table index (In this case 0x4) which is wrong 

> 