From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Thu, 27 Nov 2008 12:53:19 +0530
Message-ID: <5d5443650811262323l759d8c02s835c9a7454508b85@mail.gmail.com>
References: <5d5443650811261044w30748b75w5a47ce8b04680f79@mail.gmail.com>
	 <200811262116.42364.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:62182 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYK0HXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 02:23:21 -0500
Received: by qb-out-0506.google.com with SMTP id f11so832805qba.17
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 23:23:20 -0800 (PST)
In-Reply-To: <200811262116.42364.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@nokia.com>
Cc: video4linux-list@redhat.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi Hans,

>
> 1) The makefile isn't right: it compiles omap24xxcam.c and
> omap24xxcam-dma.c as two modules, but I suspect you want only one since
> the symbols that omap24xxcam.c needs from omap24xxcam-dma.c are not
> exported. See e.g. the msp3400 driver in the Makefile for how to do it.

I will make this change.

>
> 2) The Kconfig is probably missing a ARCH_OMAP dependency (sounds
> reasonable, at least), so now it also compiles for the i686 but that
> architecture doesn't have a clk_get function.

I will add this dependency.

>
> 3) I was wondering whether Sakari also wants to add a Signed-off-by
> line? Looking at the comments it seems that he was involved as well.

I CCed from the first e-mail, so that he can review and give
Signed-off-by to this patch.

>
> 4) I get a bunch of compile warnings (admittedly when compiling for
> i686) that you might want to look at. Compiled against the 2.6.27
> kernel with gcc-4.3.1. It might be bogus since I didn't compile for the
> omap architecture.

I will update my toolchain to gcc-4.3.x for ARM and see if it
generates the warnings like below. But I think we are fine once we add
ARCH_OMAP dependency to this driver.

Thanks for the review comments. I will resubmit the patch.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
