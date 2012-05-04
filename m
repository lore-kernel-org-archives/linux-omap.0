From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH-V6 1/3] ARM: OMAP1: FIX: check possible error condition in timer_init
Date: Fri, 04 May 2012 21:45:20 +0200
Message-ID: <1353295.rIGgu9aSFg@acer>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com> <87y5pafis6.fsf@ti.com> <20120504174301.GH5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56785 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab2EDTqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 15:46:06 -0400
In-Reply-To: <20120504174301.GH5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

Dnia pi=C4=85tek, 4 maja 2012 10:43:02 Tony Lindgren pisze:
> Hi,
>=20
> * Kevin Hilman <khilman@ti.com> [120502 13:11]:
> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> >=20
> > > OMAP1, omap_32k_timer_init() function always returns "true",
> > > irrespective of whether error occurred while initializing 32k syn=
c
> > > counter as a kernel clocksource or not and execution will never
> > > fallback to mpu_timer clocksource init code.
> > >
> > > This patch adds check for return value from function
> > > omap_init_clocksource_32k(), and fallback to omap_mpu_timer_init(=
)
> > > in case of failure/error from omap_init_clocksource_32k().
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Kevin Hilman <khilman@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > ---
> > > This is new patch addition compared to original series (<=3DV5).
> > >
> > > Also, note that, this patch is only compile tested, since
> > > I do not have omap1 board with me to validate it.
> > > Kevin, can you help me to validate it.
> >=20
> > I boot tested on OMAP1 (5912/OSK) with 32k timer and MPU timer
> > Kconfigs.  Works fine, but needs small change below for compile=20
warnings.
> >=20
> > Otherwise, looks good.
>=20
> We need at least one tested-by on some 15xx platform for these=20
changes.
> Janusz, can you please give this series a try on your board too?

Sure, but in a week or so.

I'm still trying to follow the l-o list, but please always Cc: me for=20
testing any changes on Amstrad Delta whenever you see fit.

Regards,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
