From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/7] OMAP2+: powerdomain: add voltage domain lookup during
 register
Date: Wed, 23 Mar 2011 00:04:40 +0100
Message-ID: <4D892B08.7000805@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-5-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1103221313460.11798@utopia.booyaka.com> <4D890D9E.804@ti.com> <alpine.DEB.2.00.1103221502180.11798@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54686 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab1CVXEm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 19:04:42 -0400
In-Reply-To: <alpine.DEB.2.00.1103221502180.11798@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I knew you will answer that one :-)

On 3/22/2011 11:08 PM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> On Tue, 22 Mar 2011, Cousson, Benoit wrote:
>
>> On the other hand not every clock belong to a clockdomain, that's wh=
y we
>> have clock without clockdomain on OMAP. A clockdomain is a just grou=
p of
>> IPs that share the same interface clock.
>
> PRCM clockdomains also include functional clocks.  See for example th=
e
> OMAP4 Public TRM Rev. O Section 3.1.1.1.3 "Clock Domain" ('The clockd=
omain
> of CM_B is composed of two clocks: a functional clock (FCLK2) and an
> interface clock (ICLK1)', and also later, 'The PRCM module lets softw=
are
> check the status of the clock domain functional clocks').

True, but that does not change the definition of the clock domain (same=
=20
paragraph):
"A clock domain is a group of modules fed by clock signals controlled b=
y=20
the same clock manager in the PRCM module (see Figure 3-2)."

My point was that a clock domain is related to modules that share some=20
clocks.
So yes, a clock domain will contains modules and their related iclk and=
=20
fclk. But that does not means that every clocks will belong to a=20
clockdomain.
All the non leaf clocks will not have any clock domain since they will=20
not be attached to any module directly.

> Both the TRM and the OMAP4 functional specification clearly link PRCM
> clockdomain idle management to the state of the clockdomain's functio=
nal
> clocks.  See for example OMAP4 Public TRM Rev. O Table 3-11 "Clock Do=
main
> Clock States" ('INACTIVE: ... Every optional functional clock in the =
clock
> domain is gated.')

That just means that each clock that supplies a module must be idled in=
=20
order to allow the clock domain to transition.
The clock domain FSM is using both iclk and fclk state to trigger the=20
domain transition, but that same clock could be used in another clock=20
domain too.

> Beyond the PRCM, the Linux-OMAP clockdomain code is not only concerne=
d
> with PRCM-controllable clockdomains.  It is intended to be a generica=
lly
> useful way to connect clocks to the powerdomain and voltagedomain tha=
t the
> clock exists in, even if there are no explicit PRCM registers associa=
ted
> with the clockdomain.  These "powerdomains" and "voltagedomains" also=
 may
> not be directly PRCM controllable.

In that case, you cannot call that clockdomain anymore since this is no=
t=20
the proper definition used by the PRCM. If you do not have a module, yo=
u=20
cannot have a clockdomain.

OMAP4 partitioning is following this hierarchy: module < clockdomain <=20
powerdomain < voltagedomain < device.
The clocks are not part of the hierarchy and for a good reason, the can=
=20
be shared across the whole device.

> Every clock that is in the Linux-OMAP clock tree should have a clockd=
omain
> associated with it.

Mmm... What domain will you use for sys_clk or 32k_clk? or for any DPLL=
=20
or HS divider?
And what for?

I know that the clockdomain name is confusing, but why do you want to=20
change its definition?

Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
