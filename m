From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: Preempt-RT on OMAP3?
Date: Tue, 7 Apr 2009 14:44:24 +1200
Message-ID: <5a7b8b7b0904061944h65f7b36cja70681d6a512693b@mail.gmail.com>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
	 <200904061520.59391.david-b@pacbell.net>
	 <5a7b8b7b0904061912i47d9f87fr507816fe3f189ecc@mail.gmail.com>
	 <200904061927.09627.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:53979 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbZDGCo1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 22:44:27 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2434685ywb.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2009 19:44:25 -0700 (PDT)
In-Reply-To: <200904061927.09627.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 7, 2009 at 2:27 PM, David Brownell <david-b@pacbell.net> wr=
ote:
>
>> > RX DMA is troublesome with the MUSB code, and there are some bugfi=
xes
>> > pending which should affect it. =A0(Posted to linux-usb over the l=
ast
>> > week or two.)
>> >
>> > Do these problems show up with DMA disabled?
>>
>> I guess you mean with CONFIG_MUSB_PIO_ONLY - yes, I've tried that. I
>> don't observe the Rx DMA problems as described previously in that
>> configuration, no ........
>
> Good...

So based on what you've seen, do you think the queued patches for MUSB
you mentioned will fix these problems?

>> However I instead I see hard-lockups with
>> no obvious cause and no messages printed to the console. (The only
>> repeatable one I've found so far is exiting cyclictest with ^C. Not
>> good). These lockups could well be and probably are unrelated, but
>> none-the-less, it's very troubling!
>
> Given the bootlog excerpt you posted, I'm thinking there are
> still some basic goofy things with the RT patches you're using
> even outside the scope of MUSB. =A0Basic as in timer tick and
> kernel thread setup; lots of things look goofy.
>

Here is a complete boot log + config:
http://hugovincent.com/files/lkml-20090407/boot2.log

Who is working on OMAP3 -rt? Does anyone have any tips for tracking
down the apparent basic problems David mentioned (timer tick, kernel
thread setup)?

Thanks,
Hugo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
