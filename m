From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Runtime detection of Si features
Date: Mon, 17 Aug 2009 16:51:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D8E1D76C@dbde02.ent.ti.com>
References: <1250176701-23998-1-git-send-email-premi@ti.com>
	<877hx7g09i.fsf@deeprootsystems.com> <4A843FDE.5090209@ti.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F5A38B8C@dbde02.ent.ti.com>
 <873a7vfz05.fsf@deeprootsystems.com> <4A84429D.4050600@ti.com>
 <4A84544A.7030808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48869 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757608AbZHQLWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 07:22:02 -0400
In-Reply-To: <4A84544A.7030808@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, August 13, 2009 11:29 PM
> To: Kevin Hilman
> Cc: Pandita, Vikram; Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Runtime detection of Si features
> 
> Nishanth Menon had written, on 08/13/2009 11:43 AM, the following:
> > Kevin Hilman had written, on 08/13/2009 11:40 AM, the following:
> >> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
> >>
> >>>> -----Original Message-----
> >>>> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> >>>> Sent: Thursday, August 13, 2009 11:31 AM
> >>>>>> Since most of the code seemed repetitive, macros
> >>>>>> have been used for readability.
> >>>>>>
> >>>>>> Signed-off-by: Sanjeev Premi <premi@ti.com>
> >>>>> I like the feature-based approach.
> >>>>>
> >>>>> A couple questions though.  Is there a bit/register 
> that reports the
> >>>>> collapsed powerdomains of the devices with modified PRCM?
> >>>>>
> >>>>> Also, how will other code query the features?  You're currently
> >>>>> exporting the omap_has_*() functions, but there are no 
> prototypes.
> >>>>>
> >>>>> I think I'd rather see a static inline functions in <mach/cpu.h>
> >>>>> for checking features.  Comments to that end inlined below...
> >>>> Wonder if we can setup some sort of infrastructure for:
> >>>> a) features
> >>>> b) erratas
> >>>> linked to OMAP revs + even better w.r.t silicon module(SGX,I2c)
> >>>> revisions since at times they are used across multiple OMAPs?
> >>> We are hitting exactly this issue with I2C errata 1.153
> >>> Instead of basing the errata check on cpu_is...(), 
> >>> its more appropriate to base it on IP revision of I2C.
> >> Shouldn't the IP revision of I2C be avaialble in an I2C revision
> >> register an be used in the driver instead of cpu_is*?
> > what I was proposing is a much more generic infrastructure 
> which i2c 
> > among other modules can use. Getting IP revision is already 
> available in 
> > the specific IP modules REVISION registers - we might want to 
> > standardize how drivers handle revision based feature/errata set to 
> > ensure that they would have an optimal way to handle the 
> same.. just my 
> > 2 cents..
> > 
> Thinking of this a little more:
> driver's smart handling aside, having a sysfs entry to dump 
> the features 
> and erratas for each of the modules used is so much nice to have.. 
> sigh.. just wondering if anyone has ideas how feasible this might be..
> 

[sp] If all IPs are able to populate a "revision" field in the
     device structure during init/probe then there could be generic
     APIs get_ip_revision() and is_ip_revision();

     Since erratas are linked to the ip versions, this could just be
     a 'print' problem - whether to a sysfs/ a proc entry.

> -- 
> Regards,
> Nishanth Menon
> 