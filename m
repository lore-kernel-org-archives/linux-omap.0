From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: move platform_device_register under
 mach-omap2
Date: Fri, 27 Mar 2009 08:42:18 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2357E193@dlee03.ent.ti.com>
References: <1237981895-9269-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com>
 <20090325.151129.02294438.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49933 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbZC0Nmb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 09:42:31 -0400
In-Reply-To: <20090325.151129.02294438.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "2ameya@gmail.com" <2ameya@gmail.com>

Hi Doyu-San,

> > I am still going through the patch, but one quick question regarding
> > this. One of the requirements of DSP memory pool is that it should
> > be physically contiguous and non-cacheable. I hope the below patch
> > is taking care of this requirement.
> 
> This patch reserves a *contigious* physical memory area and passes
> this physical address to the bridge driver through
> ldm(platform_data). Then this area is ioremap()'ed in
> "MEM_ExtPhysPoolInit()". So it should be non-cachable and contigious.

-- We validated your patch with TI's internal test suite and it looks good.

The only comment I have is with this patch now we would require 2 modules to insert for DSP Bridge to work. I think it would be nice if we compile these 2 modules into 1 module so that we have only DSPBridge module. 

Thank you,
Best regards,
Hari
