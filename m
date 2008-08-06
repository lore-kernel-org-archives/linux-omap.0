From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Added support for OMAP35x processor series
Date: Wed, 6 Aug 2008 17:26:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013CA23868@dbde02.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E0AFDBE42@dlee03.ent.ti.com>
 <20080806090708.GH19813@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593013CA23771@dbde02.ent.ti.com>
 <20080806101045.GL19813@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:43943 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825AbYHFMDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 08:03:09 -0400
In-Reply-To: <20080806101045.GL19813@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Kridner, Jason" <jdk@ti.com>, "'k.kooi@student.utwente.nl'" <k.kooi@student.utwente.nl>, "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

For 35x processors we need to make compile time decisions to exlude the code that may not be applicable for the specifc processor e.g. excluding the code applicable for DSP/ SGX or both depending upon the exact part number.

~sanjeev

-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com]
Sent: Wednesday, August 06, 2008 3:41 PM
To: Premi, Sanjeev
Cc: Kridner, Jason; 'k.kooi@student.utwente.nl'; 'linux-omap@vger.kernel.org'
Subject: Re: [PATCH] Added support for OMAP35x processor series

* Premi, Sanjeev <premi@ti.com> [080806 12:55]:
> >> Well if there's no way to detect certain omaps during runtime,
> >> please patch arch/arm/plat-omap/common.c to have something like struct omap_globals omap3503_globals.
>
> There was no need to re-define these structures for the current series of the OMAP35x processors.
> Hence, it was left as it.

What exactly do you need to define then for various 35xx processors that's different from 34xx?

> >> BTW, why can't the dsp code detect if the DSP is there or not?
>
> (Assuming you mean the code running on ARM that looks for the
> DSP/SGX/...) The detection was based on the chip ID. This happens to be same for OMAP34XX and OMAP35X.

How about trying to read the DSP revision register or something similar?

Tony

>
> ~sanjeev
>
>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, August 06, 2008 2:37 PM
> To: Kridner, Jason
> Cc: 'k.kooi@student.utwente.nl'; 'linux-omap@vger.kernel.org'
> Subject: Re: [PATCH] Added support for OMAP35x processor series
>
> * Kridner, Jason <jdk@ti.com> [080805 17:12]:
> > No, ROM CRC is useful for detecting between some device revisions, but not OMAp3430 vs OMAP3530.
> >
> > ----- Original Message -----
> > From: Koen Kooi <k.kooi@student.utwente.nl>
> > To: linux-omap@vger.kernel.org <linux-omap@vger.kernel.org>
> > Cc: Kridner, Jason
> > Sent: Tue Aug 05 05:10:40 2008
> > Subject: Re: [PATCH] Added support for OMAP35x processor series
> >
> >
> > Op 5 aug 2008, om 11:50 heeft Igor Stoppa het volgende geschreven:
> >
> > > On Tue, 2008-08-05 at 15:09 +0530, ext Premi, Sanjeev wrote:
> > >> This patch is needed to ensure that we can make decisions based
> > >> on the processor capabilities.
> > >> E.g. OMAP3503 does not contain a DSP. We shouldn't be trying to
> > >> disable/ manage the clocks for DSP on this processor. Same for SGX.
> > >
> > > Why can't the detection happen at runtime?
> >
> > AIUI the ID bits are the same (linux misdetect the 3530 on my beagle
> > for a 3430). I heard that the only definitive way to do it at
> > runtime is to CRC check the ROM code.
> >
> > Jason, is that correct?
>
> Well if there's no way to detect certain omaps during runtime, please patch arch/arm/plat-omap/common.c to have something like struct omap_globals omap3503_globals.
>
> BTW, why can't the dsp code detect if the DSP is there or not?
>
> Tony
>
>
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
