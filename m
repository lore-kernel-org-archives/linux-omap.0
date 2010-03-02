From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP: DMA: Add API for setting channel dest addr
Date: Tue, 02 Mar 2010 09:16:45 -0800
Message-ID: <87635e1w5e.fsf@deeprootsystems.com>
References: <1267536973-31296-1-git-send-email-manjugk@ti.com>
	<618f0c911003020551p3af75870u16270b9b9ecb7d94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:52807 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0CBRQw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 12:16:52 -0500
Received: by qw-out-2122.google.com with SMTP id 5so88121qwd.37
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 09:16:51 -0800 (PST)
In-Reply-To: <618f0c911003020551p3af75870u16270b9b9ecb7d94@mail.gmail.com> (Venkatraman S.'s message of "Tue\, 2 Mar 2010 19\:21\:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Manjunatha GK <manjugk@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Venkatraman S <svenkatr@ti.com> writes:

> Manjunath,
>
> On Tue, Mar 2, 2010 at 7:06 PM, Manjunatha GK <manjugk@ti.com> wrote:
>> The new API - omap_set_dma_dst_pos(int lch, int value) is added
>> for setting channel destination address in CPC/CDAC register
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: S, Venkatraman <svenkatr@ti.com>
>> Signed-off-by: Manjunatha GK <manjugk@ti.com>
>> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/plat-omap/dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 ++++=
+++++++++++++
>> =A0arch/arm/plat-omap/include/plat/dma.h | =A0 =A01 +
>> =A02 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index 2ab224c..c73f11a 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -1109,6 +1109,23 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
>> =A0}
>> =A0EXPORT_SYMBOL(omap_get_dma_dst_pos);
>>
>> +/**
>> + * omap_set_dma_dst_pos() - Set DMA channel destination address
>> + * @arg1: =A0lch =A0 =A0 =A0DMA logical channel number
>> + * @arg2: =A0value =A0 =A0Value to write into CDAC register
>> + *
>> + * Writes "value" into the register CPC/CDAC
>> + */
>> +void omap_set_dma_dst_pos(int lch, int value)
>> +{
>> + =A0 =A0 =A0 if (cpu_is_omap15xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(value, CPC(lch));
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(value, CDAC(lch));
>> +
>> +}
>> +EXPORT_SYMBOL(omap_set_dma_dst_pos);
>> +
>> =A0int omap_get_dma_active_status(int lch)
>> =A0{
>> =A0 =A0 =A0 =A0return (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN) !=3D 0;
>> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-o=
map/include/plat/dma.h
>> index 02232ca..3b6e43e 100644
>> --- a/arch/arm/plat-omap/include/plat/dma.h
>> +++ b/arch/arm/plat-omap/include/plat/dma.h
>> @@ -509,6 +509,7 @@ extern int omap_set_dma_callback(int lch,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *data);
>> =A0extern dma_addr_t omap_get_dma_src_pos(int lch);
>> =A0extern dma_addr_t omap_get_dma_dst_pos(int lch);
>> +extern void omap_set_dma_dst_pos(int lch, int value);
>> =A0extern void omap_clear_dma(int lch);
>> =A0extern int omap_get_dma_active_status(int lch);
>> =A0extern int omap_dma_running(void);
>> --
>  CDAC is not the destination address, as the API seems to suggest.
> CDSA (Channel Destination Start Address) is.
>
> CDAC is a running counter of the current transfer.
> I propose to update the omap_start_dma to reset CDAC to 0 always.

I agree with Venkat.  I think having it reset for every transfer
by default is the right way to handle this.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
