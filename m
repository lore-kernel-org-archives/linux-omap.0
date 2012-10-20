From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 18:12:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <20121020141136.GA6433@netboy.at.omicron.at> <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com> <20121020180123.GA2630@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53741 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524Ab2JTSMg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 14:12:36 -0400
In-Reply-To: <20121020180123.GA2630@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 20 Oct 2012, Richard Cochran wrote:

> On Sat, Oct 20, 2012 at 04:27:19PM +0000, Paul Walmsley wrote:
> > > BeagleBone Rev. A6 does not boot v3.7-rc1, at least not for me.
> > > I recently posted the missing patches needed to make it work (but the
> > > patches are not by me).
> > 
> > Those are the patches at:
> > 
> > http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html
> > 
> > ?
> 
> Yes, that is right. Only the first patch is absoutely required for booting.

OK thanks.

> > Also are you using omap2plus_defconfig?
> 
> Yes, but I de-selected a few items. I will try it again without
> changing anything.

Just tried omap2plus_defconfig here and the board didn't boot, confirming 
your result.  Will add a section to the testlog README.txt about that.

> > In terms of differences from your setup, looks like we have different 
> > X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> > configs too.
> 
> What is X-Loader?

It's the "MLO" file on the SD card.  The on-chip ROM code boots that.  
Then X-Loader boots U-Boot.  Am not sure if it should still be called 
X-Loader - in your log it seems to be identifying itself as "U-Boot SPL" - 
so maybe that's not the old "X-Loader" code any more.


- Paul
