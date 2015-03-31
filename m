From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/7] dmaengine: of_dma: Support for DMA routers
Date: Tue, 31 Mar 2015 19:48:03 +0300
Message-ID: <551ACFC3.5020003@ti.com>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com> <1427459213-14611-2-git-send-email-peter.ujfalusi@ti.com> <201503280244.46961.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46562 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbbCaQuJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 12:50:09 -0400
In-Reply-To: <201503280244.46961.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com

On 03/28/2015 03:44 AM, Arnd Bergmann wrote:
> On Friday 27 March 2015, Peter Ujfalusi wrote:
>> +Required property:
>> +- dma-device:          phandle of the DMA controller. The router is=
 modifying
>> +                       the DMA requests for this controller.
>=20
> This property seems rather specific to the case at hand, I would expe=
ct that
> one might also see routers like this that are connected to more than =
one
> dma-device, so maybe make it a list?

Yeah, it is intentional from my part.
In dra7xx family we actually have two DMA controllers: sDMA and eDMA. T=
hey
both have identical crossbar up front but you can not choose the DMA re=
quest
to be routed to either eDMA or sDMA. They are always routed to both and=
 in the
crossbar you select which signal goes to which DMA request of the given
controller.
At the moment I was not aware of different designs (current and future)=
, but
it might be possible that a design you described might surface at some =
point.
=46or sure, the list will complicate things quite a bit it might requir=
e
different API and callbacks at the end. I need to think about this how =
it is
going to work best.

> It might also be better to name this as 'dma-controllers' or 'dma-mas=
ters',
> as it is not entirely obvious (without referencing the binding docume=
nt)
> whether a dma device refers to the slave or the master.

I think the 'dma-masters' sounds much better.

PS: I'm out of office this week so do not expect v4 before mid next wee=
k.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
