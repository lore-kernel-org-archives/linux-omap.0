From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 5/6] ARM: OMAP3: update cpuidle latency and threshold figures
Date: Wed, 18 Apr 2012 17:48:57 +0200
Message-ID: <CAORVsuUmskZxgS+S+cu-NqN4OdBK2xBO7yS+8NegaoVL_X5P9w@mail.gmail.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
	<1334756720-29166-6-git-send-email-j-pihet@ti.com>
	<CANOLnOOmshFXKK73qY+rY7yak3hjwR7i=TCShv-GdMEwOvRdLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51166 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2DRPs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 11:48:58 -0400
Received: by vcqp1 with SMTP id p1so4967828vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 08:48:58 -0700 (PDT)
In-Reply-To: <CANOLnOOmshFXKK73qY+rY7yak3hjwR7i=TCShv-GdMEwOvRdLw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Wed, Apr 18, 2012 at 5:18 PM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
> On Wed, Apr 18, 2012 at 4:45 PM, =C2=A0<jean.pihet@newoldbits.com> wr=
ote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Update the data from the measurements performed at HW and SW levels.
>>
>> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_=
Measurement
>> for a detailed explanation on where are the numbers coming from.
>>
>> ...
>> ToDo:
>> - Measure the wake-up latencies for all power domains for OMAP3
>> - Correct some numbers when sys_clkreq and sys_offmode are supported
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/cpuidle34xx.c | =C2=A0 52 ++++++++++++++++=
+++++++-------------
>> =C2=A01 files changed, 33 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2=
/cpuidle34xx.c
>> index 2f95cfc..e406d7b 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -39,27 +39,41 @@
> <snip>
>> =C2=A0static struct cpuidle_params cpuidle_params_table[] =3D {
>> - =C2=A0 =C2=A0 =C2=A0 /* C1 */
>> - =C2=A0 =C2=A0 =C2=A0 {2 + 2, 5, 1},
>> - =C2=A0 =C2=A0 =C2=A0 /* C2 */
>> - =C2=A0 =C2=A0 =C2=A0 {10 + 10, 30, 1},
>> - =C2=A0 =C2=A0 =C2=A0 /* C3 */
>> - =C2=A0 =C2=A0 =C2=A0 {50 + 50, 300, 1},
>> - =C2=A0 =C2=A0 =C2=A0 /* C4 */
>> - =C2=A0 =C2=A0 =C2=A0 {1500 + 1800, 4000, 1},
>> - =C2=A0 =C2=A0 =C2=A0 /* C5 */
>> - =C2=A0 =C2=A0 =C2=A0 {2500 + 7500, 12000, 1},
>> - =C2=A0 =C2=A0 =C2=A0 /* C6 */
>> - =C2=A0 =C2=A0 =C2=A0 {3000 + 8500, 15000, 1},
>> - =C2=A0 =C2=A0 =C2=A0 /* C7 */
>> - =C2=A0 =C2=A0 =C2=A0 {10000 + 30000, 300000, 1},
>> + =C2=A0 =C2=A0 =C2=A0 /* C1 . MPU WFI + Core active */
>> + =C2=A0 =C2=A0 =C2=A0 {73 + 78, 152, 1},
>> + =C2=A0 =C2=A0 =C2=A0 /* C2 . MPU WFI + Core inactive */
>> + =C2=A0 =C2=A0 =C2=A0 {165 + 88, 345, 1},
>> + =C2=A0 =C2=A0 =C2=A0 /* C3 . MPU CSWR + Core inactive */
>> + =C2=A0 =C2=A0 =C2=A0 {163 + 182, 345, 1},
>> + =C2=A0 =C2=A0 =C2=A0 /* C4 . MPU OFF + Core inactive */
>> + =C2=A0 =C2=A0 =C2=A0 {2852 + 605, 150000, 1},
>> + =C2=A0 =C2=A0 =C2=A0 /* C5 . MPU RET + Core RET */
>> + =C2=A0 =C2=A0 =C2=A0 {800 + 366, 2120, 1},
>> + =C2=A0 =C2=A0 =C2=A0 /* C6 . MPU OFF + Core RET */
>> + =C2=A0 =C2=A0 =C2=A0 {4080 + 801, 215000, 1},
>> + =C2=A0 =C2=A0 =C2=A0 /* C7 . MPU OFF + Core OFF */
>> + =C2=A0 =C2=A0 =C2=A0 {4300 + 13000, 215000, 1},
>> =C2=A0};
>
> These (C1 at least) seem to look quite a bit better than what we see =
here:
> http://marc.info/?t=3D133375282700004&r=3D1&w=3D2
> according to that wiki log, some of those measurements are from 2010,
> I wonder if that still matches today's code well.
Those figures are for the HW part of the low power transitions
assuming that the SW overhead (in omap_sram_idle) is minimal, which
seems to not be true anymore.
I need to measure the latencies again on the latest SW.

Thanks,
Jean

>
>
> --
> Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
