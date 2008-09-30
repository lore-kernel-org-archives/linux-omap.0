From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: MMC broken on beagleboard with current git
Date: Tue, 30 Sep 2008 16:24:10 +0300
Message-ID: <94a0d4530809300624p44c66bdal55e14a9f94bcd2bb@mail.gmail.com>
References: <FDAFB709-68B8-478D-8321-1322449B9A7F@student.utwente.nl>
	 <77EE6A0D-895B-4E0B-B9C4-18D333BFF85C@student.utwente.nl>
	 <20080925094718.GE5222@atomide.com>
	 <4D346DA2-6C57-48A7-AC4E-2191C44497CF@student.utwente.nl>
	 <20080925103952.GJ5222@atomide.com>
	 <5e088bd90809250824q38fb95e0q7a9e3f8a24a4d845@mail.gmail.com>
	 <20080926074208.GC7962@atomide.com>
	 <20080926111351.GA8736@atomide.com>
	 <20080928124641.GB8254@atomide.com>
	 <20080930125838.GA15828@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:35917 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbYI3NYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 09:24:14 -0400
Received: by ik-out-1112.google.com with SMTP id c30so10951ika.5
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 06:24:10 -0700 (PDT)
In-Reply-To: <20080930125838.GA15828@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, Sep 30, 2008 at 3:58 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [080928 15:44]:
>> * Tony Lindgren <tony@atomide.com> [080926 14:11]:
>> > * Tony Lindgren <tony@atomide.com> [080926 10:40]:
>> > > * Steve Sakoman <sakoman@gmail.com> [080925 18:24]:
>> > > > On Thu, Sep 25, 2008 at 3:39 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > > >
>> > > > > Hmm, I don't understand how it could work on 3430sdp...
>> > > > >
>> > > > > Looks like board-omap3beagle.c calls hsmmc_init() just like
>> > > > > board-3430sdp.c. Maybe timings have changed and you need
>> > > > > a longer delay somewhere during the init?
>> > > >
>> > > > I can confirm that mmc is also broken on Overo.  I'll spend some time
>> > > > today investigating.
>> > >
>> > > I'll double check on omap3430sdp.
>> >
>> > Hmm, MMC does not seem to work any longer on 3430sdp either. I guess I
>> > have broken it, sorry.
>> >
>> > I've also confirmed that undoing c434c15d28c82d92e55897bd265c423e9ab69362
>> > makes it work again.
>> >
>> > I swear it was working when I last tested it.. I'll try to debug it
>> > further, but I may not get to it for real until on Monday.
>> >
>> > I still suspect some timing change caused by the init changes..
>>
>> I've reverted c434c15d28c82d92e55897bd265c423e9ab69362 as I may not be
>> able to debug it until Wednesday.
>
> OK, found the problem, here's a diff on top of the currently reverted
> patch. I've pushed the MMC changes with this fix merged in, can you
> guys try it out now?

Seems to work fine for me on the beagleboard.

-- 
Felipe Contreras
