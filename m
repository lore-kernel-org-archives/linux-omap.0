From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Fri, 16 May 2014 08:33:35 +0800
Message-ID: <53755CDF.9030803@linaro.org>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com> <5373C78E.7040301@linaro.org> <5373C8E8.6040208@ti.com> <5373CBB9.40506@linaro.org> <5373DD94.8030208@ti.com> <5374F35E.5040900@ti.com> <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com> <5375079E.3060305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56263 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaEPAdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 20:33:42 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so1765340pab.28
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2014 17:33:41 -0700 (PDT)
In-Reply-To: <5375079E.3060305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On 05/16/2014 02:29 AM, Santosh Shilimkar wrote:
> Alex,
> Please give a try with your test-case and see if you still see the hang.
> Am just curious about your issue and hence the request..

there is no test case. I just patched your patches, then boot new
kernel, system quickly to hang without any serial port oops, I am using
pandaES/ubuntu.

-- 
Thanks
    Alex
