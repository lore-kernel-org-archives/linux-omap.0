From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 2 Dec 2009 10:24:47 -0700
Message-ID: <fa686aa40912020924i6079275n5ad31fa91e52b8a@mail.gmail.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
	<1259599010.4649.51.camel@thunk> <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
	<20091130194031.GV4348@atomide.com> <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
	<20091202155319.GA3628@lixom.net> <fa686aa40912020804g34e1258k626349d711cfadd4@mail.gmail.com>
	<20091202161657.GA3903@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:40282 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbZLBRZB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 12:25:01 -0500
Received: by iwn1 with SMTP id 1so269115iwn.33
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 09:25:07 -0800 (PST)
In-Reply-To: <20091202161657.GA3903@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org

On Wed, Dec 2, 2009 at 9:16 AM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Dec 02, 2009 at 09:04:49AM -0700, Grant Likely wrote:
>
>> Ah, you're talking about pin muxing configuration, right? =A0Yes, th=
at
>> GPIO binding deals with controllers, not pin mux. =A0Pin mux is very
>> much an SoC specific thing that isn't mapped easily to a generic
>> binding.
>
> Yep.
>
>> On the 5200, I haven't attempted to describe pin-mux in the device
>> tree at all, and have either expected firmware to set it up correctl=
y,
>> or fixed it up in the platform code.
>
> Yeah. And it's one of the things Tony commented on that firmware tend=
s
> to get wrong, seems like people aren't doing complete mux configs in
> u-boot, etc.
>
> So, if it needs to be fixed up in platform code, there will (likely) =
be
> need for board-specific code there anyway. A bummer, since the device
> tree would otherwise make it real easy to bring up new boards without
> kernel code changes.

I didn't create a binding on the 5200 because I actually see very
little buggy firmware in that regard (partially because I kept telling
people to go fix their firmware).  :-)  If it ends up being the norm
that the kernel has to fix it for a given SoC, then I would create an
SoC-specific binding for pin mux configuration in the device tree so
that some degree of common code can still fix it up.

It should be feasible for board-specific code to be the exception, not =
the rule.

Cheers,
g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
