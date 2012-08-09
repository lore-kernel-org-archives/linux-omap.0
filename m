From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH 07/11] ASoC: omap-mcbsp: Sidetone: Use SIDLE
 bits in SYSCONFIG register to select noidle mode
Date: Thu, 09 Aug 2012 10:05:50 +0300
Message-ID: <5023614E.3030308@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com> <1344417101-5015-8-git-send-email-peter.ujfalusi@ti.com> <5022E46A.4010909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:34967 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754866Ab2HIHFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 03:05:49 -0400
Received: by obbup19 with SMTP id up19so223711obb.12
        for <linux-omap@vger.kernel.org>; Thu, 09 Aug 2012 00:05:47 -0700 (PDT)
In-Reply-To: <5022E46A.4010909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ricardo,

On 08/09/2012 01:12 AM, Ricardo Neri wrote:
> Is this another case in which it is required to change the idle-mode =
on a
> per-use-case basis? In the past I was trying to do the same with HDMI=
 [1]. In
> that case it was decided to add the HWMOD_SWSUP_SIDLE to hwmod data w=
ith the
> drawback of using no-idle/force-idle rather than smart-idle[2][3].

This only concerns use case on OMAP3 when the sidetone is in use. In al=
l other
use cases we want to use smart-idle (music playback, FM TX/RX, etc).
The main problem here is that the sidetone block have broken sidle line=
, it
can not prevent McBSP iclk to be gated.
The sidetone block is using the ICLK of the McBSP port (OMAP3 has ST bl=
ock
attached to McBSP2 and 3 ports only).


> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60226.h=
tml
> [2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70463.h=
tml
> [3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70653.h=
tml
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   sound/soc/omap/mcbsp.c |   18 ++++++++++++++----
>>   sound/soc/omap/mcbsp.h |    1 +
>>   2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
>> index c870023..e008898 100644
>> --- a/sound/soc/omap/mcbsp.c
>> +++ b/sound/soc/omap/mcbsp.c
>> @@ -257,8 +257,15 @@ static void omap_st_on(struct omap_mcbsp *mcbsp=
)
>>   {
>>       unsigned int w;
>>
>> -    if (mcbsp->pdata->enable_st_clock)
>> -        mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
>> +    /*
>> +     * Sidetone uses McBSP ICLK - which must not idle when sidetone=
s
>> +     * are enabled or sidetones start sounding ugly.
>> +     */
>> +    w =3D MCBSP_READ(mcbsp, SYSCON);
>> +    mcbsp->st_data->mcbsp_sidle =3D (w >> 3) & 0x3;
>> +    w &=3D ~SIDLEMODE(0x3);
>> +    w |=3D SIDLEMODE(0x1);
>> +    MCBSP_WRITE(mcbsp, SYSCON, w);
>=20
> Wouldn't this create a mismatch between the SYSCONFIG register and Mc=
BSP
> omap_hwmod._sysc_cache?

We modify the bits runtime (if the ST is enabled), after the hwmod alre=
ady
configured the McBSP port to s-idle. We change the McBSP port's s-idle =
mode
back to it's original before pm_runtime_put().

Previously we did the same thing in PRCM level which was as ugly as thi=
s
workaround with the penalty of a callback function to mach-omap2 since =
we can
only got access to PRCM register API there.

> Perhaps this could be done with a future omap_hwmod API?

But there's no such an API and I'm not aware any ongoing effort to have=
 one.
Still the issue mostly remains since we need to modify other block's s-=
idle
mode. If sidetone block is enabled we need to change the McBSP port's s=
-idle
mode to no-idle.

In most of the use cases the McBSP need to be in smart-idle mode since =
it
provides significant power saving.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
