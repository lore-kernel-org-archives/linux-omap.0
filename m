From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 01/13] OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all
Date: Fri, 19 Nov 2010 11:15:03 +0100
Message-ID: <AANLkTikoMbJsOA-1D+mKhXj+VaFKmcq_j7metq3OcyZ5@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-2-git-send-email-nm@ti.com>
	<AANLkTin8tpn+4J_aYDc2MVhJiqvLa=+2dcow_ENewG-k@mail.gmail.com>
	<20101119095740.GV26003@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58057 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0KSKPD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 05:15:03 -0500
Received: by qyk7 with SMTP id 7so65643qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 02:15:03 -0800 (PST)
In-Reply-To: <20101119095740.GV26003@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Hi Peter,

On Fri, Nov 19, 2010 at 10:57 AM, Peter 'p2' De Schrijver
<peter.de-schrijver@nokia.com> wrote:
> On Fri, Nov 19, 2010 at 10:46:19AM +0100, ext Jean Pihet wrote:
>> On Fri, Nov 19, 2010 at 2:54 AM, Nishanth Menon <nm@ti.com> wrote:
>> > From: Richard Woodruff <r-woodruff2@ti.com>
>> >
>> > Analysis in TI kernel with ETM showed that using cache mapped flus=
h
>> > in kernel instead of SO mapped flush cost drops by 65% (3.39mS dow=
n
>> > to 1.17mS) for clean_l2 which is used during sleep sequences.
>> > Overall:
>> > =A0 =A0 =A0 =A0- speed up
>> > =A0 =A0 =A0 =A0- unfortunately there isn't a good alternative flus=
h method today
>> > =A0 =A0 =A0 =A0- code reduction and less maintenance and potential=
 bug in
