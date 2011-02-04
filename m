From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: general kernel building questions
Date: Fri, 4 Feb 2011 23:02:41 +0530
Message-ID: <1b12378ed3e82975828fa4dd05f713e2@mail.gmail.com>
References: <F752F64AD8BC1D42B49B877FEE3CD3490139166B@USTED.BOPTUS.OPTIK.LAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57985 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751717Ab1BDRcn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 12:32:43 -0500
Received: by iyj21 with SMTP id 21so2631715iyj.2
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 09:32:42 -0800 (PST)
In-Reply-To: <F752F64AD8BC1D42B49B877FEE3CD3490139166B@USTED.BOPTUS.OPTIK.LAN>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jeg@brukeroptics.com, linux-omap@vger.kernel.org

Jeff Graham wrote:
>
> Hello,
>
> I have an Overo Fire board (OMAP 3530) and also a Mistral DM3730 EVM
> board.
>
> I would like to try some of the newer kernels on each, and maybe some
> patches mentioned in this list. I could be a tester for these once I
> figure out how to update bootloaders and build and install kernels. Is
> there a how-to guide somewhere?
>

Nothing comes to mind right now.

There is some useful reading material on elinux.org and omappedia.org.
I'll see if I can locate a good guide - if no one else points one out,
I'll try and put something together.

> So some newb questions if I may:
>
> 1. Where do I grab the latest kernels that have some chance at
> stability?
>

The mainline kernel will at least boot up on most OMAP boards.
The master branch of linux-omap closely tracks the mainline kernel
and is a little more likely to work.

> 2. Where are the def config files?
>

There are now only 2 defconfig files for the OMAPs.
omap1_defconfig for all OMAP1 platforms
and
omap2plus_defconfig for all OMAP2,3,4 platforms

They enable support for multiple boards, and contain
drivers that may not always be useful. So they are bigger
than absolutely necessary.

> 3. I know how to apply kernel patches, but where are the
> patches and how to I git specific ones?

Which patches are you interested in?

Anything that is queued up in a maintainer's tree can
be cherry picked by you.

Patches submitted to this list are also available
on patchwork.
https://patchwork.kernel.org/project/linux-omap/list/



> 4. Will 2.6.37, 2.6.38 mainline (currently rc3), linux-next and/or
> snapshot from kernel.org work?
>

I'm not very sure about the status of individual boards in the .37
kernel, but I expect that most of them will at least boot.
A recent snapshot from kernel.org should also be about the same.

2.6.38-rc3 will have more new features than the .37 kernel, and
I believe it is reasoably stable. Again, I expect it to at least
boot on most OMAP platforms. If it doesn't work for you,
please report it to this list and work with us to fix it.

Some features may not be present in the .38-rc releases.
Patches posted here and to other mailing lists which are not
bug-fixes will get queued up only for the merge window after
2.6.38 is released.

linux-next is the bleeding-edge kernel - it will start looking
like a preview of the next -rc1 kernel, but it could easily be broken
as there are frequent changes. These start stabilizing around -rc6
or so of the current kernel. Testing linux-next would certainly
be useful in ensuring the next merge window goes smoothly.

> 5. How quickly do the patches mentioned in this list land there?
>

That depends, mostly on the quality of the patches, and how
non-controversial they are. Fixes usually make it through
quickly, as long as the code quality is good.

Non-fixes can take a few weeks, depending on how good the
initial patch is, how responsive the submitter is to
comments, and how many people find the patch useful.

Non-fixes can also take months, if the right conditions
are not met. :(


- Anand
