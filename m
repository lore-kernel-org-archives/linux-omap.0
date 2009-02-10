From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: musb OTG broken in 2.6.29-rc3?
Date: Tue, 10 Feb 2009 06:27:18 -0800
Message-ID: <5e088bd90902100627m746674d7mb7d929c584c7515a@mail.gmail.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com>
	 <5e088bd90902092043u913d35axe658e784d4befb59@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403FA81B610@dbde02.ent.ti.com>
	 <20090210073525.GE3166@scadufax.research.nokia.com>
	 <20090210104634.40706b4f.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42509 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbZBJO1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 09:27:21 -0500
Received: by bwz5 with SMTP id 5so2736962bwz.13
        for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 06:27:18 -0800 (PST)
In-Reply-To: <20090210104634.40706b4f.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Feb 10, 2009 at 12:46 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Tue, 10 Feb 2009 08:35:31 +0100
> "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com> wrote:
>
>> > > Could you give me a little more detail on what you had to do for
>> > > session start?  Perhaps I have a similar issue on Overo.
>> > It is same $ echo "F" >/proc/driver/musb_hdrc, which was earlier
>> > In musb_procfs.c and now been removed.
>> >
>> > +       case 'F':
>> > +               reg = musb_readb(mbase, MUSB_DEVCTL);
>> > +               reg |= MUSB_DEVCTL_SESSION;
>> > +               musb_writeb(mbase, MUSB_DEVCTL, reg);
>>
>> a temp sysfs for that will help:
>>
>> Steve, could you try the following
>>
> I let Felipe to send new version of the patch where it applies (I had
> there spaces instead of tabs?) and condition for session value is not
> true for all values ;-)

I had the same issue with spaces/tabs.

Heading to the airport now, so won't be able to do further testing
(beyond compile testing) till Friday.

> But for me Beagle work. Ethernet gadget just fine and HS HUB by kicking
> the session on.

What method did you use to kick the session on?  Was this always
required?  I might be misremembering, but I seem to recall that
plugging in a miniA cable resulted in musb automatically switching
modes to host.

Sorry for the perhaps stupid questions, I am *far* from being a USB expert :-)

Regards,

Steve
