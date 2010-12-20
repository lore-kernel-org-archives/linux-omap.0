From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 1/7] OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all
Date: Mon, 20 Dec 2010 11:19:14 +0100
Message-ID: <AANLkTim1MKkHkyi9c2+R8c8Nj-C8RWVeDsyOarime5et@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-2-git-send-email-nm@ti.com>
	<9ad7cd880801fcc6f63435ec2c8dcd3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37233 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab0LTKTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:19:15 -0500
Received: by qwa26 with SMTP id 26so2621038qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:19:14 -0800 (PST)
In-Reply-To: <9ad7cd880801fcc6f63435ec2c8dcd3d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

On Mon, Dec 20, 2010 at 7:43 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Nishanth Menon
>> Sent: Sunday, December 19, 2010 4:24 AM
>> To: linux-omap; linux-arm
>> Cc: Jean Pihet; Kevin; Tony
>> Subject: [PATCH v4 1/7] OMAP3: PM: Update clean_l2 to use
>> v7_flush_dcache_all
>>
>> From: Richard Woodruff <r-woodruff2@ti.com>
>>
>> Analysis in TI kernel with ETM showed that using cache mapped flush
>> in kernel instead of SO mapped flush cost drops by 65% (3.39mS down
>> to 1.17mS) for clean_l2 which is used during sleep sequences.
>> Overall:
>> =A0 =A0 =A0 - speed up
>> =A0 =A0 =A0 - unfortunately there isn't a good alternative flush met=
hod today
>> =A0 =A0 =A0 - code reduction and less maintenance and potential bug =
in
>> =A0 =A0 =A0 =A0 unmaintained code
>>
>> This also fixes the bug with the clean_l2 function usage.
>>
>> Reported-by: Tony Lindgren <tony@atomide.com>
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>>
>> [nm@ti.com: ported rkw's proposal to 2.6.37-rc2]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
>> ---
>> (no change in this series, posted for completeness)
>> v2: https://patchwork.kernel.org/patch/365222/
>> v1: http://marc.info/?l=3Dlinux-omap&m=3D129013171325210&w=3D2
>> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 79
> ++++++----------------------------
>> ----
>> =A01 files changed, 13 insertions(+), 66 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
>> omap2/sleep34xx.S
>> index 2fb205a..2c20fcf 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -520,72 +520,17 @@ clean_caches:
>> =A0 =A0 =A0 cmp =A0 =A0 r9, #1 /* Check whether L2 inval is required=
 or not*/
>> =A0 =A0 =A0 bne =A0 =A0 skip_l2_inval
>> =A0clean_l2:
>> - =A0 =A0 /* read clidr */
>> - =A0 =A0 mrc =A0 =A0 p15, 1, r0, c0, c0, 1
>> - =A0 =A0 /* extract loc from clidr */
>> - =A0 =A0 ands =A0 =A0r3, r0, #0x7000000
>> - =A0 =A0 /* left align loc bit field */
>> - =A0 =A0 mov =A0 =A0 r3, r3, lsr #23
>> - =A0 =A0 /* if loc is 0, then no need to clean */
>> - =A0 =A0 beq =A0 =A0 finished
>> - =A0 =A0 /* start clean at cache level 0 */
>> - =A0 =A0 mov =A0 =A0 r10, #0
>> -loop1:
>> - =A0 =A0 /* work out 3x current cache level */
>> - =A0 =A0 add =A0 =A0 r2, r10, r10, lsr #1
>> - =A0 =A0 /* extract cache type bits from clidr*/
>> - =A0 =A0 mov =A0 =A0 r1, r0, lsr r2
>> - =A0 =A0 /* mask of the bits for current cache only */
>> - =A0 =A0 and =A0 =A0 r1, r1, #7
>> - =A0 =A0 /* see what cache we have at this level */
>> - =A0 =A0 cmp =A0 =A0 r1, #2
>> - =A0 =A0 /* skip if no cache, or just i-cache */
>> - =A0 =A0 blt =A0 =A0 skip
>> - =A0 =A0 /* select current cache level in cssr */
>> - =A0 =A0 mcr =A0 =A0 p15, 2, r10, c0, c0, 0
>> - =A0 =A0 /* isb to sych the new cssr&csidr */
>> - =A0 =A0 isb
>> - =A0 =A0 /* read the new csidr */
>> - =A0 =A0 mrc =A0 =A0 p15, 1, r1, c0, c0, 0
>> - =A0 =A0 /* extract the length of the cache lines */
>> - =A0 =A0 and =A0 =A0 r2, r1, #7
>> - =A0 =A0 /* add 4 (line length offset) */
>> - =A0 =A0 add =A0 =A0 r2, r2, #4
>> - =A0 =A0 ldr =A0 =A0 r4, assoc_mask
>> - =A0 =A0 /* find maximum number on the way size */
>> - =A0 =A0 ands =A0 =A0r4, r4, r1, lsr #3
>> - =A0 =A0 /* find bit position of way size increment */
>> - =A0 =A0 clz =A0 =A0 r5, r4
>> - =A0 =A0 ldr =A0 =A0 r7, numset_mask
>> - =A0 =A0 /* extract max number of the index size*/
>> - =A0 =A0 ands =A0 =A0r7, r7, r1, lsr #13
>> -loop2:
>> - =A0 =A0 mov =A0 =A0 r9, r4
>> - =A0 =A0 /* create working copy of max way size*/
>> -loop3:
>> - =A0 =A0 /* factor way and cache number into r11 */
>> - =A0 =A0 orr =A0 =A0 r11, r10, r9, lsl r5
>> - =A0 =A0 /* factor index number into r11 */
>> - =A0 =A0 orr =A0 =A0 r11, r11, r7, lsl r2
>> - =A0 =A0 /*clean & invalidate by set/way */
>> - =A0 =A0 mcr =A0 =A0 p15, 0, r11, c7, c10, 2
>> - =A0 =A0 /* decrement the way*/
>> - =A0 =A0 subs =A0 =A0r9, r9, #1
>> - =A0 =A0 bge =A0 =A0 loop3
>> - =A0 =A0 /*decrement the index */
>> - =A0 =A0 subs =A0 =A0r7, r7, #1
>> - =A0 =A0 bge =A0 =A0 loop2
>> -skip:
>> - =A0 =A0 add =A0 =A0 r10, r10, #2
>> - =A0 =A0 /* increment cache number */
>> - =A0 =A0 cmp =A0 =A0 r3, r10
>> - =A0 =A0 bgt =A0 =A0 loop1
>> -finished:
>> - =A0 =A0 /*swith back to cache level 0 */
>> - =A0 =A0 mov =A0 =A0 r10, #0
>> - =A0 =A0 /* select current cache level in cssr */
>> - =A0 =A0 mcr =A0 =A0 p15, 2, r10, c0, c0, 0
>> - =A0 =A0 isb
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Jump out to kernel flush routine
>> + =A0 =A0 =A0* =A0- reuse that code is better
>> + =A0 =A0 =A0* =A0- it executes in a cached space so is faster than =
refetch per-
>> block
>> + =A0 =A0 =A0* =A0- should be faster and will change with kernel
>> + =A0 =A0 =A0* =A0- 'might' have to copy address, load and jump to i=
t
> Would be good to clarify that this is needed to maintain the 'lr'
> when code is executed from SRAM
>
Agree on that. Some comments have been posted at
http://marc.info/?l=3Dlinux-omap&m=3D129016170719489&w=3D2.

>> + =A0 =A0 =A0*/
>> + =A0 =A0 ldr r1, kernel_flush
>> + =A0 =A0 mov lr, pc
>> + =A0 =A0 bx =A0r1
>> +
>> =A0skip_l2_inval:
>> =A0 =A0 =A0 /* Data memory barrier and Data sync barrier */
>> =A0 =A0 =A0 mov =A0 =A0 r1, #0
>> @@ -668,5 +613,7 @@ cache_pred_disable_mask:
>> =A0 =A0 =A0 .word =A0 0xFFFFE7FB
>> =A0control_stat:
>> =A0 =A0 =A0 .word =A0 CONTROL_STAT
>> +kernel_flush:
>> + =A0 =A0 .word v7_flush_dcache_all
>> =A0ENTRY(omap34xx_cpu_suspend_sz)
>> =A0 =A0 =A0 .word =A0 . - omap34xx_cpu_suspend
>
> O.w
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Jean Pihet <j-pihet@ti.com>

>
>> --
>> 1.6.3.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
