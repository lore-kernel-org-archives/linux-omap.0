From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCHv6 0/5] hwspinlock core/omap dt support
Date: Tue, 30 Sep 2014 13:54:28 -0700
Message-ID: <CAJAp7Ogbj5K4N7=TEQQ8HJ0X7hkOqzFwv=1bRicVCNX9cv_jaA@mail.gmail.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:60535 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaI3Uya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2014 16:54:30 -0400
Received: by mail-lb0-f180.google.com with SMTP id f15so7343343lbj.11
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2014 13:54:29 -0700 (PDT)
In-Reply-To: <1410553499-55951-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 12, 2014 at 1:24 PM, Suman Anna <s-anna@ti.com> wrote:
> Hi Ohad,
>
> This is an update to the hwspinlock dt support series. The series
> is rebased onto v3.17-rc3, and addresses the review comments on the
> previous v5 series. I have also split and left out the RFC patches
> about the support for reserved locks (will post these as a separate
> series) and return code convention changes in the hwspinlock core
> (will not be needed anymore). The support for deferred probing of
> clients is supported in the new of_hwspin_lock_get_id() function
> itself.
>

Thanks for your reply to me, I had missed that you continued this work.


I find it somewhat awkward to have to call both of_hwspin_lock_get_id() and
then hwspin_lock_request_specific(), but I found the request from Ohad, so
let's stick with it.


Am I right that hwlock-num-locks and hwlock-base-id are optional from the
frameworks perspective and only there to aid the hwspin drivers? If so it is
strange to have in the common binding and have the helper functions in the core
for simply reading hwspin device specific properties.

Otherwise I think it looks sane, although I haven't spend that much time
reviewing it.

I did throw it into my tree and gave it a testrun with the Qualcomm code I've
been working on. So for the non-omap parts:

Tested-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
