From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 20:37:24 +0200
Message-ID: <20121020183724.GA9984@netboy.at.omicron.at>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
 <20121020180123.GA2630@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53134 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2JTShf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 14:37:35 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1249245wib.1
        for <linux-omap@vger.kernel.org>; Sat, 20 Oct 2012 11:37:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Oct 20, 2012 at 06:12:35PM +0000, Paul Walmsley wrote:
> Just tried omap2plus_defconfig here and the board didn't boot, confirming 
> your result.  Will add a section to the testlog README.txt about that.
> 
> > > In terms of differences from your setup, looks like we have different 
> > > X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> > > configs too.

I tried both omap2plus_defconfig and your am33xx_only config, and
neither one work with my (recent) u-boot version.

Thanks,
Richard
