From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] Common mechanism to identify Si revision
Date: Mon, 7 Sep 2009 11:33:32 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C3EBD@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
 <20090906124639.GA22239@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51000 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758900AbZIGGDn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 02:03:43 -0400
In-Reply-To: <20090906124639.GA22239@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Olof Johansson [mailto:olof@lixom.net] 
> Sent: Sunday, September 06, 2009 6:17 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC] Common mechanism to identify Si revision
> 
> On Thu, Sep 03, 2009 at 04:14:28PM +0530, Premi, Sanjeev wrote:
> > Hi,
> > 
> > Currently there are multiple mechanisms for identifying the 
> si revisions.
> > 
> > Most places the comparison is against omap_rev() as a whole 
> number. Example:
> > 
> > arch/arm/mach-omap2/board-3430sdp.c:695:    if (omap_rev() 
> > OMAP3430_REV_ES1_0)
> > arch/arm/mach-omap2/board-3430sdp.c:728:    if (omap_rev() 
> > OMAP3430_REV_ES1_0)
> > 
> > Then, there are custom macros. Example (cpu.h):
> > 
> > #define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
> > #define CHIP_GE_OMAP3430ES3		(CHIP_IS_OMAP3430ES3_0 | \
> > 					 CHIP_GE_OMAP3430ES3_1)
> > #define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
> > 					 CHIP_GE_OMAP3430ES3)
> > 
> > The problem with comparing against a whole number is that 
> comparison is invalid
> > for another processor series. E.g. OMAP3430 and OMAP3517.
> > 
> > Here, I am proposing a common mechanism to identify the si 
> revision; that focuses
> > on the revision bits alone. (See code below)
> > 
> > The usage would then be (example):
> > 
> >    if (omap_rev() > OMAP3430_REV_ES1_0)
> > 
> > To
> > 
> >    if (cpu_is_omap34xx() && OMAP_REV_GT(OMAP_ES_1_0)
> 
> What's the purpose of most of these checks in the first place? I can
> see two immediate needs:
> 
> 1) To check for various errata and do appropriate workarounds

[sp] I believe the only need would be to make easy check if the version
     has multiple errata fixes and/or enhancements. And, of course, a
     verbose information to user who may not have (and may not need)
     information of all the errata/enhancements.

     Today, there are multiple ways of doing the same thing... Each way
     builds upon minor issues in the existing one; but adds its own.

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

[sp I have submitted a patch that takes the first step toward this:
    http://marc.info/?l=linux-omap&m=125050987112798&w=2
    ...still waiting to hear from Tony on this.

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
> For example, a bunch of the checks in pm34xx.c would be nicer 
> to have as:
> 
> 	if (OMAP_HAS_USBHOST()) 

[sp] Can you look and comment on this discussion as well:
     http://marc.info/?l=linux-omap&m=125017671720718&w=2

Best regards,
Sanjeev
> 
> Then the current settings.
> -Olof
> 
> 