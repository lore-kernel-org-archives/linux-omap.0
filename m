From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: EDMA oftree entry for AM335x
Date: Wed, 10 Jun 2015 14:13:30 +0300
Message-ID: <55781BDA.9020705@ti.com>
References: <20150504064323.GU15254@pengutronix.de> <20150504141103.GD24469@atomide.com> <5548CB54.1040302@ti.com> <20150505145828.GB21061@atomide.com> <5549F95B.8090905@ti.com> <20150506143951.GG21061@atomide.com> <20150608105957.GT26523@pengutronix.de> <20150610051037.GA2740@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54030 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbbFJLRI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jun 2015 07:17:08 -0400
In-Reply-To: <20150610051037.GA2740@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Robert Schwebel <r.schwebel@pengutronix.de>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/10/2015 08:10 AM, Tony Lindgren wrote:
> * Robert Schwebel <r.schwebel@pengutronix.de> [150608 04:01]:
>> On Wed, May 06, 2015 at 07:39:52AM -0700, Tony Lindgren wrote:
>>>
>>> That may never happen considering that davinci is using it too.. It=
's
>>> best to not count on that happening anytime soon at least.
>>
>> So my current understanding is that we have the situation that the
>> kernel warns about the oftree being wrong, but isn't able to handle =
an
>> oftree that would be right.
>>
>> Shouldn't the warning being added when the kernel driver supports th=
at
>> new mechanism?
>=20
> This particular driver is broken and it needs to be fixed properly.
> =20
>> I had a warning free mainline kernel without patches on my customer
>> hardware before, so this smells a bit like a regression ... :-/
>=20
> Yes sorry I'm not patching away the warning as it does not fix the
> driver. Peter, I assume you are busy fixing it?

Well, I was not.
But I'm now ;)

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
