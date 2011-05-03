From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/9] OMAP: GPIO: cleanup, consolidation, etc. (v2)
Date: Tue, 03 May 2011 09:25:44 -0700
Message-ID: <87oc3jg393.fsf@ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037AD2771A@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037AD27761@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40392 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753600Ab1ECQZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 12:25:48 -0400
Received: by mail-pw0-f42.google.com with SMTP id 3so227786pwj.1
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 09:25:47 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037AD27761@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Mon, 25 Apr 2011 13:59:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> Kevin,
> [...]
>> >
>> > Here's an updated version of my work-in-progress GPIO cleanups.
>> >
>> > I now understand that others have some similar work in progress, so
>> > these are posted (to linux-omap only, for now) so that we can begin
>> > collaboration on the GPIO cleanups.
>> >
>> > This series applies on top of v2.6.39-rc4 plus the generic irq_chip
>> > series from Thomas Gleixner since in addition to the cleanups, I
>> > started moving the GPIO IRQ handling over to use generic irq_chip
>> > (last patch in series.)
>> >
>> > This work in progress is available in my wip/gpio-cleanup branch.
>> There are two observations in this series:
>> (1) omap1_defconfig  build generates following compilation errors:
> I realized that I missed the patch series from Thomas Gleixner.
> BTW, there are multiple series related to irq_chip cleanup.
> Do we need to apply all the series?

My wip/gpio-cleanup branch also includes Thomas' series, please use that
for testing.

Kevin
