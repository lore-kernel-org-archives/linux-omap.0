From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 00/11] OMAP2/TWL: Fix Sparse warnings
Date: Mon, 20 Sep 2010 11:28:55 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402784DD053@dbde02.ent.ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
 <20100916193425.GM29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54212 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab0ITF7C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 01:59:02 -0400
In-Reply-To: <20100916193425.GM29610@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>

Tony, 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, September 17, 2010 1:04 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Menon, Nishanth
> Subject: Re: [PATCH 00/11] OMAP2/TWL: Fix Sparse warnings
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [100826 13:50]:
> > This patch series fixes sparse warnings for OMAP and TWL code.
> > For better readabilty the patches are categorised based on type of 
> > sparse warnigns.
> > 
> > The sparse warning logs are embedded with each patch 
> followed by fix.
> > 
> > Build and boot tested on omap3 with omap3_defconfig.
> > 
> > Manjunatha GK (11):
> >   OMAP: mach-omap2: Fix incorrect assignment warnings
> >   OMAP: mach-omap2: Fix static declaration warnings
> >   OMAP: mach-omap2: Fix static function warnings
> >   OMAP: mach-omap2: Fix miscellaneous sparse warnings
> >   OMAP: plat-omap: Fix static function warnings
> >   OMAP: McBSP: Fix static function warning
> >   OMAP: HSMMC: Fix unused variable warning
> >   OMAP: NAND: Fix static declaration warning
> >   TWL CORE: Fix sparse warning
> >   TWL IRQ: Fix fucntion declaration warnings
> >   TWL4030: Codec: Fix fucntion declaration error
> 
> Looks like these are almost ready to go. Please repost against
> v2.6.36-rc4 with linux-arm-kernel list Cc'd. Also check that 
> the related driver list is Cc'd.
> 
> Then, assuming no more comments, can you set up a git branch 
> somewhere for me to pull? For more info, see "Merging patches 
> using git" at:
> 
> http://www.elinux.org/OMAP_patch_merging_process#Patch_submiss
> ion_checklist

Ok. I will do that along with v2 version of this patch series.

-Manjunath