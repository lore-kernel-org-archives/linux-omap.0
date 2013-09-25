From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Wed, 25 Sep 2013 15:22:41 -0700
Message-ID: <CAN8TOE9Mo6sHWjy7ebtxTqZoDTM9dzcBqdu_qsZfP_ELtSufWw@mail.gmail.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
	<1378986619-26765-2-git-send-email-pekon@ti.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA15ED7@DBDE04.ent.ti.com>
	<20130925134619.GG10746@radagast>
	<20130925175527.GA23337@ld-irv-0074.broadcom.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA16884@DBDE04.ent.ti.com>
	<20130925200539.GH23337@ld-irv-0074.broadcom.com>
	<CAOesGMif301iBe9zxHudkC_G9SzPPy1Mj4XYvQ-MY8nmx4wO+A@mail.gmail.com>
	<20130925212903.GI23337@ld-irv-0074.broadcom.com>
	<CAOesGMi=xBXTdMm+-yTRVVFf0VR-7gy6xTrdeAupyo7OWVb3iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMi=xBXTdMm+-yTRVVFf0VR-7gy6xTrdeAupyo7OWVb3iQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 25, 2013 at 2:32 PM, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
> On Wed, Sep 25, 2013 at 2:29 PM, Brian Norris
> <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Wed, Sep 25, 2013 at 01:33:27PM -0700, Olof Johansson wrote:
>>> On Wed, Sep 25, 2013 at 1:05 PM, Brian Norris
>>> <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> > Olof has given good advice on your DT binding and has (slowly) been
>>> > responding to other requests for DT review that make it to his list. I
>>> > see that he hasn't followed up on your changes (this v6), so pinging him
>>> > (as you did) is probably the correct approach. But please do recognize
>>> > that the DT list is very high volume, so it's hard to get good timely
>>> > responses there.
>>>
>>> I am not a DT mainainer, but sometimes when I see a binding that
>>> appears to be wrong I speak up. In this case, the binding was one of
>>> those.
>>
>> Whoops, my bad. I was deceived by the responses I've seen from you on
>> other issues (thanks, BTW). In that case, I haven't seen any response
>> from a proper DT binding maintainer :(
>>
>>> So, I have no more objections to it, and I hope you can get a quick
>>> review from a DT maintainer on the rest of the binding.
>>
>> At this point, I'm comfortable going ahead without their ack, since they
>> obviously don't care/don't have the manpower to review.
>
> No, that is not how we handle device tree bindings. They need to be
> reviewed, since we are moving over to a model where they will be
> considered ABI and can't be changed after the fact. We have a long
> backlog of mostly-unreviewed old bindings that we're going to do a
> pass through and then lock down, but it would be good to not add to
> that backlog with newer bindings.
>
> In other words, there's a strong desire for actual acks on bindings
> from those maintainers these days.

This only works if we get a response. I'll repeat this fact: I have
seen absolutely zero response from any DT maintainer regarding this
binding, and they've been CC'd in some capacity since July:

Old revision from July (cross-posted, including the old DT list):
http://thread.gmane.org/gmane.linux.ports.arm.omap/100484/

New list:
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg95238.html

All official DT binding maintainers are CC'd here: you can't say you
want more review of bindings, yet fail to review them across 3
versions and almost 3 months. Ball's in your court.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
