From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: McBSP register question
Date: Mon, 15 Dec 2008 08:08:22 +0530
Message-ID: <057c01c95e5e$33f76d80$LocalHost@wipultra806>
References: <423644ca0812121021k63a81930nb805b8ab7b5a6d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36453 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbYLOCie (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Dec 2008 21:38:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Marini <jason.marini@gmail.com>, linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Jason Marini" <jason.marini@gmail.com>
To: <linux-omap@vger.kernel.org>
Sent: Friday, December 12, 2008 11:51 PM
Subject: McBSP register question


> Looking at the latest git head, I see that omap_mcbsp_pollwrite() and
> omap_mcbsp_pollread() improperly use readw() and writew() instead of
> OMAP_MCBSP_READ() and OMAP_MCBSP_WRITE() in the file
> arch/arm/plat-omap/mcbsp.c.
>
> But while I was editing this file, I also saw writes to
> OMAP_MCBSP_REG_DXR1, which is #define'd for ARCH_OMAP_34XX and
> ARCH_OMAP_24XX to be at an offset of 0x0C.  The McBSP section of the
> TRM for the OMAP34xx has no mention of any registers existing at this
> offset.
>
> Why is this DXR1 and not just DXR?

It so happens that McBSP on 2420 has DXR1 and DXR2 registers, but not on 
omap2430/34xx.
To provide multi-omap suport and avoid ifdefs dxr1/2 and drr1/2 has been 
retained along with dxr and drr  (same code mach-omap2/mcbsp.c supports 2420.) .



>
> -Jason Marini
> Associate Software Engineer
> Vocollect, Inc.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

