From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: ISP buffer issue
Date: Thu, 06 Aug 2009 17:47:56 +0300 (EEST)
Message-ID: <20090806.174756.260101773.Hiroshi.DOYU@nokia.com>
References: <4A7822EA.2020300@mlbassoc.com>
	<4A7AE905.4020600@mlbassoc.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37121 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbZHFOsn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 10:48:43 -0400
In-Reply-To: <4A7AE905.4020600@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gary@mlbassoc.com
Cc: linux-omap@vger.kernel.org

From: ext Gary Thomas <gary@mlbassoc.com>
Subject: Re: ISP buffer issue
Date: Thu, 6 Aug 2009 16:30:29 +0200

> Gary Thomas wrote:
> > I'm having trouble with the OMAP3 camera (ISP) support when
> > I have a large sensor.  I'm working with a 3M CCD sensor which
> > has a native resolution of 2048x1536.  The problem is when I
> > run V4L2 code which tries to allocate & map buffers for input
> > streaming.  If the frame is much bigger than PAL size (720x576)
> > the system hangs.
> > 
> > I traced this into the ISP layer and found that when the
> > buffer being allocated is over 1MB, this happens:
> >   isp_tmp_buf_alloc: allocating 1531904 bytes
> > which eventually fails in iommu_vmalloc()
> > 
> > Looking at the code, there seems to be some magic here - the
> > buffer allocation falls over if the request is large.  I'm
> > working from this code:
> >   http://arago-project.org/git/people/vaibhav/ti-psp-omap-video.git
> > starting from commit (ti_display head on 2009-07-23)
> >   6810d6d683e768c3bc6b5647c214804045665e22
> 
> Hiroshi - I CC'd you directly as this code seems to be yours.
> Could you comment on my problem?

Can you point out which function returns error in iommu_vmalloc()?

