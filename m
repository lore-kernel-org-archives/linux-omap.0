From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 18:58:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201856020.27264@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <20121020141136.GA6433@netboy.at.omicron.at> <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com> <20121020180123.GA2630@netboy.at.omicron.at> <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
 <20121020183724.GA9984@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53791 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab2JTS6L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 14:58:11 -0400
In-Reply-To: <20121020183724.GA9984@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 20 Oct 2012, Richard Cochran wrote:

> On Sat, Oct 20, 2012 at 06:12:35PM +0000, Paul Walmsley wrote:
> > Just tried omap2plus_defconfig here and the board didn't boot, confirming 
> > your result.  Will add a section to the testlog README.txt about that.
> > 
> > > > In terms of differences from your setup, looks like we have different 
> > > > X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> > > > configs too.
> 
> I tried both omap2plus_defconfig and your am33xx_only config, and
> neither one work with my (recent) u-boot version.

Just sent you the MLO and u-boot.img from here via private E-mail.  Those 
were the files that came with the BeagleBone SD card here.

TI also has a u-boot tree for the AM33xx; might be worth trying:

git://arago-project.org/git/projects/u-boot-am33x.git


- Paul
