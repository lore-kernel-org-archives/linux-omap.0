From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] OMAP clock: implement clock rate/parent change notifiers
Date: Thu, 8 Dec 2011 21:56:30 +0200
Message-ID: <CAMP44s3-O-PK_+Xvndq8AGMKR=AK3arDWHTZXs-hme=ynu7Ogg@mail.gmail.com>
References: <20090325160759.31866.49722.stgit@localhost.localdomain>
	<87tz5hwks8.fsf@deeprootsystems.com>
	<CAMP44s0qzSoDJbvzVOHNDbROPPWQH328LYKXSoLav+49vv-z_g@mail.gmail.com>
	<alpine.DEB.2.00.1112081222240.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37224 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1LHT4b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:56:31 -0500
Received: by bkbzv3 with SMTP id zv3so2023193bkb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 11:56:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112081222240.6289@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Thu, Dec 8, 2011 at 9:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Sun, 14 Aug 2011, Felipe Contreras wrote:
>> On Wed, Mar 25, 2009 at 7:54 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>> > Paul Walmsley <paul@pwsan.com> writes:
>> >> This series allows core code and driver code to register for
>> >> notification when a clock's rate or parent changes. =C2=A0This is=
 currently
>> >> used by driver code that must be notified whenever power manageme=
nt
>> >> code (e.g., CPUFreq) causes system rate changes that affect the d=
river's
>> >> clock.
>> >
>> > I will be re-basing the PM branch onto today's linux-omap HEAD whi=
ch
>> > is v2.6.29 based. =C2=A0As I do this, I'll be dropping all the pre=
vious
>> > notifier patches and replacing them with this series.
>>
>> What happened to this series? I don't see it anywhere.
>
> Unforunately It got postponed for a long time for a variety of reason=
s.
> The good news is that it seems that others are starting to realize th=
at
> something like this is needed, so hopefully it will finally go in as
> part of the common clock stuff.

Cool.

> Just out of curiosity: you are interested in them from the DSPBridge
> perspective? =C2=A0Or do you have another use-case in mind?

I ported the latest tidspbridge to the N9 kernel, and I was hit by a
bug, but it was only triggered in that kernel because of this patch.
So I was wondering why it never made it to mainline. That's all :)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
