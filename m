From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.14
Date: Wed, 2 Apr 2014 09:35:21 -0700
Message-ID: <20140402163521.GD12234@atomide.com>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
 <20140402162102.GB12234@atomide.com>
 <alpine.DEB.2.02.1404021631040.15928@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43922 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932282AbaDBQfZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2014 12:35:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1404021631040.15928@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [140402 09:36]:
> On Wed, 2 Apr 2014, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [140402 09:07]:
> > > 
> > > Here are some basic OMAP test results for Linux v3.14.
> > > Logs and other details at:
> > > 
> > >     http://www.pwsan.com/omap/testlogs/test_v3.14/20140402004448/
> > > 
> > > Boot to userspace:
> > >     FAIL ( 1/12): 2430sdp
> > 
> > Is this a new regression with MMC? Looks like your boot log for this
> > ends with "Waiting for root device /dev/mmcblk0p1...".
> 
> It's new since v3.14-rc1:
> 
> http://www.spinics.net/lists/arm-kernel/msg306448.html
> 
> http://www.spinics.net/lists/arm-kernel/msg306454.html
> 
> http://www.spinics.net/lists/arm-kernel/msg306455.html

OK looks like I never noticed that one before. Probably
because of NFSroot.

Tony
