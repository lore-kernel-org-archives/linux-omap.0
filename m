From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Wed, 15 Dec 2010 17:13:42 +1300
Message-ID: <201012151713.43028.manningc2@actrix.gen.nz>
References: <LD5JNC$C40D8861A973796B25CD03BFFD0B4CA1@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:40258 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756078Ab0LOENr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 23:13:47 -0500
In-Reply-To: <LD5JNC$C40D8861A973796B25CD03BFFD0B4CA1@aruba.it>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-omap@vger.kernel.org, notasas@gmail.com

On Thursday 09 December 2010 21:30:48 Luca Ceresoli wrote:
> Charles Manning wrote:
> > Luca, I have been having similar problems on a hacked Overo kernel.
> >
> > I have no problems with 2.6.35.
> >
> > I tried just commenting out the define and disabling PREFETCH and did not
> > get a good boot due to ubi not finding the volume info.
> >
> > Are you loading up a UBI image with uboot?
> >
> > Are you using the ubi volume as rootfs?
>
> To make it work again, I did from u-boot:
> - nand scrub (*completely* wipe the NAND)
> - ubi part nand0,3 (recreate partitions)
> - ubi create rootfs 400000
> - ...create other partitions...
> - ubi write ... (to rewrite rootfs)
> - finally, boot with the kernel having the define commented and PREFETCH
> off.
>
> Not all of these may be needed, but this way I got the board up and running
> again.
>
> Luca

What branch are you working from?

I tried working from a reasonably recent master on 
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

I found that reads via the  prefetch eengine work, but reads via 
        ioread16_rep(nand->IO_ADDR_R, buf, len / 2)
do not.

Perhaps this is due to the address not being set up properly. Any clues?

I found that I can make everything work by realigning all accesses in 
nand_base.c to be 4-byte aligned.


-- Charles




