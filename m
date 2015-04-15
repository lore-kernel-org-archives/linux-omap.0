From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 1/8] dmaengine: of_dma: Support for DMA routers
Date: Wed, 15 Apr 2015 11:36:55 +0300
Message-ID: <552E2327.4050203@ti.com>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com> <1428498892-28471-2-git-send-email-peter.ujfalusi@ti.com> <20150408154251.GE26727@lukather> <5526375A.7090708@ti.com> <20150410074058.GN26727@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34645 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbbDOIhs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 04:37:48 -0400
In-Reply-To: <20150410074058.GN26727@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de

On 04/10/2015 10:40 AM, Maxime Ripard wrote:
> On Thu, Apr 09, 2015 at 11:24:58AM +0300, Peter Ujfalusi wrote:
>> On 04/08/2015 06:42 PM, Maxime Ripard wrote:
>>>> ---
>>>>  Documentation/devicetree/bindings/dma/dma.txt | 28 +++++++++
>>>>  drivers/dma/dmaengine.c                       |  7 +++
>>>>  drivers/dma/of-dma.c                          | 86 ++++++++++++++=
+++++++++++++
>>>>  include/linux/dmaengine.h                     | 17 ++++++
>>>>  include/linux/of_dma.h                        | 21 +++++++
>>>>  5 files changed, 159 insertions(+)
>>>
>>> Can that be moved to a header / C file of its own?
>>>
>>> There's a lot of various code already in dmaengine.h and dmaengine.=
c,
>>> it would be really great to avoid adding more random stuff in there=
=2E
>>
>> This patch adds the core support for DMA signal routers. It adds
>> fairly small amount of generic code to the core to achieve this. I
>> don't think it would be better to create let's say of-dma-router.c
>> and .h just for this and export functions from of-dma.c to be used
>> outside of the file.
>=20
> A lot of "a fairly small amount of generic code" has been added over
> time, and we ended up in the current situation.

So that we have fairly good dmaengine core? If people using the code, t=
hey
will eventually fix things, add new features. When dmaengine came to ex=
istence
we did not had DMA routers, now that the SoCs are getting even more
complicated they are coming (in case of DRA7x, it is already here).

> It's a bit sad if we just end up moving this just after it got merged=
,
> especially if it doesn't have any kind of dependency on any of the
> core function.

This provides core functionality to handle DMA signal routers via DT. I=
t does
depend on the DT DMA parsing core code as it integrates with it.

>> The signal router is not a DMA device, it is represented in the devi=
ce tree
>> and the code will do the needed translation, which is transparent fo=
r the DMA
>> clients and also for the DMA controllers. Neither should know about =
the signal
>> router.
>=20
> Yeah, I got that part, and we do agree on that.
>=20
>> Similar translation can be done for ACPI.
>=20
> But this argument is exactly why it shouldn't be tied to the device
> tree. We wouldn't like to re-do all this all over again for ACPI,
> while your code seems to just handle that very well, wouldn't we?

The data structures used by the DT and ACPI layers are different. Under=
neath
DT and ACPI we do not have enough information on how to handle the DMA =
signal
router. If you happen to have multiple DMA controllers in the system fo=
r
example how would you tell how the routers are connected?
In DRA7x we have sDMA and eDMA controllers. Both have similar DMA cross=
bar. It
is only possible to know the hierarchy of the components via DT. I'm su=
re this
is the same for ACPI. You take away the ACPI layer and you loose the to=
pology
of the system.
Probably with huge architectural change in the dmaengine core (and thus=
 with
all the drivers) this might be possible, but I don't think that is a va=
lid
route to take.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
