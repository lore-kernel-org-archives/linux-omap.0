From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP: fix return value check in omap_device_build_from_dt()
Date: Mon, 26 Aug 2013 17:10:41 -0700
Message-ID: <87r4dg6lj2.fsf@linaro.org>
References: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
	<20130821071901.GR7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55443 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab3H0AKn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 20:10:43 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4078563pdj.22
        for <linux-omap@vger.kernel.org>; Mon, 26 Aug 2013 17:10:43 -0700 (PDT)
In-Reply-To: <20130821071901.GR7656@atomide.com> (Tony Lindgren's message of
	"Wed, 21 Aug 2013 00:19:01 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Kevin,
>
> * Wei Yongjun <weiyj.lk@gmail.com> [130704 06:48]:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> In case of error, the function omap_device_alloc() returns ERR_PTR()
>> and never returns NULL. The NULL test in the return value check
>> should be replaced with IS_ERR().
>
> Looks like this is still pending, care to take this?

Acked-by: Kevin Hilman <khilman@linaro.org>

Looks fine to me, since I don't have anything else in the queue, feel
free to queue up for fixes-non-critical.

Kevin
