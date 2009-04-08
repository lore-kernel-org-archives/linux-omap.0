From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: Preempt-RT on OMAP3?
Date: Wed, 8 Apr 2009 13:22:28 +1200
Message-ID: <5a7b8b7b0904071822r52e910aat2454a63b0edadb69@mail.gmail.com>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
	 <200904061927.09627.david-b@pacbell.net>
	 <5a7b8b7b0904061944h65f7b36cja70681d6a512693b@mail.gmail.com>
	 <200904062036.57982.david-b@pacbell.net>
	 <5a7b8b7b0904062119w42209eedp8645d096acb8c4dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:24518 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbZDHBWa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 21:22:30 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2822452ywb.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Apr 2009 18:22:28 -0700 (PDT)
In-Reply-To: <5a7b8b7b0904062119w42209eedp8645d096acb8c4dd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 7, 2009 at 4:19 PM, Hugo Vincent <hugo.vincent@gmail.com> w=
rote:
> On Tue, Apr 7, 2009 at 3:36 PM, David Brownell <david-b@pacbell.net> =
wrote:
>> On Monday 06 April 2009, Hugo Vincent wrote:
>>> Here is a complete boot log + config:
>>> http://hugovincent.com/files/lkml-20090407/boot2.log
>>
>> Erm, not very complete actually. =A0Enable DEBUG_LL to see
>> more early messages ... like the ones starting right
>> after the kernel decompression messages.
>
> How's this?
> http://hugovincent.com/files/lkml-20090407/boot3.log
>
> (In case it isn't clear, we get messages twice because console and
> debug_LL are on the same serial port. I also had to increase
> CONFIG_LOG_BUF_SHIFT to get a complete log in dmesg.)

Can anyone give me any pointers on where to start for fixing the
problems shown in the above boot log?

It looks like some fairly low level locking bugs (spinlock vs
raw_spinlock maybe?) in twl4030 IRQ handling and GP timer/clock event
source setup.

Hugo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
