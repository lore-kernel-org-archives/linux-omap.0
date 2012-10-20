From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 20:01:24 +0200
Message-ID: <20121020180123.GA2630@netboy.at.omicron.at>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51534 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab2JTSBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 14:01:34 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so765099wey.19
        for <linux-omap@vger.kernel.org>; Sat, 20 Oct 2012 11:01:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Oct 20, 2012 at 04:27:19PM +0000, Paul Walmsley wrote:
> > BeagleBone Rev. A6 does not boot v3.7-rc1, at least not for me.
> > I recently posted the missing patches needed to make it work (but the
> > patches are not by me).
> 
> Those are the patches at:
> 
> http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html
> 
> ?

Yes, that is right. Only the first patch is absoutely required for booting.

> Thanks for the report.  Are you using the stock v3.7-rc1 DTS file in 
> arch/arm/boot/dts/am335x-bone.dts ?

Yes.

> Also are you using omap2plus_defconfig?

Yes, but I de-selected a few items. I will try it again without
changing anything.

> Here's the console log from the boot test here:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/boot/am335xbone/am335xbone_log.txt
> 
> And here's the kernel config and uImage+DTB from the boot test here:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/build/am33xx_only/

Okay, so there are a number of differences between your am33xx_only
and the omap2plus_defconfig. I will try it with your config as well.
 
> In terms of differences from your setup, looks like we have different 
> X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> configs too.

What is X-Loader?

Thanks,
Richard
