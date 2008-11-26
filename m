From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP2/3 GPTIMER: skip unnecessary TLDR write	during non-autoreload
Date: Wed, 26 Nov 2008 10:39:01 -0800
Message-ID: <87r64yjpru.fsf@deeprootsystems.com>
References: <20081014172417.5459.36601.stgit@localhost.localdomain>
	<20081014172745.5459.1893.stgit@localhost.localdomain>
	<13B9B4C6EF24D648824FF11BE89671620365C448AB@dlee02.ent.ti.com>
	<20081121222232.GG4927@atomide.com>
	<13B9B4C6EF24D648824FF11BE8967162036CD41930@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:59032 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYKZSjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 13:39:11 -0500
Received: by nf-out-0910.google.com with SMTP id d3so331005nfc.21
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 10:39:07 -0800 (PST)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036CD41930@dlee02.ent.ti.com> (Richard Woodruff's message of "Fri\, 21 Nov 2008 16\:53\:17 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> * Woodruff, Richard <r-woodruff2@ti.com> [081014 12:47]:
>> > >       omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
>> > > -     omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
>> > >       omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
>> > >  }
>> >
>> > I seem to recall there was a missed interrupt condition which this worked
>> around.
>> >
>> > IIRC, the original code didn't bother with the load I added back as a work
>> around as a way to get posted mode working.
>>
>> Well these seem to be working based on some quick timer tests.
>> Pushing so we can verify it ;)
>
> This kind of change might be better tested on the PM branch.  It's
> the kind of thing more likely to work with PM disabled.  Testing in
> both is good, PM for many things is less forgiving...

I validated these patches on the PM branch.

I used cyclictest to test lots of timer reprogramming, and also tested
in both RET-while-idle and OFF-while-idle for low frequency timer
reprogramming.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>


