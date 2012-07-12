From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] gpio/omap: add *remove* callback in platform_driver
Date: Thu, 12 Jul 2012 10:48:01 -0700
Message-ID: <87a9z4g9bi.fsf@ti.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
	<1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
	<87394xhocn.fsf@ti.com>
	<CACRpkdZMG_ZHW_eGGrdrJh1SuO_=hOObijzmxG1ob6RoNf_dwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:37692 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932762Ab2GLRsB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 13:48:01 -0400
Received: by ghy10 with SMTP id 10so4935032ghy.16
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 10:48:00 -0700 (PDT)
In-Reply-To: <CACRpkdZMG_ZHW_eGGrdrJh1SuO_=hOObijzmxG1ob6RoNf_dwg@mail.gmail.com>
	(Linus Walleij's message of "Thu, 12 Jul 2012 13:03:00 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Linus,

Linus Walleij <linus.walleij@linaro.org> writes:

> On Thu, Jul 12, 2012 at 1:25 AM, Kevin Hilman <khilman@ti.com> wrote:
>
>> There is quite a bit of other things to do in remove to properly cleanup
>> what is done in probe.
>
> OK I'm dropping this patch for now...
>

Thanks.

For future reference...  as one of the OMAP maintainers, I request that
you not pull/merge OMAP GPIO patches unless they've had a bit of review
and exposure.  Unfortunately, we have a history with this driver where
regressions have been introduced and the maintainers end up having to
find and fix them.  

In the case of OMAP GPIO, unless it's an obvious fix, I would recommend
you wait at least until you see some acks/tested tags from any of

- Santosh Shilimkar <santosh.shilimkar@ti.com>
- Rajendra Nayak <rnayak@ti.com>
- Benoit Cousson <b-cousson@ti.com>

or Tony, Paul or myself.

For major series, I have been collecting/queueing them for Grant after
ensuring they have been well reviewed and well tested (although I am
eagerly hoping to hand off this role to someone else.)

Thanks,

Kevin
