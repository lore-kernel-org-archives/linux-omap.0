From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix return value check in
 omap_device_build_from_dt()
Date: Tue, 17 Sep 2013 16:29:24 -0700
Message-ID: <20130917232924.GN9994@atomide.com>
References: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
 <20130821071901.GR7656@atomide.com>
 <87r4dg6lj2.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56596 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab3IQX3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Sep 2013 19:29:30 -0400
Content-Disposition: inline
In-Reply-To: <87r4dg6lj2.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@linaro.org> [130826 17:17]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Kevin,
> >
> > * Wei Yongjun <weiyj.lk@gmail.com> [130704 06:48]:
> >> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >> 
> >> In case of error, the function omap_device_alloc() returns ERR_PTR()
> >> and never returns NULL. The NULL test in the return value check
> >> should be replaced with IS_ERR().
> >
> > Looks like this is still pending, care to take this?
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> Looks fine to me, since I don't have anything else in the queue, feel
> free to queue up for fixes-non-critical.

Applying into omap-for-v3.12/fixes thanks.

Tony
