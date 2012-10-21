From: Matt Porter <mporter@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sun, 21 Oct 2012 09:51:43 -0400
Message-ID: <20121021135143.GA1855@beef>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
 <20121020180123.GA2630@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
 <20121020183724.GA9984@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201856020.27264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51174 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab2JUNvp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 09:51:45 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2543810iea.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Oct 2012 06:51:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210201856020.27264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Richard Cochran <richardcochran@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Oct 20, 2012 at 06:58:10PM +0000, Paul Walmsley wrote:
> On Sat, 20 Oct 2012, Richard Cochran wrote:
> 
> > On Sat, Oct 20, 2012 at 06:12:35PM +0000, Paul Walmsley wrote:
> > > Just tried omap2plus_defconfig here and the board didn't boot, confirming 
> > > your result.  Will add a section to the testlog README.txt about that.
> > > 
> > > > > In terms of differences from your setup, looks like we have different 
> > > > > X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> > > > > configs too.
> > 
> > I tried both omap2plus_defconfig and your am33xx_only config, and
> > neither one work with my (recent) u-boot version.
> 
> Just sent you the MLO and u-boot.img from here via private E-mail.  Those 
> were the files that came with the BeagleBone SD card here.
> 
> TI also has a u-boot tree for the AM33xx; might be worth trying:
> 
> git://arago-project.org/git/projects/u-boot-am33x.git

Use of the vendor tree should be discouraged. The best thing to use
is current ToT U-Boot mainline or the v2012.10 stable U-Boot release.
X-Loader is deprecated by U-Boot SPL.

-Matt
