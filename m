From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx devices
Date: Fri, 8 Oct 2010 09:22:10 +0200
Message-ID: <4CAEC6A2.7000809@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CF13384@dbde02.ent.ti.com> <201010061017.13908.peter.ujfalusi@nokia.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56710 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab0JHHW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 03:22:26 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kamat, Nishant" <nskamat@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Girdwood, Liam" <x0135381@ti.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

Hi Charu,

On 10/8/2010 8:20 AM, Varadarajan, Charulatha wrote:
>
>
>> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
>> Sent: Wednesday, October 06, 2010 12:47 PM
>> To: Varadarajan, Charulatha
>> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org; Kamat,
>> Nishant; Datta, Shubhrajyoti; Basak, Partha; Girdwood, Liam;
>> jhnikula@gmail.com; broonie@opensource.wolfsonmicro.com; ABRAHAM, KI=
SHON
>> VIJAY
>> Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx
>> devices
>>
>> Hello,
>
> Thanks for the quick response.
>
>>
>> On Wednesday 06 October 2010 10:01:28 ext Varadarajan, Charulatha wr=
ote:
>>> This patch series is targeted to implement mcbsp driver in
>>> hwmod way and to make use of pm_runtime APIs.
>>>
>>> This patch series is tested on OMAP3&  4 and yet to be tested
>>> on OMAP2.
>>>
>>> There are few clarifications required so that the next patch series
>>> can be implemented after aligning.
>>>
>>> 1. Audio layer is making use of mcbsp and it's dma base addresses a=
nd
>>> is closely coupled with omap-mcbsp.
>>> This can be handled either by
>>> a. providing an API with which Audio layer can get these addresses.
>>> (or)
>>> b. move the plat-omap/mcbsp.c and mach-omap2/mcbsp.c to sound/soc/o=
map/
>>> [1]
>>>
>>> Option (a) would only be a workaround to handle the situation. As
>>> audio is the only user for mcbsp, option (b) is better. If option(b=
)
>>> is agreed upon, the same can be addressed on top of the mcbsp hwmod
>>> series.
>>
>> it is true that at the moment only audio is using the McBSP ports, b=
ut
>> McBSP is
>> really flexible, it can run for example in SPI mode, and it can be
>> configured to
>> use other serial protocols.
>
> Yes.
>
>> I would go with option c.
>> Since ASoC is moving to multi-component (the conversion is already i=
n
>> linux-
>> next), this means that the sound/soc/omap/omap-mcbsp, omap-pcm drive=
rs are
>> platform drivers.
>> So if the plat-omap/mcbsp would register the platform device for McB=
SP
>> clients
>> (we have only ASoC client at the moment), and use platform data to p=
ass
>> the
>> needed information to the McBSP client driver, than we do not need n=
ew API.
>
> Sorry I am confused.
>
> With hwmod implementation, there is a device register code for mcbsp
> devices in mach-omap2/mcbsp.c and a probe in plat-omap/mcbsp.c. The b=
ase
> address, dma info are not part of pdata and are available to the driv=
er
> only after probe. I do not understand how the multi-component design =
in
> ASOC can avoid the new API.
>
> Also with this multi-component approach in ASOC, two device
> registrations happens for a single mcbsp device with two different
> rames ("omap-mcbsp-dai.id"&  "omap-mcbsp.id"). Please explain if this
> what is expected?
>
>> We still need to modify the ASoC drivers to make use of this platfor=
m data,
>> but
>> at least we are going to keep the door open for others to use the Mc=
BSP
>> ports
>> for other than audio.
>
> Agreed. But the current omap-mcbsp driver cannot work standalone for
> OMAP3/4 due to the issues stated below:
> 1. omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access McBS=
P
> registers as 16-bit. But in OMAP3/4, McBSP registers (DRR_REG and DXR=
_REG)
> are limited to 32-bit data accesses and hence poll mode would not wor=
k [x].
> 2. DMA transfers would also not work as it requires a patch similar t=
o [y].
>
> Patches [x]&  [y] were rejected as there are no users other than asoc=
=2E
> If it is not agreed to move omap-mcbsp driver to asoc layer, we need =
to
> get the omap-mcbsp driver working as a standalone driver. Otherwise i=
t
> is of no use keeping the mcbsp driver in plat-omap.
>
> Once [x]&  [y] patches are upstreamed, audio layer needs to be modifi=
ed
> to make use of omap-mcbsp APIs rather than Audio layer calling dma
> APIs directly to transfer data.
>
> Coming back to the original question. Either we need to fix the broke=
n
> legacy mcbsp driver or move the omap-mcbsp driver completely to asoc
> layer. What do you say?
>
> [x] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19531.h=
tml
> [y] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04085.h=
tml
>>
>>> 2. Sidetone feature is available only in OMAP3 (McBSP2&3) which has
>>> different base address and sys configs compared to it's mcbsp port.
>>> Hence the mcbsp is considered as a single device with two hwmods
>>> for McBSP2&3 devices in OMAP3.
>>
>> Sounds fair enough.
>
> Thanks.
>
>>
>>> 3. Autoidle needs to be disabled for sidetone before enabling the
>> sidetone
>>> feature. There was a design proposed by Kishon [2] to add an API in
>> hwmod
>>> to modify the autoidle bit but was not agreed upon. How do we handl=
e
>> this
>>> situation where the device has to disable or enable the autoidle bi=
t at
>>> runtime?
>>
>> Yeah, this is really annoying problem. The McBSP ST should block aut=
oidle
>> from
>> McBSP side, but it does not.
>> If you can not get through the proposed API, we should consider to s=
witch
>> the
>> corresponding McBSP port to NoIdle, when the ST is in use (and resto=
re the
>> idle
>> mode, when the ST has been disabled).
>> When McBSP is in NoIdle the interface clock is not going to be gated=
, so
>> ST
>> block will be running without a problem (ST needs the iface clock fo=
r
>> operation)
>>
>> What do you think?
>
> I think it might not be possible to handle this, as the clocks are th=
e same for ST and mcbsp port. pm_runtime APIs are not called during ST =
enable/disable as clocks are already enabled while enabling mcbsp port.=
 Hence the idle bit change cannot happen even if the oh->flags are modi=
fied runtime during ST enable/disable.

This is mainly because of the 2 hwmods for 1 device implementation,=20
which make perfect sense in theory, but because of that bug, becomes=20
tricky to handle it in the fmwk.

=46YI, SDMA and MUSB are as well requiring some sysconfig change during=
=20
runtime. So a couple of API will have to be implemented.
I guess we don't have the choice. Now, it is just a matter of having th=
e=20
right implementation.
I'll comment on that patch directly.

Benoit


>
>>>
>>> [1] https://patchwork.kernel.org/patch/225582/
>>> [2] https://patchwork.kernel.org/patch/134371/
>>>
>>> We would resend the same patch series by including alsa mailing lis=
t
>>> (alsa-devel@alsa-project.org)
>>>
>>> <<snip>>
>>
>> --
>> P=E9ter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
