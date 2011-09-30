From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
Date: Fri, 30 Sep 2011 14:45:13 +0530
Message-ID: <CAMQu2gyBq61jcP1sLDEs8+zGfdAa6Pur1fSec9Wfzs48CX5zjA@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
 <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com> <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:45927 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757621Ab1I3JPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 05:15:36 -0400
Received: by yxk36 with SMTP id 36so2169005yxk.27
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 02:15:34 -0700 (PDT)
In-Reply-To: <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

On Fri, Sep 30, 2011 at 3:00 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/9/8 Santosh Shilimkar <santosh.shilimkar@ti.com>:
>
>> Local timer clock is sourced from the CPU clock and hence changes
>> along with CPU clock. These per CPU local timers are used as
>> clock-events, so they need to be reconfigured on CPU frequency
>> change as part of CPUfreq governor.
>
> This requires patch 6956/2 right?
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2
>
> Can I add your Tested-by: to the patch as well?
>
Sure.
