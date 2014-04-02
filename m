From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.14
Date: Wed, 2 Apr 2014 16:32:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404021631040.15928@utopia.booyaka.com>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com> <20140402162102.GB12234@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41934 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbaDBQc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2014 12:32:58 -0400
In-Reply-To: <20140402162102.GB12234@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Wed, 2 Apr 2014, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [140402 09:07]:
> > 
> > Here are some basic OMAP test results for Linux v3.14.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.14/20140402004448/
> > 
> > Boot to userspace:
> >     FAIL ( 1/12): 2430sdp
> 
> Is this a new regression with MMC? Looks like your boot log for this
> ends with "Waiting for root device /dev/mmcblk0p1...".

It's new since v3.14-rc1:

http://www.spinics.net/lists/arm-kernel/msg306448.html

http://www.spinics.net/lists/arm-kernel/msg306454.html

http://www.spinics.net/lists/arm-kernel/msg306455.html


- Paul
