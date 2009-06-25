From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH 1/2] Support OMAP3 VC adaptation with different Power IC
Date: Fri, 26 Jun 2009 04:12:33 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5465B8E@zmy16exm69.ds.mot.com>
References: <4A43CF46.60706@android.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:5951 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbZFYUNC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 16:13:02 -0400
Received: from il27exr04.cig.mot.com (il27exr04.mot.com [10.17.196.73])
	by motgate2.mot.com (8.14.3/8.14.3) with ESMTP id n5PKD4oA020003
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 13:13:04 -0700 (MST)
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n5PKD35A014554
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 15:13:03 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n5PKCxTQ014499
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 15:13:03 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <4A43CF46.60706@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org

> >>> diff --git a/arch/arm/mach-omap2/smartreflex.c
> >>> b/arch/arm/mach-omap2/smartreflex.c
> >>> index 9d462e3..bacf602 100644
> >>> --- a/arch/arm/mach-omap2/smartreflex.c
> >>> +++ b/arch/arm/mach-omap2/smartreflex.c
> >>> @@ -52,6 +52,8 @@ struct omap_sr {
> >>>  
> >>>  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
> >>>  
> >>> +static omap3_voltagescale_vcbypass_t omap3_volscale_vcbypass_fun;
> >>>   
> >>>       
> >> Perhaps use
> >> static int (*omap3_volscale_vcbypass_fun) (u32, u32, u8, u8);
> >>
> >> This gets rid of the compiler warning on incompatible pointer 
> >> types when 
> >> you register a function via omap3_voltagescale_vcbypass_setup().
> >>
> >> -- Mike
> >>     
> > Thanks Mike, but we do not see the warnning with the original
> > Code, note this patch is slightly different with the one we sent
> > To you based on K29, this new patch have four parameters
> > Sinc some change has been made in the
> > sr_voltagescale_vcbypass to add two more parameters.
> >
> > Is your warnning caused by this?
> >
> >   
> 
> This patch stand-alone doesn't give me any warnings. Its only when you
> hook into this from your board file. Might be the compiler I'm using.
> I used this patch + modified version of the patches you sent me before
> to get the two working. (Yes, 4 params).
I just verified the change on both current linux-omap pm branch and
The branch we are using, neither of them reports any warnning.

Just reminder, the patch I sent to you are different in all these files,
Since we should use 2 params in our kernel, the patch I sent to
This list has 4 params. Please check whether the warnning
Is caused by the mismatch in the function declaration and
The function definition in the board file.

It should not cause the warning even you are using different
Compiler.

> 
> -- MIke
> > Thanks,
> > Chunqiu
> >   
> 
> 
