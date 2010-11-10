From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 00/13] OMAP: DMA: hwmod and DMA as platform device
Date: Wed, 10 Nov 2010 19:32:23 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC3@dbde02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
 <87tyjqhz2k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0KJOCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 09:02:34 -0500
In-Reply-To: <87tyjqhz2k.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 4:42 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 00/13] OMAP: DMA: hwmod and DMA as 
> platform device
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > This patch series converts DMA library into platform device 
> and hwmod 
> > adaptation is done for omap2+ processors.
> >
> > It also replaces cpu_*is* checks by moving omap1 and omap2+ 
> processor 
> > code into repsective mach-omapx directories. The common 
> code in plat-omap
> > will use device attributes for differentiating omap1 and omap2 code.
> 
> This summary, and the various changelogs need to be updated to be more
> descriptive, particularily in the usage of the words 'device' and
> 'driver'.
> 
> The changelog terminology used is confusing, and sometimes 
> wrong.  What
> is actually being done is splitting up the current DMA library into 3
> parts: a common platform_driver (plat-omap/dma.c), OMAP1 device code
> (mach-omap1/dma.c) and OMAP2+ device code (mach-omap2/dma.c)

I will incorporate this with next version.

> 
> > Build Report:
> > omap1:  Success for omap_h2_1610_defconfig
> > omap2+: Success for omap2plus_defconfig
> >
> > Test Report:
> > omap2+:(multiboot defconfig boots on all the omap2+ boards 
> listed below):
> > OMAP4BLAZE: http://pastebin.com/HVnim30G
> > OMAP3630ZOOM3: http://pastebin.com/JJwrtP4F
> > OMAP243SDP: http://pastebin.com/mz7cVQL3
> >
> > omap1 : Not tested 
> >
> > Test cases executed:
> > 1. All applicable TI DMA tests which are located at:
> > 
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=tree
;f=dma/test_code;h=0d00de3c0fe6933b405c62da63f694883f3e4b8f;hb=> 2c50a5a58dea0ffc2d31b827935aeef9b9d11253
> >
> > 2. Use case tests :  TI MMC tests are executed with 
> differenct types of
> > files systems such as DOS, ext2, ext3 etc on omap4 blaze 
> and omap3630 zoom3. 
> > More information can be found at:
> > 
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=tree
;f=mmc/test_code;h=d0bc1984eef46ac45719efb02b5c1f4193422a1b;hb=> 2c50a5a58dea0ffc2d31b827935aeef9b9d11253
> >
> > Dependencies:
> > This patch series has dependency on omap_device patch:
> > https://patchwork.kernel.org/patch/282212/
> 
> Thanks for the thorough build and test report.   Very nice.

Thanks for the feedback.

-Manjunath
