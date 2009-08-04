From: Gary Thomas <gary@mlbassoc.com>
Subject: ISP buffer issue
Date: Tue, 04 Aug 2009 06:00:42 -0600
Message-ID: <4A7822EA.2020300@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:4775 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbZHDMAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 08:00:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm having trouble with the OMAP3 camera (ISP) support when
I have a large sensor.  I'm working with a 3M CCD sensor which
has a native resolution of 2048x1536.  The problem is when I
run V4L2 code which tries to allocate & map buffers for input
streaming.  If the frame is much bigger than PAL size (720x576)
the system hangs.

I traced this into the ISP layer and found that when the
buffer being allocated is over 1MB, this happens:
  isp_tmp_buf_alloc: allocating 1531904 bytes
which eventually fails in iommu_vmalloc()

Looking at the code, there seems to be some magic here - the
buffer allocation falls over if the request is large.  I'm
working from this code:
  http://arago-project.org/git/people/vaibhav/ti-psp-omap-video.git
starting from commit (ti_display head on 2009-07-23)
  6810d6d683e768c3bc6b5647c214804045665e22

Ideas?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
