From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Fri, 13 Jan 2012 08:50:03 -0800
Message-ID: <20120113165003.GJ15299@atomide.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
 <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58094 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab2AMQuH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 11:50:07 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120113 06:08]:
> On Fri, Jan 13, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> =
wrote:
> > On Fri, Jan 13, 2012 at 18:19:24, Shilimkar, Santosh wrote:
> >> > =C2=A0 ...
> >> > =C2=A0 };
> >> >
> >> > =C2=A0 We need to have similar entries in all devices where 32K =
timer is present.
> >> >
> >> > 2) OR simply add another cpu_is_am33xx() and then fall back to d=
mtimer?
> >> > =C2=A0 Just to prove this, everything works here, I modified the=
 code for this
> >> > =C2=A0 and tested it on both AM335x EVM and AM37xEVM and it work=
s fine for me.
> >> >
> >> >
> >> > Any comments?? OR Better approach? OR anything which I am missin=
g here?

Why don't you just add a new entry to mach-omap2/timer.c using the OMAP=
_SYS_TIMER
macro?

See for example the omap3_secure timer set up. That should allow
specifying the clock source already.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
