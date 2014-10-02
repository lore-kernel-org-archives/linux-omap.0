From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.17-rc7
Date: Thu, 2 Oct 2014 09:17:15 -0700
Message-ID: <20141002161714.GI3122@atomide.com>
References: <alpine.DEB.2.02.1409291709020.7233@utopia.booyaka.com>
 <20140929172049.GD3122@atomide.com>
 <alpine.DEB.2.02.1410021447590.31530@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62474 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752854AbaJBQRI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2014 12:17:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1410021447590.31530@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [141002 08:11]:
> 
> Maybe you have some ideas for how this can be communicated better in the 
> test results?  One thing that would probably help is if the board was 
> renamed to "3730es10beaglexm" or something like that.  Also maybe 
> mentioning the fact that the test is only needed due to errata, like:
> 
> -----------
> PM: chip off (except CORE, due to errata) via dynamic idle:
>     Pass ( 1/ 1): 3730es10beaglexm
> -----------

Oh OK, yeah I did not read the actual test :) The above description
makes it clear at least for me.

Regards,

Tony 
