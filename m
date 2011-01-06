From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Date: Thu, 06 Jan 2011 10:34:56 -0800
Message-ID: <87bp3tvq27.fsf@ti.com>
References: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<87aajg7dzu.fsf@ti.com> <1294181154.18162.39.camel@localhost>
	<20110104231721.GO7771@atomide.com>
	<AANLkTi=-9soJBeSGGUmcKNckzV651y=uJ9co9rByJyQB@mail.gmail.com>
	<87oc7v1eav.fsf@ti.com> <20110106181249.GA2466@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46904 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751649Ab1AFSfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:35:03 -0500
Received: by mail-gx0-f170.google.com with SMTP id 20so9509045gxk.15
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 10:35:00 -0800 (PST)
In-Reply-To: <20110106181249.GA2466@acer> (Mika Westerberg's message of "Thu,
	6 Jan 2011 20:12:49 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Tony Lindgren <tony@atomide.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Mika Westerberg <mika.westerberg@iki.fi> writes:

> Hi Kevin,
>
> On Wed, Jan 05, 2011 at 08:54:48AM -0800, Kevin Hilman wrote:
>> 
>> I had assumed it was recent changes since the patch didn't apply
>> cleanly, but am glad to be wrong. :)
>
> The patch should apply cleanly on the latest mainline. Do you want me to
> rebase it against some other tree and resend?

No, it's fine.  I'll be queueing it for .38-rc2 and it's in my
'fixes-for-tony' branch.

Kevin


