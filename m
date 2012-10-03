From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP4460/PandaES: hang during resume
Date: Wed, 03 Oct 2012 07:22:33 -0700
Message-ID: <87a9w33aae.fsf@deeprootsystems.com>
References: <87txuc4fd1.fsf@deeprootsystems.com>
	<CAMQu2gy7jdsiEenoE_GkpHRj2CGoySMS7LCo-PrfN-76hn02Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41561 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2JCOWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 10:22:32 -0400
Received: by pbbrr4 with SMTP id rr4so9905961pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 07:22:32 -0700 (PDT)
In-Reply-To: <CAMQu2gy7jdsiEenoE_GkpHRj2CGoySMS7LCo-PrfN-76hn02Vg@mail.gmail.com>
	(Santosh Shilimkar's message of "Wed, 3 Oct 2012 13:33:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Wed, Oct 3, 2012 at 5:05 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Hi Santosh, Tero,
>>
>> I just added my 4460/PandaES to my board farm for automated PM testing
>> and see that basic suspend/resume tests don't work in mainline.  It
>> fails on v3.6 and linux-next,arm-soc/for-next.
>>
>> Adding 'no_console_suspend' to the cmdline shows me that wakeup event is
>> happening so the hang is somewhere during resume.  I haven't dug any
>> deeper than that.
>>
>> This works fine on 4430/Panda.  Do you know of anything else we're
>> missing in mainline for a basic suspend/resume test on 4430?
>>
> OMAP4460 has one ROM code BUG which impacts MPUSS OSWR.
> I suspect you are missing that Errata WA.
> You need a patch [1] which is in Tero's CORE RET series.

Ah, yes.  The one where I asked you to q(re)write the change log a hundred
times.  How could I forget.  ;)

Thanks for the reminder.

Kevin
