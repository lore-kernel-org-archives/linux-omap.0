From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] [OMAPZOOM]DSPBRIDGE bug in Bridge exit cleanup
Date: Tue, 24 Mar 2009 13:55:45 +0200
Message-ID: <49C8CA41.6050002@nokia.com>
References: <Acmr6BM18BJBh1pxS8i5e+utnLzXGw==>	 <8F7AF80515AF0D4D93307E594F3CB40E2342BE9F@dlee03.ent.ti.com> <269694c00903240304y69f43451lb260951167fe64af@mail.gmail.com> <8F7AF80515AF0D4D93307E594F3CB40E2349A31B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37365 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268AbZCXL4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 07:56:11 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2349A31B@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Ameya Palande <2ameya@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

ext Kanigeri, Hari wrote:
> Hi Amey,
> 
>> I am trying to understand this patch.
>> I see that pCtxtclosed is passed to DRV_RemoveProcContext() function
>> but it is not used anywhere inside it. I was expecting to see a
>> statement there which should free its memory.
> 
> This pointer is getting freed indirectly through the pCtxt2 pointer. The call to the function "DRV_GetProcContext((u32)hProcess, hDRVObject, &pCtxt2, NULL, 0)" returns pCtxt2, which is same as pCtxtclosed that is passed to this function.
> In a way, the call to DRV_GetProcContext is kind of redundant, but I think it is present here to provide the support to extract the Process Context when only the PID is passed in.

Thanks for the explanation :)
Is there any need to pass "HANDLE hPCtxt" to DRV_RemoveProcContext() function?

Cheers,
Ameya.
