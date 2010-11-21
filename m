From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: No more software ECC in omap2.c NAND driver. Why?
Date: Mon, 22 Nov 2010 10:01:22 +1300
Message-ID: <201011221001.22909.manningc2@actrix.gen.nz>
References: <201011181406.15212.manningc2@actrix.gen.nz> <2A3DCF3DA181AD40BDE86A3150B27B6B036977BBA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:47015 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755586Ab0KUVB1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Nov 2010 16:01:27 -0500
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036977BBA2@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>

On Friday 19 November 2010 03:33:24 Ghorai, Sukumar wrote:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Charles Manning
> > Sent: Thursday, November 18, 2010 6:36 AM
> > To: linux-omap@vger.kernel.org
> > Subject: No more software ECC in omap2.c NAND driver. Why?
> >
> > Between 2.6.35 and 2.6.36 there have need quite a few changes in the NAND
> > driver, including a change from software to hardware ECC.
> >
> > The new code has hardware ECC forced on by:
> >
> > #define CONFIG_MTD_NAND_OMAP_HWECC
> >
> > I am surprised that this was done. Surely this should have been a Kconfig
> > option to select either sw ECC or hw ECC?
> >
> > Does moving to hardware ECC to the exclusion of software ECC reduce
> > functionality?
>
> [Ghorai] This is wrongly added by me, during last few patches. So I have
> send the fix as you mentioned too as.
> [PATCH] omap: nand: remove hardware ECC as default
>
> And please let me know still if it has any issue.

Just recompiling with the CONFIG_MTD_NAND_OMAP_HWECC define commented out did 
not result in a working system. I suspect there is more tto the problem than 
this.

>
> And I am re-working on the patches for the different ecc schema including
> s/w, h/w or different, to pass it form board file.
>
> > Does the new hwecc scheme still support sub-page writes or does it only
> > provide full page writes? If sub-page writes are lost then this has  a
> > ripple
> > effect in breaking the way some UBI stuff works.
>
> [Ghorai]
> 1. do you think this sub-page read/write support was there before, say in
> 2.6.35? And breaks in 2.6.36?

 2.6.35 works with subpages of 512 bytes. Tested with UBIFS.

>
> 2. In that case would you please let know what are the size(s) used for
> sub-page/read write?

AFAIK, 512 is all that is needed. There is no need for any smaller or larger.

sub-page reads are not available on all flash types and sub-page writing 
causes extra write disturb. However, 512-byte sub-page writing is valuable.

This of course needs the ECC to be partitioned and performed in chunks of 256 
or 512 so that the subpages can be written individually.

-- CHarles


