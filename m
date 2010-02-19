From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Fri, 19 Feb 2010 12:09:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03215B13F5@dbde02.ent.ti.com>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <20100217161509.GA13324@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
 <20100218094814.GD3315@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1172@dbde02.ent.ti.com>
 <20100218104032.GA3542@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B11D9@dbde02.ent.ti.com>
 <20100218114237.GE3542@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47893 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930Ab0BSGkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 01:40:11 -0500
In-Reply-To: <20100218114237.GE3542@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, "Kakela, Pekka" <p-kakela@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

 

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> Sent: Thursday, February 18, 2010 5:13 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Liam Girdwood; Samuel Ortiz
> Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel 
> calculations in set/get voltage apis
> 
> On Thu, Feb 18, 2010 at 05:09:53PM +0530, Nayak, Rajendra wrote:
> 
> > Mark, I get your point. The table values were derived from 
> what the spec
> > suggests, but I agree that its confusing that in theory the formula
> > suggests there could be more selectors than whats present 
> in the table.
> 
> > I will check if its indeed possible to support all possible 
> selectors
> > between say a min/max range. And then have maybe seperate 
> kind of tables
> > for twl6030 which only specify min/max range and then use 
> the formula to
> > generate the right selector.
> 
> Another option if you do need the supported voltage list would be to
> rename the table and have a separate function to do set on 
> twl6030 which
> makes the intended usage clear.

Mark, It turns out, all twl6030 regulators can be programmed from
1.0v to 3.3v with 100mV steps. The spec I was referring to was specfic
to the OMAP4 platform I am working on. Hence, it does not prevent
someone using the PMIC on a different platform to have different
voltage requirements.
So I was thinking of removing all the twl6030 tables and just use
the formula to get the selector and make sure they fall in the
allowed range (1.0v to 3.3v).
If that sounds good then I can post a patch for this.

> 