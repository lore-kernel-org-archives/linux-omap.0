From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: Preempt-RT on OMAP3?
Date: Tue, 7 Apr 2009 14:12:59 +1200
Message-ID: <5a7b8b7b0904061912i47d9f87fr507816fe3f189ecc@mail.gmail.com>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
	 <200904060325.45758.david-b@pacbell.net>
	 <5a7b8b7b0904061453m725eee67m4b74c73bbffeb994@mail.gmail.com>
	 <200904061520.59391.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:62252 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759580AbZDGCNC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 22:13:02 -0400
Received: by gxk4 with SMTP id 4so5384527gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2009 19:13:00 -0700 (PDT)
In-Reply-To: <200904061520.59391.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 7, 2009 at 10:20 AM, David Brownell <david-b@pacbell.net> w=
rote:
> On Monday 06 April 2009, Hugo Vincent wrote:
>>
>> Here are some of the crashes I've seen. Warning - I'm new to -rt and
>> to the linux-omap tree, so I'll apologize in advance if these are ju=
st
>> a result of me missing something obvious.
>
> Thanks, I'll take a look.

Excellent, thank you!

>> Context: using USB-gadget ethernet (g_ether) over musb (configured a=
s
>> just peripheral, not OTG). Most of the time it works, but after a
>> while, or when it encounters a large packet (e.g fping -b30000) it
>> crashes like so (apparently something to do with receive DMA usage).
>> Although the fping -b case is kindof pathological, I've seen the sam=
e
>> crash when ssh/scping files across to the board, so it does occur in
>> real usage.
>
> RX DMA is troublesome with the MUSB code, and there are some bugfixes
> pending which should affect it. =A0(Posted to linux-usb over the last
> week or two.)
>
> Do these problems show up with DMA disabled?

I guess you mean with CONFIG_MUSB_PIO_ONLY - yes, I've tried that. I
don't observe the Rx DMA problems as described previously in that
configuration, no ........ However I instead I see hard-lockups with
no obvious cause and no messages printed to the console. (The only
repeatable one I've found so far is exiting cyclictest with ^C. Not
good). These lockups could well be and probably are unrelated, but
none-the-less, it's very troubling!

I've uploaded my defconfig here:
http://hugovincent.com/files/lkml-20090407/
along with a log of the bootup process. I've enabled a bunch of debug
options and self-tests. You can see the rather verbose output of some
spinlock tests (I think) failing early in the bootup process,
somewhere in timer initialization (I think?).

Regards,
Hugo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
