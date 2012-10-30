From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 30 Oct 2012 11:23:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301120290.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com> <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com> <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com> <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com> <alpine.DEB.2.00.1210300416190.12697@utopia.booyaka.com>
 <CAORVsuWt22yRy9cHAU1u+9K7Fy4Zi95UN4wOh2DeVe61S-u5Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47853 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2J3LXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 07:23:08 -0400
In-Reply-To: <CAORVsuWt22yRy9cHAU1u+9K7Fy4Zi95UN4wOh2DeVe61S-u5Cg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: balbi@ti.com, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi Jean,

On Tue, 30 Oct 2012, Jean Pihet wrote:

> On Tue, Oct 30, 2012 at 5:16 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 23 Oct 2012, Jean Pihet wrote:
> >
> >> Let me try with the same setup as yours (bootloader images,
> >> omap2pus_defconfig, angstrom roots).
> >
> > Had any luck reproducing this one that Aaro & I are seeing?
> Unfortunately not. I could not reproduce the issue on my side, using
> an ES2.1 Beagleboard with the latest l-o kernel and your bootloader
> and rootfs images.
> Is there some specific to enable in order to reproduce the issue?

Could you please post a bootlog from your terminal program, similar to 

http://www.pwsan.com/omap/testlogs/test_v3.7-rc3/20121028162003/boot/3530es3beagle/3530es3beagle_log.txt

?


- Paul
