From: "Jason Marini" <jason.marini@gmail.com>
Subject: Re: McBSP register question
Date: Mon, 15 Dec 2008 10:38:00 -0500
Message-ID: <423644ca0812150738j6f506cf7gf687eb50a7b6e33c@mail.gmail.com>
References: <423644ca0812121021k63a81930nb805b8ab7b5a6d84@mail.gmail.com>
	 <057c01c95e5e$33f76d80$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:55048 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYLOPiB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 10:38:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2545525rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 07:38:00 -0800 (PST)
In-Reply-To: <057c01c95e5e$33f76d80$LocalHost@wipultra806>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Sun, Dec 14, 2008 at 9:38 PM, shekhar, chandra <x0044955@ti.com> wrote:
> ----- Original Message ----- From: "Jason Marini" <jason.marini@gmail.com>
> To: <linux-omap@vger.kernel.org>
> Sent: Friday, December 12, 2008 11:51 PM
> Subject: McBSP register question
>
>
>> Looking at the latest git head, I see that omap_mcbsp_pollwrite() and
>> omap_mcbsp_pollread() improperly use readw() and writew() instead of
>> OMAP_MCBSP_READ() and OMAP_MCBSP_WRITE() in the file
>> arch/arm/plat-omap/mcbsp.c.
>>
>> But while I was editing this file, I also saw writes to
>> OMAP_MCBSP_REG_DXR1, which is #define'd for ARCH_OMAP_34XX and
>> ARCH_OMAP_24XX to be at an offset of 0x0C.  The McBSP section of the
>> TRM for the OMAP34xx has no mention of any registers existing at this
>> offset.
>>
>> Why is this DXR1 and not just DXR?
>
> It so happens that McBSP on 2420 has DXR1 and DXR2 registers, but not on
> omap2430/34xx.
> To provide multi-omap suport and avoid ifdefs dxr1/2 and drr1/2 has been
> retained along with dxr and drr  (same code mach-omap2/mcbsp.c supports
> 2420.) .

I suspected as much - thank you for the response.

-Jason
