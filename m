From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 05/13] gpio/omap: get rid of retrigger variable in gpio_irq_handler
Date: Mon, 12 Mar 2012 11:53:14 -0700
Message-ID: <87ehsxy7l1.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
	<CAC83ZvJXK-FsiqyQT6BQxggRewkiHZkRBi44CVH15gb4dUbsjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41503 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752891Ab2CLSxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 14:53:07 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7221210iag.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 11:53:06 -0700 (PDT)
In-Reply-To: <CAC83ZvJXK-FsiqyQT6BQxggRewkiHZkRBi44CVH15gb4dUbsjw@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Fri, 9 Mar 2012 14:16:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Wed, Mar 7, 2012 at 4:45 PM, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
>> This local variable is just assigned zero and then OR'ed
>> with isr. It does not appear to serve any purpose and so
>> removing it.
> Missed following comments from Kevin given in v2. Sorry about that.
> I have updated the change in:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev
> for_3.4/gpio_further_cleanup_fixes
>
> "commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic IRQ
> framework) removed retrigger support in favor of using generic IRQ
> framework.  This patch cleans up some unused remnants of that removal.

Ah, thanks.

Kevin
