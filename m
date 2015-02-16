From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Mon, 16 Feb 2015 10:06:26 -0800
Message-ID: <CAJAp7OgCs2kyF+ZdSzbf02qNHDdd_g=Nyf54akiAjAd1uK6cEA@mail.gmail.com>
References: <20150115135556.GH16217@leverpostej>
	<CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
	<CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
	<20150116101746.GA21809@leverpostej>
	<CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
	<20150120180548.GK7718@atomide.com>
	<CAK=WgbZGGtwmQwzWumjpYOsYHTt8vPQpTraABwJBsv5VXOmJ_Q@mail.gmail.com>
	<54BFE855.3090200@ti.com>
	<20150122185622.GE12911@leverpostej>
	<54C9AFF2.6000108@ti.com>
	<20150211112907.GD9154@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40637 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbbBPSG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2015 13:06:28 -0500
Received: by lbdu10 with SMTP id u10so86271lbd.7
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2015 10:06:26 -0800 (PST)
In-Reply-To: <20150211112907.GD9154@leverpostej>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Suman Anna <s-anna@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, Kumar Gala <galak@codeaurora.org>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>

On Wed, Feb 11, 2015 at 3:29 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jan 29, 2015 at 03:58:42AM +0000, Suman Anna wrote:
>> On 01/22/2015 12:56 PM, Mark Rutland wrote:
[..]
>> > That's the only way I would expect this to possibly remain a stable
>> > over time, and it's the entire reason for #hwlock-cells, no?
>> >
>> > How do you expect the other components sharing the hwspinlocks to be
>> > described?
>>
>> Yes indeed, this is what any of the clients will use on Linux. But
>> this is not necessarily the semantics for exchanging hwlocks with the
>> other processor(s) which is where the global id space comes into
>> picture.
>
> I did try to consider that above. Rather than thinking about the
> numbering as "global", think of it as unique within the a given pool
> shared between processors. That's what the "poolN" names are about
> above.
>
> That way you can dynamically allocate within the pool and know that
> Linux and the SW on the other processors will use the same ID. You can
> have pools that span multiple hwlock hardware blocks, and you can have
> multiple separate pools in operation at once.
>
> Surely that covers the cases you care about?
>
> If using names is clunky, we could instead have a pool-hwlocks property
> for that purpose.
>

Just to make I understand your suggestion.

We would have the communication entity list all the potential hwlocks
(and gpios etc) that it can share and the key to be communicated would
then basically be the index in that list?

Like:
awesome-hub {
    pool-hwlocks = <&a 1>, <&a 3>, <&b 5>;
};

And a communicated "lock 2" would mean lock 3 from block a?


This would make it possible to describe what locks are available in
this "allocation pool" and would keep such allocation logic out from
the hwlock core - as the awesome-hub driver could simply trial and
error (with some logic) through the list.

Is this understanding correct?

Regards,
Bjorn
