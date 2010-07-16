From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Fri, 16 Jul 2010 12:18:23 +0300 (EEST)
Message-ID: <20100716.121823.226797826.Hiroshi.DOYU@nokia.com>
References: <20100715.120807.39160135.Hiroshi.DOYU@nokia.com>
	<20100716075243.GB16124@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C6127BF3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62895 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936134Ab0GPJTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jul 2010 05:19:10 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6127BF3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, pavel@ucw.cz, khilman@deeprootsystems.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, Yoshiya.Hirase@nokia.com, linux-omap@vger.kernel.org

From: "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Fri, 16 Jul 2010 10:48:00 +0200

> Hiroshi,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
>> Sent: Friday, July 16, 2010 1:23 PM
>> To: Hiroshi DOYU
>> Cc: linux-arm-kernel@lists.infradead.org; pavel@ucw.cz;
>> khilman@deeprootsystems.com; Reddy, Teerth; linux-pm@lists.linux-
>> foundation.org; Yoshiya.Hirase@nokia.com; linux-omap@vger.kernel.org
>> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
>> 
>> On Thu, Jul 15, 2010 at 12:08:07PM +0300, Hiroshi DOYU wrote:
>> > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
>> > Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
>> > Date: Thu, 15 Jul 2010 10:41:18 +0200
>> >
>> > > On Thu, Jul 15, 2010 at 08:34:50AM +0300, Hiroshi DOYU wrote:
>> > >> Russell, would it be possible to put this into your next merge queue?
>> > >
>> > > I think it needs quite a bit of rework - I certainly don't like all
>> > > those CP15 register accesses there - that's asking for lots of ifdefs
>> > > to spring up as more CPUs are supported.
>> > >
>> > > Eg, what about ensuring that state such as iWMMXt on PXA CPUs is
>> > > properly restored?
>> >
>> > Right. This arch specific part can be something like
>> > "suspend-v[3-7].S" to accomodate those differences
>> 
>> It's not quite that simple - things like iWMMXt aren't part of the ARM
>> arch specs.
>> 
>> > > We already have code which knows what needs to be saved across a
>> > > power-off transition - its what we use for our normal suspend/resume
>> > > functionality, so we should look at re-using that code for hibernate
>> > > as well.  We really don't want to be maintaining two sets of code
>> > > doing the same thing.
>> >
>> > Could you explain which code you're refering for the existing one?
>> 
>> The code which handles saving state for the existing suspend/resume
>> support.  This code already saves the necessary state from CP15 and
>> any other state which needs to be saved prior to putting the system
>> into low power mode.
>> 
>> Every machine class which supports suspend today has their own chunk
>> of code which does this, normally called something like sleep.S
>> 
> When this getting developed in TI, we had one more concern about handling
> the trustzone part for the CP15 resgiters.
> This patch will hang on restoration on some devices implementing trustzone.

Thanks for the info.

I think that this trustzone issue and PXA part can be revisited later
once the basic stuff is accepted.
