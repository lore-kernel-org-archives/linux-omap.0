From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: NAND ECC in linux-omap
Date: Tue, 24 Aug 2010 19:21:22 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E9299EA@dbde02.ent.ti.com>
References: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
 <AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56569 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151Ab0HXNv3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 09:51:29 -0400
In-Reply-To: <AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>



> -----Original Message-----
> From: Cliff Brake [mailto:cliff.brake@gmail.com]
> Sent: Wednesday, August 18, 2010 9:16 PM
> To: Ghorai, Sukumar
> Cc: Linux OMAP Users; Kamat, Nishant
> Subject: Re: NAND ECC in linux-omap
> 
> On Wed, Aug 18, 2010 at 12:14 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
> > [Ghorai]
> > 1. Can you send the git tree link and branch you are referring?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> branch: pm
> 95e42b92313f229cbc9fc81bf68fe60aaee515aa
> 
> I'm pretty sure this branch tracks linux-omap.  I have not tested
> linux-omap yet
> (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
> 2.6.git:master)
> 
> > 2. I am working to support the NAND BCH and not upstream yet, how you
> apply this patch in PM branch.
> 
> What do you mean by upstream?  I'm not sure what NAND changes are in
> the above pm branch -- that is what I'm trying to figure out :-)
> Perhaps you can suggest if I'm using BCH, etc.
> 
> > 3. which x-loader and u-boot you are referring? And no x-loader/ u-boot
> supports the BCH
> 
> I'm using the x-loader/u-boot from for the Gumstix Overo.  My
> understanding is that it uses software -- likely not BCH, but I'm not
> sure.

[Ghorai] understand the problem, it's a nand ECC layout (location where ECC stors) problem, 
I think you flush the JFFS2 flash filesystem from u-boot and kernel not able to mount it. 
So let boot the image form say from MMC/SD or NFS (1st time); and use the utility after boot (flash_eraseall, nandwrite, ..) to write the JFFS2 image in NAND. And you can check JFFS2 mount or any further test.

If this does not help, send me the nanddump of the any page you write the data from u-boot.

> 
> Thanks,
> Cliff
> 
> --
> =================
> http://bec-systems.com