>> > =A0 =A0 =A0 =A0 =A0unmaintained code
>> >
>> > This also fixes the bug with the clean_l2 function usage.
>> >
>> > Reported-by: Tony Lindgren <tony@atomide.com>
>> >
>> > [nm@ti.com: ported rkw's proposal to 2.6.37-rc2]
>> > Signed-off-by: Nishanth Menon <nm@ti.com>
>> > Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
>> > ---
>> >
>> > Side note: just dcache needs to be flushed based on inputs from TI=
 internal team
>> >
>> > =A0arch/arm/mach-omap2/sleep34xx.S | =A0 79 ++++++----------------=
----------------
>> > =A01 files changed, 13 insertions(+), 66 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2=
/sleep34xx.S
>> > index 2fb205a..8f207b2 100644
>> > --- a/arch/arm/mach-omap2/sleep34xx.S
>> > +++ b/arch/arm/mach-omap2/sleep34xx.S
>> > @@ -520,72 +520,17 @@ clean_caches:
>> > =A0 =A0 =A0 =A0cmp =A0 =A0 r9, #1 /* Check whether L2 inval is req=
uired or not*/
>> > =A0 =A0 =A0 =A0bne =A0 =A0 skip_l2_inval
>> > =A0clean_l2:
>> > - =A0 =A0 =A0 /* read clidr */
>> > - =A0 =A0 =A0 mrc =A0 =A0 p15, 1, r0, c0, c0, 1
>> > - =A0 =A0 =A0 /* extract loc from clidr */
>> > - =A0 =A0 =A0 ands =A0 =A0r3, r0, #0x7000000
>> > - =A0 =A0 =A0 /* left align loc bit field */
>> > - =A0 =A0 =A0 mov =A0 =A0 r3, r3, lsr #23
>> > - =A0 =A0 =A0 /* if loc is 0, then no need to clean */
>> > - =A0 =A0 =A0 beq =A0 =A0 finished
>> > - =A0 =A0 =A0 /* start clean at cache level 0 */
>> > - =A0 =A0 =A0 mov =A0 =A0 r10, #0
>> > -loop1:
>> > - =A0 =A0 =A0 /* work out 3x current cache level */
>> > - =A0 =A0 =A0 add =A0 =A0 r2, r10, r10, lsr #1
>> > - =A0 =A0 =A0 /* extract cache type bits from clidr*/
>> > - =A0 =A0 =A0 mov =A0 =A0 r1, r0, lsr r2
>> > - =A0 =A0 =A0 /* mask of the bits for current cache only */
>> > - =A0 =A0 =A0 and =A0 =A0 r1, r1, #7
>> > - =A0 =A0 =A0 /* see what cache we have at this level */
>> > - =A0 =A0 =A0 cmp =A0 =A0 r1, #2
>> > - =A0 =A0 =A0 /* skip if no cache, or just i-cache */
>> > - =A0 =A0 =A0 blt =A0 =A0 skip
>> > - =A0 =A0 =A0 /* select current cache level in cssr */
>> > - =A0 =A0 =A0 mcr =A0 =A0 p15, 2, r10, c0, c0, 0
>> > - =A0 =A0 =A0 /* isb to sych the new cssr&csidr */
>> > - =A0 =A0 =A0 isb
>> > - =A0 =A0 =A0 /* read the new csidr */
>> > - =A0 =A0 =A0 mrc =A0 =A0 p15, 1, r1, c0, c0, 0
>> > - =A0 =A0 =A0 /* extract the length of the cache lines */
>> > - =A0 =A0 =A0 and =A0 =A0 r2, r1, #7
>> > - =A0 =A0 =A0 /* add 4 (line length offset) */
>> > - =A0 =A0 =A0 add =A0 =A0 r2, r2, #4
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, assoc_mask
>> > - =A0 =A0 =A0 /* find maximum number on the way size */
>> > - =A0 =A0 =A0 ands =A0 =A0r4, r4, r1, lsr #3
>> > - =A0 =A0 =A0 /* find bit position of way size increment */
>> > - =A0 =A0 =A0 clz =A0 =A0 r5, r4
>> > - =A0 =A0 =A0 ldr =A0 =A0 r7, numset_mask
>> > - =A0 =A0 =A0 /* extract max number of the index size*/
>> > - =A0 =A0 =A0 ands =A0 =A0r7, r7, r1, lsr #13
>> > -loop2:
>> > - =A0 =A0 =A0 mov =A0 =A0 r9, r4
>> > - =A0 =A0 =A0 /* create working copy of max way size*/
>> > -loop3:
>> > - =A0 =A0 =A0 /* factor way and cache number into r11 */
>> > - =A0 =A0 =A0 orr =A0 =A0 r11, r10, r9, lsl r5
>> > - =A0 =A0 =A0 /* factor index number into r11 */
>> > - =A0 =A0 =A0 orr =A0 =A0 r11, r11, r7, lsl r2
>> > - =A0 =A0 =A0 /*clean & invalidate by set/way */
>> > - =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r11, c7, c10, 2
>> > - =A0 =A0 =A0 /* decrement the way*/
>> > - =A0 =A0 =A0 subs =A0 =A0r9, r9, #1
>> > - =A0 =A0 =A0 bge =A0 =A0 loop3
>> > - =A0 =A0 =A0 /*decrement the index */
>> > - =A0 =A0 =A0 subs =A0 =A0r7, r7, #1
>> > - =A0 =A0 =A0 bge =A0 =A0 loop2
>> > -skip:
>> > - =A0 =A0 =A0 add =A0 =A0 r10, r10, #2
>> > - =A0 =A0 =A0 /* increment cache number */
>> > - =A0 =A0 =A0 cmp =A0 =A0 r3, r10
>> > - =A0 =A0 =A0 bgt =A0 =A0 loop1
>> > -finished:
>> > - =A0 =A0 =A0 /*swith back to cache level 0 */
>> > - =A0 =A0 =A0 mov =A0 =A0 r10, #0
>> > - =A0 =A0 =A0 /* select current cache level in cssr */
>> > - =A0 =A0 =A0 mcr =A0 =A0 p15, 2, r10, c0, c0, 0
>> > - =A0 =A0 =A0 isb
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* jump out to kernel flush routine
>> > + =A0 =A0 =A0 =A0* =A0- resue that code is better
>> Typo: 'reuse'
>>
>> > + =A0 =A0 =A0 =A0* =A0- it executes in a cached space so is faster=
 than refetch per-block
>> > + =A0 =A0 =A0 =A0* =A0- should be faster and will change with kern=
el
>> > + =A0 =A0 =A0 =A0* =A0- 'might' have to copy address, load and jum=
p to it
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 ldr r1, kernel_flush
>> > + =A0 =A0 =A0 mov lr, pc
>> > + =A0 =A0 =A0 bx =A0r1
>> It is simpler and more efficient to use:
>> =A0 =A0 =A0 =A0 =A0 =A0 bl v7_flush_dcache_all
>
> This doesn't work from SRAM though, because the linker will generate =
a
> PC relative branch which is wrong if the code is moved to SRAM at
> runtime. So the original version needs to stay :)

Correct! My version now runs from DDR, this explains that!

>
> Cheers,
>
> Peter.
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
