From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Wed, 6 Jun 2012 09:56:34 +0200
Message-ID: <4FCF0D32.1030403@ti.com>
References: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com> <4FC4C4FA.1070403@ti.com> <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com> <alpine.DEB.2.00.1206051737000.30737@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40210 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab2FFH4m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jun 2012 03:56:42 -0400
In-Reply-To: <alpine.DEB.2.00.1206051737000.30737@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>

On 6/6/2012 2:28 AM, Paul Walmsley wrote:
> Hello Beno=EEt
>
> On Tue, 5 Jun 2012, Paul Walmsley wrote:
>
>> On Tue, 29 May 2012, Cousson, Benoit wrote:
>>
>>> So in fact, I'm wondering if a new flag is needed. We can potential=
ly
>>> apply that if idlemodes =3D=3D (SIDLE_FORCE | SIDLE_NO).
>>>
>>> We need to check which IP will have that to ensure that does not ad=
d
>>> any side-effects.
>>
>> I guess that means me :-)
>
> I looked at a few TRMs.  Based on that incomplete survey, the above
> behavior would probably work for existing chips.
>
> But it seems perverse to assume that it is generally safe to set an I=
P
> block to force-idle while it's being used.  That seems really depende=
nt on
> the IP block's integration.

Not really, because this behavior is implemented in the IP itself. The=20
point is the this IP is so dumb that force_idle =3D smart_idle. There i=
s=20
not reason to delay the idle_ack since this IP does not do any internal=
=20
processing. That's probably why it was not implemented in the HW.

> So in terms of a general fix, the flag approach seems safest to me in=
 the
> long run.

Well, for the long run we can expect the HW to be fixed, so since we do=
=20
have only one IP with that and we can detect that with the current=20
flags, I still do not think it is needed.

> The other advantage of using a flag is that it indicates that this is=
 a
> hardware workaround; something that it would be nice to fix in future
> chips.

Yeah, I'm still not convinced, but it is not a big deal either so it is=
=20
up to you.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
