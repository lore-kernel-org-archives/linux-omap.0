From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
Date: Mon, 5 Apr 2010 20:49:00 +0530
Message-ID: <p2i618f0c911004050819u9af37b57ob399a52006f40017@mail.gmail.com>
References: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C4C33347@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f199.google.com ([209.85.223.199]:36357 "EHLO
	mail-iw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab0DEPTB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 11:19:01 -0400
Received: by iwn37 with SMTP id 37so80898iwn.15
        for <linux-omap@vger.kernel.org>; Mon, 05 Apr 2010 08:19:01 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4C33347@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, Tony Lindgren <tony@atomide.com>

On Mon, Apr 5, 2010 at 7:56 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> Venkat,
>> -----Original Message-----
>> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of S,=
 Venkatraman
>> Sent: Friday, April 02, 2010 5:05 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Gopinath, Thara; Tony Lindgren; Shilimkar, Santosh
>> Subject: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
>>
>> DMA errata for special end of block programming is applicable
>> only for OMAP2430 & OMAP3430 ES1.0.
>> This patch does the necessary checks before the workaround
>> is applied. Tested on 3430 SDP
>>
>> Signed-off-by: Thara Gopinath <thara@ti.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>> =A0arch/arm/plat-omap/dma.c | =A0 22 ++++++++++++++--------
>> =A01 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index 2ab224c..ef965ac 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -1663,14 +1663,18 @@ int omap_stop_dma_chain_transfers(int chain_=
id)
>> =A0 =A0 =A0 channels =3D dma_linked_lch[chain_id].linked_dmach_q;
>>
>> =A0 =A0 =A0 /*
>> - =A0 =A0 =A0* DMA Errata:
>> - =A0 =A0 =A0* Special programming model needed to disable DMA befor=
e end of block
>> + =A0 =A0 =A0* DMA Errata: i88
>> + =A0 =A0 =A0* Special programming model needed
>> + =A0 =A0 =A0* to disable DMA before end of block
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 sys_cf =3D dma_read(OCP_SYSCONFIG);
>> - =A0 =A0 l =3D sys_cf;
>> - =A0 =A0 /* Middle mode reg set no Standby */
>> - =A0 =A0 l &=3D ~((1 << 12)|(1 << 13));
>> - =A0 =A0 dma_write(l, OCP_SYSCONFIG);
>> + =A0 =A0 if (cpu_is_omap2430() || (cpu_is_omap3430() &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430=
_REV_ES1_0)) {
> Since the Errata is applicable only for "omap2430" and
> "OMAP3430 ES1.0", below should be enough, isn't it ?
>
> if (cpu_is_omap2430() || omap_rev() =3D=3D OMAP3430_REV_ES1_0))

Yup.. Looks simpler. I will update.

>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D sys_cf;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Middle mode reg set no Standby */
>> + =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~((1 << 12)|(1 << 13));
>> + =A0 =A0 =A0 =A0 =A0 =A0 dma_write(l, OCP_SYSCONFIG);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_li=
nked; i++) {
>>
>> @@ -1689,8 +1693,10 @@ int omap_stop_dma_chain_transfers(int chain_i=
d)
>> =A0 =A0 =A0 /* Reset the Queue pointers */
>> =A0 =A0 =A0 OMAP_DMA_CHAIN_QINIT(chain_id);
>>
>> - =A0 =A0 /* Errata - put in the old value */
>> - =A0 =A0 dma_write(sys_cf, OCP_SYSCONFIG);
>> + =A0 =A0 /* Errata: put back the old value */
>> + =A0 =A0 if (cpu_is_omap2430() || (cpu_is_omap3430() &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430=
_REV_ES1_0))
> Same as above comment.
>> + =A0 =A0 =A0 =A0 =A0 =A0 dma_write(sys_cf, OCP_SYSCONFIG);
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
> After fixing above two, the patch is fine with me.

Thanks, I take that as ack ? :-)
Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
