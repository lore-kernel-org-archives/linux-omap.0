From: Anand Gadiyar <gadiyar@gmail.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Sun, 22 Feb 2009 21:29:30 +0530
Message-ID: <57969b5c0902220759n55798b71y64a5b17b7bdc7f98@mail.gmail.com>
References: <20090220125109.GL16942@scadufax.research.nokia.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02F565683F@dbde02.ent.ti.com>
	 <94a0d4530902220551x62dfeb8w248528922afbcd8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:44258 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbZBVP7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 10:59:31 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1517910rvb.5
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2009 07:59:30 -0800 (PST)
In-Reply-To: <94a0d4530902220551x62dfeb8w248528922afbcd8c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Sun, Feb 22, 2009 at 7:21 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Feb 20, 2009 at 3:23 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>>> Don't worry, you're not the only one TIred here...
>>
>> Grrr. I'm in no mood to take any TI puns right now. That was unwarranted.
>
> Was it? I agree with Felipe (Balbi) there's more people tired of this
> stuff. I don't know which way you would have preferred him to express
> his frustration, or maybe you don't want any negative feedback at all.
>

This comment was specific to the pun on TI. That pun was completely
unwarranted. He's not the only one frustrated here.

Just because I have an @ti.com id is not reason enough to blame all of
TI. There are people in TI doing real work.


>>> > So here's the quick mail you want:
>>> > "I may or may not be able to clean up this driver in the near future. Felipe
>>> > Balbi graciously agress to do it for us. So I am pleased to  announce he will
>>> > clean up this driver and send it upstream. If he needs any help with this, I
>>> > will try to provide it to him (or anyone else for that matter) on a best-effort
>>> > basis. Good luck."
>>> >
>>> >
>>> > >
>>> > > Anyways, I'll keep going with my cleanups and when I get a platform to
>>> > > test ehci, I'll try to test the patches and keep going with the
>>> > > workarounds.
>>> >
>>> > If you want help with testing, I can give it to you. If not, you can test
>>> > it yourself - I couldn't care less.
>>>
>>> And you want me to agree with it ? I really was hoping we could work
>>> together with TI but seems I'm the only one who still believes in that.
>>
>> I made that offer - so there is at least one other believer of working together.
>> You're the one that wants to do this on your own - and I'm okay with that.
>
> I don't know the history of this patch series, so perhaps I'm
> misinterpreting this, but it looks like he submitted some patches and
> you said it was the wrong way to do it and *you* would come up with a
> proper patch.
>

Then I suggest you read up the history. You __are__ misinterpreting
this. He did not submit any patches. He had a list of some tens of
drivers that he was planning to send to mainline sometime last
September. I thought I'll save everyone some time and would take care
of sending in at least the EHCI part so he could concentrate on other
stuff that he was doing. Unfortunately, I got preempted more than
once.


> A collaborative way to fix this issue would be to comment on the
> specific pieces of code you would want changed, perhaps even re-send
> the patches with the suggested changes so other people could review,
> comment, test, etc. This would probably generate a few rounds of patch
> series until it gets finally merged.
>

I am not against collaboration. Felipe said on Friday that he could do
the cleanups but had no way of testing. I do not have the bandwidth to
do those changes myself, but I did offer to test it for him. If this
is not collaboration, I do not know what is.

Felipe got mad at me and said he would rather read the errata and
implement it himself. And my response to that is above. If he wants to
work on EHCI himself, that's great. It'll save me the trouble of
testing and I'm guessing we'll see him return to the list 6 months
from now, just like I did :)

Reading up just the mail exchanges we've had on Friday is sufficient
to show who wants to work alone and who wants to collaborate.


> Instead you said you where going to provide a proper fix and never did
> so. There might be valid reasons for not coming up with the patches
> (like the difficulty of the task), but there's no excuse for the lack
> of communication.
>
>>> As you said yourself, you couldn't care less right ? You couldn't care
>>> less if the driver works or not, you couldn't care less if we have good
>>> omap support out of mainline kernel, you couldn't care less if the
>>> driver is readable or not, etc etc etc.
>>
>> That's not true. I do care. It __is__ important to me that OMAP support goes
>> to mainline. And I do not like it that it hasn't happened yet. Sorry.
>
> Personally I find your position to be not collaborative at all. Do you
> care or not? If you do, you could test Felipe's patches, review,
> comment, rewrite, etc.


Read the history before making your comments dude. I __have__ offered
to test. I do intend to spend time reviewing - but I will not
guarantee it.

Felipe's the one that flew off the handle before I did. Personally, I
do not find it at all amusing that everytime someone @nokia.com gets
shouted at on-list by someone @ti.com, all Nokia-ites gang up on the
TI-er.

Give us a break. It's not like we are against working with the community.

- Anand
