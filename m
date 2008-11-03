From: "Ming Lei" <tom.leiming@gmail.com>
Subject: Re: [PATCH] serial: Flush posted write on 34xx to make 8250 work (Re: What happened to the serial console on BeagleBoard with 2.6.28-rc2?)
Date: Mon, 3 Nov 2008 20:59:23 +0800
Message-ID: <d82e647a0811030459p2cccc76cxe93ea5a4c1386101@mail.gmail.com>
References: <E1KwhIl-0001an-Ro@amazonia.comcast.net>
	 <200811021126.13514.david-b@pacbell.net>
	 <20081102205019.GJ28924@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:63876 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbYKCM7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 07:59:24 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2514528wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 03 Nov 2008 04:59:23 -0800 (PST)
In-Reply-To: <20081102205019.GJ28924@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, rick@efn.org, linux-omap@vger.kernel.org, nmonson@gmail.com, felipe.contreras@gmail.com

2008/11/3 Tony Lindgren <tony@atomide.com>:
> * David Brownell <david-b@pacbell.net> [081102 11:26]:
>> On Sunday 02 November 2008, Rick Bronson wrote:
>> > > Is that what you saw too?
>> >
>> >   Yep, that's what I saw, but only if I had DEBUG_LL=y.  Without that
>> > I had nothing except "Uncompressing Linux........".
>>
>> I don't have DEBUG_LL=y ... if you had some kind of network
>> link configured over USB, could you SSH in?  (I can.)
>>
>>
>> >   I guess we don't see this problem on the other 2 ports since they
>> > are mapped MT_MEMORY_SO and not MT_DEVICE (L4_34XX_PHYS).
>>
>> Hmm, inconsistency is to be avoided.  :)
>>
>> I wonder what the root cause is ... is the driver missing
>> various barriers needed to make MT_DEVICE work?  Or is the
>> MT_DEVICE incorrect in the first place?  "git whatchanged"
>> didn't show any recent changes that seemed (on a quick
>> glance) to affect I/O at that level.  Maybe it was one of
>> the other TTY changes interacting here.
>
> Yeah I don't know what may have changed, or have things just
> gotten faster now with cortex since 2.6.27?
>
> Anyways, this patch fixes the issue for me without marking
> things strongly ordered. Rick, does this work for you?

This patch still works for me.
Thanks!

>
> Regards,
>
> Tony
>



-- 
Lei Ming
