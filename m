From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] [OMAPZOOM]DSPBRIDGE bug in Bridge exit cleanup
Date: Tue, 24 Mar 2009 06:58:24 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2349A329@dlee03.ent.ti.com>
References: <Acmr6BM18BJBh1pxS8i5e+utnLzXGw==>
	 <8F7AF80515AF0D4D93307E594F3CB40E2342BE9F@dlee03.ent.ti.com>
 <269694c00903240304y69f43451lb260951167fe64af@mail.gmail.com>
 <8F7AF80515AF0D4D93307E594F3CB40E2349A31B@dlee03.ent.ti.com>
 <49C8CA41.6050002@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60976 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625AbZCXL6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 07:58:37 -0400
In-Reply-To: <49C8CA41.6050002@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: Ameya Palande <2ameya@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ameya,

> Is there any need to pass "HANDLE hPCtxt" to DRV_RemoveProcContext()
> function?
>

-- It should work even if you don't pass the hPCtxt. This function requires some rework to avoid this confusion. Thanks for bringing up this question.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Tuesday, March 24, 2009 6:56 AM
> To: Kanigeri, Hari
> Cc: Ameya Palande; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] [OMAPZOOM]DSPBRIDGE bug in Bridge exit cleanup
> 
> Hi Hari,
> 
> ext Kanigeri, Hari wrote:
> > Hi Amey,
> >
> >> I am trying to understand this patch.
> >> I see that pCtxtclosed is passed to DRV_RemoveProcContext() function
> >> but it is not used anywhere inside it. I was expecting to see a
> >> statement there which should free its memory.
> >
> > This pointer is getting freed indirectly through the pCtxt2 pointer. The
> call to the function "DRV_GetProcContext((u32)hProcess, hDRVObject,
> &pCtxt2, NULL, 0)" returns pCtxt2, which is same as pCtxtclosed that is
> passed to this function.
> > In a way, the call to DRV_GetProcContext is kind of redundant, but I
> think it is present here to provide the support to extract the Process
> Context when only the PID is passed in.
> 
> Thanks for the explanation :)
> Is there any need to pass "HANDLE hPCtxt" to DRV_RemoveProcContext()
> function?
> 
> Cheers,
> Ameya.

