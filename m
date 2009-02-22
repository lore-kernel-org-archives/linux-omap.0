From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Sun, 22 Feb 2009 15:51:09 +0200
Message-ID: <94a0d4530902220551x62dfeb8w248528922afbcd8c@mail.gmail.com>
References: <20090220125109.GL16942@scadufax.research.nokia.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02F565683F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:59068 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZBVNvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 08:51:13 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2409600fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2009 05:51:09 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F565683F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 3:23 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> Don't worry, you're not the only one TIred here...
>
> Grrr. I'm in no mood to take any TI puns right now. That was unwarran=
ted.

Was it? I agree with Felipe (Balbi) there's more people tired of this
stuff. I don't know which way you would have preferred him to express
his frustration, or maybe you don't want any negative feedback at all.

>> > So here's the quick mail you want:
>> > "I may or may not be able to clean up this driver in the near futu=
re. Felipe
>> > Balbi graciously agress to do it for us. So I am pleased to =C2=A0=
announce he will
>> > clean up this driver and send it upstream. If he needs any help wi=
th this, I
>> > will try to provide it to him (or anyone else for that matter) on =
a best-effort
>> > basis. Good luck."
>> >
>> >
>> > >
>> > > Anyways, I'll keep going with my cleanups and when I get a platf=
orm to
>> > > test ehci, I'll try to test the patches and keep going with the
>> > > workarounds.
>> >
>> > If you want help with testing, I can give it to you. If not, you c=
an test
>> > it yourself - I couldn't care less.
>>
>> And you want me to agree with it ? I really was hoping we could work
>> together with TI but seems I'm the only one who still believes in th=
at.
>
> I made that offer - so there is at least one other believer of workin=
g together.
> You're the one that wants to do this on your own - and I'm okay with =
that.

I don't know the history of this patch series, so perhaps I'm
misinterpreting this, but it looks like he submitted some patches and
you said it was the wrong way to do it and *you* would come up with a
proper patch.

A collaborative way to fix this issue would be to comment on the
specific pieces of code you would want changed, perhaps even re-send
the patches with the suggested changes so other people could review,
comment, test, etc. This would probably generate a few rounds of patch
series until it gets finally merged.

Instead you said you where going to provide a proper fix and never did
so. There might be valid reasons for not coming up with the patches
(like the difficulty of the task), but there's no excuse for the lack
of communication.

>> As you said yourself, you couldn't care less right ? You couldn't ca=
re
>> less if the driver works or not, you couldn't care less if we have g=
ood
>> omap support out of mainline kernel, you couldn't care less if the
>> driver is readable or not, etc etc etc.
>
> That's not true. I do care. It __is__ important to me that OMAP suppo=
rt goes
> to mainline. And I do not like it that it hasn't happened yet. Sorry.

Personally I find your position to be not collaborative at all. Do you
care or not? If you do, you could test Felipe's patches, review,
comment, rewrite, etc.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
