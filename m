From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Thu, 18 Feb 2010 10:40:32 +0000
Message-ID: <20100218104032.GA3542@rakim.wolfsonmicro.main>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <20100217161509.GA13324@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
 <20100218094814.GD3315@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1172@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47367 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756523Ab0BRKkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 05:40:35 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03215B1172@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Thu, Feb 18, 2010 at 03:49:29PM +0530, Nayak, Rajendra wrote:

> > The TWL6030 case should be doing something more like other regulator
> > drivers with straightforward mappings between selector and 
> > voltage (most
> > of them) and not using the TWL4030 value table.

> The code is'nt looking into twl4030 tables for finding the valid
> voltage for twl6030. There are seperate tables for twl4030 and twl6030
> regulators with all the valid supported voltages.

> The difference is, in case of twl4030 once you find a valid voltage
> from the right table you could just use the table index to program
> the register on twl4030.
> In case of twl6030, once you find a valid voltage, again from the right
> table (meant for twl6030) you still need to derive
> what value needs to be programmed in the register, so twl6030 understands
> it. Using the table index does not help.

In that case the tables for TWL6030 are not ideal as-is and should
either be fixed somehow, have a different function accessing them which
makes their meaning clear or removed and replaced with just the formula.

I know what the code is trying to do, it just seems to be trying to do
it at the wrong abstraction level and so looks buggy on code inspection.
My point here is that the code looks wrong since it's iterating over a
table giving voltage to selector mappings but then ignoring the selector
value it comes up with and instead using a formula which at least gives
way more options than most of the selector tables do.  It's readability
that's my focus here, the code possibly does do exactly what it ought to
but it looks wrong.

> In case of TWL6030
> static const u16 VAUX1_6030_VSEL_table[] = {
>         1000, 1300, 1800, 2500,
>         2800, 2900, 3000, 3000,
> };

> if the request is to set 2800mv, look up the table,
> once found calulate the value to be programmed
> value = (2800 - 1000)/100 + 1 = 0x13

Are these really the only supported values (obviously you can set other
selectors)?  Note also that the name says "_VSEL_table" which is
definitely no longer true, this isn't helping clarity at all.
