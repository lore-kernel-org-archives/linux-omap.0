From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 16:27:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <20121020141136.GA6433@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53619 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab2JTQ1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 12:27:20 -0400
In-Reply-To: <20121020141136.GA6433@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Richard

On Sat, 20 Oct 2012, Richard Cochran wrote:

> On Thu, Oct 18, 2012 at 05:20:46AM +0000, Paul Walmsley wrote:
> > 
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/

...

> > Passing tests
> > -------------
> > 
> > Boot to userspace: 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
> >                    4430es2panda, 5912osk, am335xbone

...

> BeagleBone Rev. A6 does not boot v3.7-rc1, at least not for me.
> I recently posted the missing patches needed to make it work (but the
> patches are not by me).

Those are the patches at:

http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html

?

> Below I include the console log.

Thanks for the report.  Are you using the stock v3.7-rc1 DTS file in 
arch/arm/boot/dts/am335x-bone.dts ?  Also are you using 
omap2plus_defconfig?

...

Here's the console log from the boot test here:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/boot/am335xbone/am335xbone_log.txt

And here's the kernel config and uImage+DTB from the boot test here:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/build/am33xx_only/

In terms of differences from your setup, looks like we have different 
X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
configs too.


- Paul
