From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Fwd: MMC3 Overo
Date: Wed, 05 Aug 2009 10:58:22 -0700
Message-ID: <4A79C83E.9040603@deeprootsystems.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>	 <6ed0b2680908050132n33abc45bgd4e91690c43ba277@mail.gmail.com>	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>	 <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>	 <873a866xdo.fsf@deeprootsystems.com>	 <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com> <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:32925 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZHER6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 13:58:24 -0400
Received: by pzk34 with SMTP id 34so207117pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 10:58:25 -0700 (PDT)
In-Reply-To: <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: John Sarman <johnsarman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Steve Sakoman wrote:
> On Wed, Aug 5, 2009 at 9:35 AM, John Sarman<johnsarman@gmail.com> wrote:
>> On Wed, Aug 5, 2009 at 12:25 PM, Kevin Hilman<khilman@deeprootsystems.com> wrote:
>>> Might I suggest a kernel patch for this rather than fixing u-boot so that
>>> all the midnight oil you've burnt does not have to be duplicated by others.
>> Well I dont know how to answer that.  Because the Mux architecture is
>> slightly on the scary side.  I personally have had success with it,
>> but everytime you need to add a new pin functionality you have to
>> update mux.h.  I finally decided to just focus on having the MUX
>> correct at boot up via u-boot.
>>
>> I could just add the code to update the mux without using the mux architecture.
>>
>> I would appreciate some opinions on this.
> 
> I get discouraged every time I look at using kernel pinmuxing.  It
> seems to assume that some mux settings are "standard" when in my
> experience that is often not so.  So I face having to write code to
> undo what it does (and face glitches on the gpio lines), or the bigger
> task of restructuring the code to do the right thing.
> 
> And up to now in each case I shrug and say "no time to do that now,
> I'll just leave kernel pinmuxing turned off and do it in u-boot"

I agree there are lots of shortcomings in the current mux code and we've 
been hitting them regularily lately.

That being said, for mux settings that done one-time only at boot, what 
are the problems you're running into?

All that should be necessary for a one-time setup is possibly adding and 
entry to mux.h and then calling omap_cfg_reg() in your board init code.

Kevin



