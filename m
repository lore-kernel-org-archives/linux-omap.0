From: "Luca Ceresoli" <luca@lucaceresoli.net>
Subject: Re: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Thu,  9 Dec 2010 09:30:48 +0100
Message-ID: <LD5JNC$C40D8861A973796B25CD03BFFD0B4CA1@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpa1.aruba.it ([62.149.128.210]:46170 "HELO smtpw2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751546Ab0LIIax convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 03:30:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: manningc2@actrix.gen.nz
Cc: linux-omap@vger.kernel.org, notasas@gmail.com

Charles Manning wrote:
> Luca, I have been having similar problems on a hacked Overo kernel.
> 
> I have no problems with 2.6.35.
> 
> I tried just commenting out the define and disabling PREFETCH and did not get 
> a good boot due to ubi not finding the volume info.
> 
> Are you loading up a UBI image with uboot?
> 
> Are you using the ubi volume as rootfs?

To make it work again, I did from u-boot:
- nand scrub (*completely* wipe the NAND)
- ubi part nand0,3 (recreate partitions)
- ubi create rootfs 400000
- ...create other partitions...
- ubi write ... (to rewrite rootfs)
- finally, boot with the kernel having the define commented and PREFETCH off.

Not all of these may be needed, but this way I got the board up and running again.

Luca


