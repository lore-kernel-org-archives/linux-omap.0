From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] Common mechanism to identify Si revision
Date: Thu, 10 Sep 2009 10:54:46 -0700
Message-ID: <87bpliadnd.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
	<20090906124639.GA22239@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:36147 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZIJRyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 13:54:46 -0400
Received: by pzk30 with SMTP id 30so254843pzk.21
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 10:54:49 -0700 (PDT)
In-Reply-To: <20090906124639.GA22239@lixom.net> (Olof Johansson's message of "Sun\, 6 Sep 2009 07\:46\:39 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Olof Johansson <olof@lixom.net> writes:

> On Thu, Sep 03, 2009 at 04:14:28PM +0530, Premi, Sanjeev wrote:
>> Hi,
>> 
>> Currently there are multiple mechanisms for identifying the si revisions.
>> 
>> Most places the comparison is against omap_rev() as a whole number. Example:
>> 
>> arch/arm/mach-omap2/board-3430sdp.c:695:    if (omap_rev() > OMAP3430_REV_ES1_0)
>> arch/arm/mach-omap2/board-3430sdp.c:728:    if (omap_rev() > OMAP3430_REV_ES1_0)
>> 
>> Then, there are custom macros. Example (cpu.h):
>> 
>> #define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
>> #define CHIP_GE_OMAP3430ES3		(CHIP_IS_OMAP3430ES3_0 | \
>> 					 CHIP_GE_OMAP3430ES3_1)
>> #define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
>> 					 CHIP_GE_OMAP3430ES3)
>> 
>> The problem with comparing against a whole number is that comparison is invalid
>> for another processor series. E.g. OMAP3430 and OMAP3517.
>> 
>> Here, I am proposing a common mechanism to identify the si revision; that focuses
>> on the revision bits alone. (See code below)
>> 
>> The usage would then be (example):
>> 
>>    if (omap_rev() > OMAP3430_REV_ES1_0)
>> 
>> To
>> 
>>    if (cpu_is_omap34xx() && OMAP_REV_GT(OMAP_ES_1_0)
>
> What's the purpose of most of these checks in the first place? I can
> see two immediate needs:
>
> 1) To check for various errata and do appropriate workarounds
>
> 2) To check if the current chip has a certain feature
>
> Both of these could just as well be abstracted away such that you use
> tests on the form:
>
> 	if (OMAP_HAS_ERRATA_FOO) ...
>
> or:
> 	if (OMAP_FEATURE_FOO) ...
>
> And then move the actual checking of a feature into the header file
> where the errata/feature setups are defined.
>
>
> There's two major benefits to this:
>
> 1) Readability. No need to sit and look up in a manual why there's a
> check for version X here.
>  (and/or no need to add a specific comment about it).
>
> 2) Keeping changes centralized. If there's a new revision or chip,
> there's just one header file to update, not 20 different source files.
>
> For example, a bunch of the checks in pm34xx.c would be nicer to have as:
>
> 	if (OMAP_HAS_USBHOST()) 
>

I tend to agree with Olaf here and am in favor of the new 'features'
patch that Sanjeev has already proposed.

That doesn't mean that I'm opposed to this change in principle, but
would rather see most of the omap_rev() and cpu_is_* checks disappear
in favor of more generic omap_has_feature() checks.

Kevin
