From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss clocks
	only when needed.
Date: Wed, 30 Sep 2009 11:31:09 -0700
Message-ID: <636c5030909301131k3f6f7ca0v1f4327d07fd0f9b7@mail.gmail.com>
References: <1253230586-931-1-git-send-email-mike@android.com>
	 <1253262472.28956.10.camel@tubuntu>
	 <8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
	 <1253514408.4690.5.camel@tubuntu> <877hvrf2sj.fsf@deeprootsystems.com>
	 <1253690451.14841.40.camel@tubuntu>
	 <87my4lbr86.fsf@deeprootsystems.com>
	 <1253788763.17009.282.camel@tubuntu>
	 <4ABB95A6.7000503@deeprootsystems.com>
	 <1253870386.21734.20.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:48900 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbZI3SbG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 14:31:06 -0400
Received: by pxi32 with SMTP id 32so5700666pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 11:31:09 -0700 (PDT)
In-Reply-To: <1253870386.21734.20.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: ext Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 25, 2009 at 2:19 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Thu, 2009-09-24 at 17:52 +0200, ext Kevin Hilman wrote:
>> Tomi Valkeinen wrote:
>
>> > If it is not like that, and the driver initialization is included,=
 how
>> > does the PM layer know how long it takes for the DSS driver to
>> > reconfigure the DSS hardware from OFF mode?
>>
>> Currently it doesn't, but if you were measure it, we can use those
>> numbers in the decision making process.
>
> Ok, now I see. However, I'm not sure if that will work. The problem i=
s
> that the wakeup latency depends on many things. When using DPI/RFBI t=
he
> wakeup is very fast. With SDI it's probably a bit slower and with DSI
> even slower.

The varying latencies are not an issues.  When in the different modes,
just register a different latency requirement.

> And at least with DSI PLL, the wakeup time depends on the frequencies
> used (according to TRM), and in some cases it can be optimized, in so=
me
> cases not. So I don't think there's one single value that fits all.

A single value isn't necessary.

> Also, I still think it would be better if the driver was also able to
> prevent OFF mode explicitely. Defining the max-wakeup-lat with a magi=
c
> number sounds a bit prone to breaking up.

I disagree.  What is important is that the driver communicates *why*
it needs to prevent OFF mode (can't handle the latency etc.)  and
decision making up to the PM core.  The drivers should not embed
policy in them.

> But perhaps, as you said, when drivers work properly they don't have =
to
> care about OFF mode as such, but only about the wakeup latency, and t=
hus
> the max-wakeup-lat is enough. I'm just not quite sure about that, as =
OFF
> mode may have side effects as the module is totally powered off, whil=
e
> with RET the side effects should be minimal.
>
> I don't have any concrete example about the side effects, but one
> particular thing I'm thinking about is DSI PLL. If DSS is in RET, I
> believe DSI PLL works normally. But if the DSS is reset via OFF mode,=
 I
> believe DSI PLL is also reset. But I'm not sure if DSI PLL is ever
> needed while DSS would be off, so this may be theoretical =3D).
>
> =A0Tomi

This problem is not unique to DSS, and the other drivers are handling t=
his.

Therefore, I'm inclined to merge this patch to that it's clear that
DSS support for OFF mode is broken and needs to be fixed.

As a *temporary*, debug solution, I might accept a hack where DSS2
disables OFF mode explicitly, but this will not go upstream.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
