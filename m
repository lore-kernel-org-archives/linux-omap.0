From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.32-rc3
Date: Sat, 10 Oct 2009 13:38:39 +0300
Message-ID: <94a0d4530910100338s6fb32d0dwb898d31053a423f5@mail.gmail.com>
References: <20091007185112.GJ7899@atomide.com>
	 <20091008214140.GJ7417@atomide.com>
	 <94a0d4530910081513w1a919dc2s50eca41966a2261d@mail.gmail.com>
	 <94a0d4530910081520t66ce7567xe142979a35b1245@mail.gmail.com>
	 <20091008232603.GB25892@atomide.com>
	 <94a0d4530910090508o1e3d19cew881d2eb348199674@mail.gmail.com>
	 <20091009144840.GA9561@suse.de>
	 <94a0d4530910091029p12f8c28fve91e95db533e78e5@mail.gmail.com>
	 <20091009192642.GB32084@suse.de>
	 <20091009143327.783b33c3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:46486 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbZJJKjR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Oct 2009 06:39:17 -0400
In-Reply-To: <20091009143327.783b33c3.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, Tony Lindgren <tony@atomide.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Denis Karpov <ext-denis.2.karpov@nokia.com>, Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

On Sat, Oct 10, 2009 at 12:33 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 9 Oct 2009 12:26:42 -0700
> Greg KH <gregkh@suse.de> wrote:
>
>> > >
>> > > What kind of issues? __Why would I be interested, where is the p=
roblem?
>> >
>> > The obvious-brain-dead-duh kind of issues, like this one.
>> >
>> > The problem is that OMAP devices (like beagleboard) are not bootin=
g
>> > correctly right now because of a wrong merge. It has been identifi=
ed,
>> > tested, and acked, but nobody has picked it up for a pull request,=
 so
>> > it's not clear it will be on -rc4.
>>
>> Has the patches been sent from the maintainer to Linus?
>>
>> Who is the maintainer? =C2=A0Who normally sends this stuff?
>>
>> > To me it's not clear who should push the patch, it seems it doesn'=
t
>> > belong on linux-omap, so Tony is pushing it through linux-mmc, whi=
ch I
>> > don't think is the right place. They should be handling mmc-relate=
d
>> > issues, not obvious breakage.
>>
>> Well, mmc related breakage is fine to handle :)
>>
>> > In order to keep the engines oiled I think there must be a process=
 to
>> > flag obvious generic breakage so it's immediately picked; maybe an
>> > 'obvious-fixes' tree, or a 'simple-fixes' that has 'trivial',
>> > 'includecheck', and similar, or maybe nothing needs to be done. Up=
 to
>> > you to decide.
>>
>> Andrew usually sends stuff like this at times.
>
> yeah, when in doubt, send it to me. =C2=A0When not in doubt send it t=
o me
> anyway ;)
>
> I'll take care of bugging the appropriate maintainer or merging it di=
rectly.

Ah, that's exactly what I wanted to know, thanks :)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
