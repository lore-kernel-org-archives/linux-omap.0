From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.14
Date: Wed, 2 Apr 2014 09:33:31 -0700
Message-ID: <20140402163331.GC12234@atomide.com>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
 <20140402162102.GB12234@atomide.com>
 <20140402162154.GJ8504@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39252 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932317AbaDBQdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2014 12:33:37 -0400
Content-Disposition: inline
In-Reply-To: <20140402162154.GJ8504@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org, Nishanth Menon <nm@ti.com>

* Felipe Balbi <balbi@ti.com> [140402 09:27]:
> On Wed, Apr 02, 2014 at 09:21:03AM -0700, Tony Lindgren wrote:
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
> Nishanth already posted about this a few days ago, see [1]
> 
> [1] http://marc.info/?l=linux-omap&m=139637044425644&w=2

OK thanks.

Tony
