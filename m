From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: No more software ECC in omap2.c NAND driver. Why?
Date: Thu, 18 Nov 2010 20:03:24 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036977BBA2@dbde02.ent.ti.com>
References: <201011181406.15212.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50604 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757894Ab0KROdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 09:33:33 -0500
In-Reply-To: <201011181406.15212.manningc2@actrix.gen.nz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Charles Manning
> Sent: Thursday, November 18, 2010 6:36 AM
> To: linux-omap@vger.kernel.org
> Subject: No more software ECC in omap2.c NAND driver. Why?
> 
> Between 2.6.35 and 2.6.36 there have need quite a few changes in the NAND
> driver, including a change from software to hardware ECC.
> 
> The new code has hardware ECC forced on by:
> 
> #define CONFIG_MTD_NAND_OMAP_HWECC
> 
> I am surprised that this was done. Surely this should have been a Kconfig
> option to select either sw ECC or hw ECC?
> 
> Does moving to hardware ECC to the exclusion of software ECC reduce
> functionality?

[Ghorai] This is wrongly added by me, during last few patches. So I have
send the fix as you mentioned too as.
[PATCH] omap: nand: remove hardware ECC as default

And please let me know still if it has any issue. 

And I am re-working on the patches for the different ecc schema including
s/w, h/w or different, to pass it form board file.

> 
> Does the new hwecc scheme still support sub-page writes or does it only
> provide full page writes? If sub-page writes are lost then this has  a
> ripple
> effect in breaking the way some UBI stuff works.

[Ghorai] 
1. do you think this sub-page read/write support was there before, say in
2.6.35? And breaks in 2.6.36?
  
2. In that case would you please let know what are the size(s) used for 
sub-page/read write?

> 
> -- Charles
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
