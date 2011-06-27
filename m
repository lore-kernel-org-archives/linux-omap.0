From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Date: Mon, 27 Jun 2011 12:04:17 -0700
Message-ID: <87vcvrayfi.fsf@ti.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
	<20110627123140.GP23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35945 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753210Ab1F0TEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 15:04:25 -0400
Received: by mail-pv0-f180.google.com with SMTP id 21so4139146pvc.11
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 12:04:21 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
	(Sanjeev Premi's message of "Mon, 27 Jun 2011 18:58:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Gregoire Gentil <gregoire@gentil.com>, "Bhandiwad, Hrishikesh" <hrishikesh.b@ti.com>, Jason Lam <lzg@ema-tech.com>, Thomas Weber <weber@corscience.de>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Tony Lindgren [mailto:tony@atomide.com] 
>> Sent: Monday, June 27, 2011 6:02 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org; 
>> linux-arm-kernel@lists.infradead.org; Gregoire Gentil; 
>> Bhandiwad, Hrishikesh; Jason Lam; Thomas Weber
>> Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
>> 
>> * Premi, Sanjeev <premi@ti.com> [110627 05:08]:
>> > > From: Tony Lindgren [mailto:tony@atomide.com] 
>> > > 
>> > > I don't think omap3_beagle_init_rev is even called when
>> > > the timer is set?
>> > 
>> > [sp] I verified the patch based on the print indicating that
>> >      GPTIMER1 being used as clockevent source.
>> >      http://marc.info/?l=linux-omap&m=130893319726456&w=2
>> 
>> I suspect the test always fails though, so it probably never
>> gets set to gptimer12 on any board :)
>>
>
> [sp] While I take my time understanding things on devel-timer;
>      I had a quick question - at risk of being flamed.
>
>      Adding a new machine ID would trickle to u-boot and same
>      uImage (default) may not work across board revisions.
>
>      How does this scheme look like:
>      - GPTIMER1 is used as default - as it works for most boards.
>      - GPTIMER12 is used based on a static config option OR a
>        board specific bootarg
>
>      I know both these options aren't general practice. Still
>      wanted to know your views in the current context.
>

Another option may be to always use GPTIMER1 on early boot for all
boards.  Later in the boot, when the old rev boards are detected, a new
GPT12 clockevent could be registered (with a higher rating) such that
the clockevent core would switch to the new source.

Kevin
