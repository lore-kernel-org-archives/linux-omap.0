From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Tue, 26 Mar 2013 10:52:26 +0100
Message-ID: <51516FDA.5040801@ti.com>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <alpine.DEB.2.01.1303221023070.7975@pmeerw.net> <514C2E5E.2040909@gmail.com> <alpine.DEB.2.01.1303221348250.7975@pmeerw.net> <514C56EA.7020304@ti.com> <20130322163506.GL30923@n2100.arm.linux.org.uk> <51504581.10400@ti.com> <20130325171540.GO30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54185 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab3CZJyb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 05:54:31 -0400
In-Reply-To: <20130325171540.GO30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

On 03/25/2013 06:15 PM, Russell King - ARM Linux wrote:
> What I'm talking about is having a physical channel scheduler in plac=
e
> across DMA engines which have more virtual channels than physical
> channels.  Some DMA engine implementations sort of do this already (e=
g,
> AMBA PL08x stuff) but again, every driver implements this kind of thi=
ng
> by themselves.

I see. So basically you want to grab a DMA channel for the upcoming tra=
nsfer
at issue_pending time. This is fine, but we do not need to have taskelt=
 to do
this. If we do it as the amba-pl08x.c does it it is fine. AMBA does not=
 use
tasklet and OMAP should not do that either.
We might need to lift the code out from the legacy DMA code (and remove=
 the
code) from arch/arm/plat-omap/dma.c...

>>> I guess we could keep the tasklet, but mark the audio DMA channels =
as
>>> "pre-reserved" and arrange for pre-reserved channels to avoid the
>>> tasklet, rather than throwing the tasklet out completely.
>>
>> Not sure if we really want to pre-reserve the DMA channels for audio=
:
>> on OMAP3 we have 5 McBSP -> 10 DMA channels
>> on OMAP4 we have 4 McBSP, one McPDM, one DMIC and one McASP + we hav=
e the
>> AESS/ABE -> 8 + 2 + 1 + 1 + 8 (AESS/ABE).
>> Do we really want to pre-allocate DMA channel for all of these?
>=20
> Well, at the moment we are effectively pre-allocating a physical chan=
nel
> for every virtual channel - as each virtual channel gets allocated.  =
So,
> the physical channels are currently being permanently tied up.
>=20
> With a scheduling core, we need some way to dynamically reallocate
> physical channels depending on the workload presented on the virtual
> channels.  However, as we're still having to deal with the OMAP priva=
te
> DMA API, we can only change physical channels from task (or tasklet)
> context.
>=20
> So, the only way to have audio channels in a condition where they can
> be startable immediately in issue_pending is to avoid the tasklet, an=
d
> the only way to avoid that tasklet (where that tasklet eventually
> becomes the channel scheduler) is to have pre-allocated the physical
> channel.

The issue has been noticed in audio but it can also affect other driver=
s as
well. It might be only latency/throughput issue for others, while audio=
 suffer
with the tasklet based DMA start.

>> I have a patch which removes the tasklet from omap-dma.c and it is w=
orking
>> fine on my systems (OMAP3 Zoom2, BeagleBoard, OMAP4 PandBoard, OMAP4=
 Blaze).
>=20
> I'm sure you have, but that breaks the future direction of the driver
> to dynamically allocate the physical channels.
>=20
> Had TI not effectively terminated my contract, I might be further for=
ward
> with this.  As things are, lack of contract and such like, all the OM=
AP
> work I was doing got shelved around Christmas time.  If you stop payi=
ng
> people, they generally stop doing useful work for you...

Yeah, that is bad. If it makes you feel a bit better just look up in go=
ogle:
"Texas Instruments France"
Hint: I'm in France...

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
