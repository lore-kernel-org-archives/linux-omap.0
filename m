From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: EDMA oftree entry for AM335x
Date: Thu, 11 Jun 2015 17:53:47 +0300
Message-ID: <5579A0FB.6000800@ti.com>
References: <20150504064323.GU15254@pengutronix.de> <20150504141103.GD24469@atomide.com> <5548CB54.1040302@ti.com> <20150505145828.GB21061@atomide.com> <5549F95B.8090905@ti.com> <20150506143951.GG21061@atomide.com> <20150608105957.GT26523@pengutronix.de> <20150610051037.GA2740@atomide.com> <55781BDA.9020705@ti.com> <20150611141330.GC2740@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51651 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbbFKOye (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jun 2015 10:54:34 -0400
In-Reply-To: <20150611141330.GC2740@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, =?windows-1252?Q?Beno=EE?= =?windows-1252?Q?t_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/11/2015 05:13 PM, Tony Lindgren wrote:
>> Well, I was not.
>> But I'm now ;)
>=20
> OK good to hear!

I have a working version now, but...
Due to the scale of the needed changes we would need different compatib=
le
string for the single hwmod version.
The Linux driver itself works fine if I don't change the compatible
(ti,edma3). Boots fine with the old and new DTS file, but the edma sect=
ions
are not compatible anymore IMO.

I don't want to rush in a new binding for it since I want to make sure =
that
the new binding will be usable when I got the chance to rewrite the edm=
a stack
(get rid of the code from arch/arm/common/edma.c)

We have the xbar support embedded in the current edma driver - not the =
same
crossbar as we have in dra7, it is a bit more problematic (very problem=
atic).
Currently we do not have support for more than one TPCC via DT, legacy =
boot on
SoC with more than one TPCC is also going to be interesting.

Since we will need new bindings for the edma when we fix the multiple h=
wmods I
think we should allow us some time to think about it a bit and come up =
with
something which will work in the future and it is nice to look at it at=
 the
same time ;)

And I will be away for one week...
If you want I can send an RFC/DO NOT MERGE series with the code I have
tomorrow in case you want to see it, but I think it will look quite a b=
it
different at the end.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
