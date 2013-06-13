From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Thu, 13 Jun 2013 21:36:59 +0800
Message-ID: <CACVXFVPzf92Q4ZN_EpoKH7fgLWAg9M=ATUMKnWuKdpTvhU9C-w@mail.gmail.com>
References: <20130517191304.468.73487.stgit@localhost>
	<20130517191753.468.1734.stgit@localhost>
	<CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
	<20130612163124.GD8164@atomide.com>
	<20130612171407.GM8164@atomide.com>
	<51B98F1E.1000006@ti.com>
	<51B99B07.1050806@ti.com>
	<20130613110537.GC8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:33573 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758215Ab3FMNhB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 09:37:01 -0400
Received: by mail-vc0-f169.google.com with SMTP id ia10so7306703vcb.0
        for <linux-omap@vger.kernel.org>; Thu, 13 Jun 2013 06:37:00 -0700 (PDT)
In-Reply-To: <20130613110537.GC8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Jun 13, 2013 at 7:05 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Sricharan R <r.sricharan@ti.com> [130613 03:18]:
>> >
>> > I tried your cleanup branch omap-for-v3.11/cleanup on panda board and it booted
>> >  to prompt fine.
>> >             Hardware: Pandaboard A1   dtb: omap4-panda.dtb
>
> OK thanks for testing.
>
>> >   git pull on linux-next branch was not working though.
>> >
>>     Ok, tested in linux-next as well and it booted fine with DTB.
>>      HW: OMAP4430ES2.1 PANDA A1 version DTB: OMAP4-PANDA.DTB
>>
>>     Booted with ramdisk and mmc FS
>>
>> commit c04efed734409f5a44715b54a6ca1b54b0ccf215
>> Author: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date:   Fri Jun 7 16:40:02 2013 +1000
>>
>>     Add linux-next specific files for 20130607
>
> OK thanks for testing that too. I don't think these patches are
> in linux-next yet. But still good to hear it works.
>
> Ming Lei, any further info on your board?

OK, I will test the latest next tree to see if my board can work, and
post the result.


Thanks,
-- 
Ming Lei
