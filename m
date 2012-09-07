From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] gpio/omap: fix possible memory leak in
 omap2_gpio_dev_init()
Date: Fri, 7 Sep 2012 15:24:17 -0700
Message-ID: <20120907222416.GR1303@atomide.com>
References: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
 <871uidjxmr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:55119 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751496Ab2IGWYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 18:24:23 -0400
Content-Disposition: inline
In-Reply-To: <871uidjxmr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux@arm.linux.org.uk, paul@pwsan.com, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [120907 15:07]:
> Wei Yongjun <weiyj.lk@gmail.com> writes:
> 
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >
> > pdata and pdata->regs have been allocated in this function and 
> > should be freed before leaving it, and in the other error handling
> > cases too.
> >
> > spatch with a semantic match is used to found this problem.
> > (http://coccinelle.lip6.fr/)
> >
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, can you pick this one up for fixes?

Sure, is fixes-noncritical OK for this one?

Tony
