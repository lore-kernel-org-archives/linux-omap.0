From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] gpio/omap: fix possible memory leak in omap2_gpio_dev_init()
Date: Fri, 07 Sep 2012 15:06:52 -0700
Message-ID: <871uidjxmr.fsf@deeprootsystems.com>
References: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35295 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2IGWGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 18:06:54 -0400
Received: by pbbrr13 with SMTP id rr13so228010pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 15:06:54 -0700 (PDT)
In-Reply-To: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
	(Wei Yongjun's message of "Mon, 3 Sep 2012 20:42:27 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> pdata and pdata->regs have been allocated in this function and 
> should be freed before leaving it, and in the other error handling
> cases too.
>
> spatch with a semantic match is used to found this problem.
> (http://coccinelle.lip6.fr/)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, can you pick this one up for fixes?

Thanks,

Kevin
