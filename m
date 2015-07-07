From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2
 and IRQSTATUS_MPU_2 register offsets
Date: Tue, 7 Jul 2015 18:01:16 +0530
Message-ID: <559BC694.1050602@ti.com>
References: <1434954176-9605-1-git-send-email-j-keerthy@ti.com> <1434954176-9605-5-git-send-email-j-keerthy@ti.com> <559BBD38.9070104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <559BBD38.9070104@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com
Cc: galak@codeaurora.org, pawel.moll@arm.com, linux-kernel@vger.kernel.org, paul@pwsan.com, bcousson@baylibre.com, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 07 July 2015 05:21 PM, Tero Kristo wrote:
> On 06/22/2015 09:22 AM, Keerthy wrote:
>> The register offsets of IRQENABLE_MPU_2 and IRQSTATUS_MPU_2 are
>> hardcoded.
>> This makes it difficult to reuse the code for single core SoCs like
>> AM437x.
>
> Single core vs. having two sets of IRQENABLE / IRQSTATUS registers do
> not have any relation to each other. OMAP4+ has two IRQ registers,
> because the number of IRQ events is so large it does not fit into single
> register. Thus, the commit message is somewhat misleading, please fix.

Okay i will make it clearer.

>
>> Hence making it part of omap_prcm_irq_setup structure so that case of
>> single set of IRQ* registers can be handled generically.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   arch/arm/mach-omap2/prcm-common.h |  8 ++++----
>>   arch/arm/mach-omap2/prm3xxx.c     | 20 +++++++++---------
>>   arch/arm/mach-omap2/prm44xx.c     | 43
>> +++++++++++++++++++++------------------
>>   arch/arm/mach-omap2/prm_common.c  |  5 ++---
>>   4 files changed, 39 insertions(+), 37 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/prcm-common.h
>> b/arch/arm/mach-omap2/prcm-common.h
>> index 2e60406..99447e7 100644
>> --- a/arch/arm/mach-omap2/prcm-common.h
>> +++ b/arch/arm/mach-omap2/prcm-common.h
>> @@ -470,8 +470,8 @@ struct omap_prcm_irq {
>>
>>   /**
>>    * struct omap_prcm_irq_setup - PRCM interrupt controller details
>> - * @ack: PRM register offset for the first PRM_IRQSTATUS_MPU register
>> - * @mask: PRM register offset for the first PRM_IRQENABLE_MPU register
>> + * @ack: PRM register offsets for the PRM_IRQSTATUS_MPU registers
>> + * @mask: PRM register offsets for the PRM_IRQENABLE_MPU registers
>>    * @nr_regs: number of PRM_IRQ{STATUS,ENABLE}_MPU* registers
>>    * @nr_irqs: number of entries in the @irqs array
>>    * @irqs: ptr to an array of PRCM interrupt bits (see @nr_irqs)
>> @@ -492,8 +492,8 @@ struct omap_prcm_irq {
>>    * specified in static initializers.
>>    */
>>   struct omap_prcm_irq_setup {
>> -    u16 ack;
>> -    u16 mask;
>> +    u16 ack[2];
>> +    u16 mask[2];
>
> You don't really need two pairs of offsets; in generic case, if we have
> two IRQ registers, the offset between the two is 4, as used elsewhere in
> the code. By keeping the previous struct layout, you can save a few
> bytes of memory, and don't need to touch the omap3 code all over the
> place either.

Okay

>
>>       u16 pm_ctrl;
>>       u8 nr_regs;
>>       u8 nr_irqs;
>> diff --git a/arch/arm/mach-omap2/prm3xxx.c
>> b/arch/arm/mach-omap2/prm3xxx.c
>> index 62680aa..56649b0 100644
>> --- a/arch/arm/mach-omap2/prm3xxx.c
>> +++ b/arch/arm/mach-omap2/prm3xxx.c
>
> <snip>
>
> No need to touch the OMAP3 code, as the offsets are always the default
> ones.
>
>> diff --git a/arch/arm/mach-omap2/prm44xx.c
>> b/arch/arm/mach-omap2/prm44xx.c
>> index 8149e5a..20b547a 100644
>> --- a/arch/arm/mach-omap2/prm44xx.c
>> +++ b/arch/arm/mach-omap2/prm44xx.c
>> @@ -43,8 +43,10 @@ static const struct omap_prcm_irq omap4_prcm_irqs[]
>> = {
>>   };
>>
>>   static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
>> -    .ack            = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
>> -    .mask            = OMAP4_PRM_IRQENABLE_MPU_OFFSET,
>> +    .ack[0]            = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
>> +    .mask[0]        = OMAP4_PRM_IRQENABLE_MPU_OFFSET,
>> +    .ack[1]            = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
>> +    .mask[1]        = OMAP4_PRM_IRQENABLE_MPU_2_OFFSET,
>
> I think you should just keep the single IRQENABLE / IRQSTATUS
> definitions in place, and use +4 addressing where applicable. Having an
> array of the ack + mask definitions is kind of ugly.

Okay.

>
>>       .pm_ctrl        = OMAP4_PRM_IO_PMCTRL_OFFSET,
>>       .nr_regs        = 2,
>>       .irqs            = omap4_prcm_irqs,
>> @@ -217,11 +219,11 @@ static inline u32 _read_pending_irq_reg(u16
>> irqen_offs, u16 irqst_offs)
>>    */
>>   static void omap44xx_prm_read_pending_irqs(unsigned long *events)
>>   {
>> -    events[0] = _read_pending_irq_reg(OMAP4_PRM_IRQENABLE_MPU_OFFSET,
>> -                      OMAP4_PRM_IRQSTATUS_MPU_OFFSET);
>> +    int i;
>>
>> -    events[1] = _read_pending_irq_reg(OMAP4_PRM_IRQENABLE_MPU_2_OFFSET,
>> -                      OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET);
>> +    for (i = 0; i < omap4_prcm_irq_setup.nr_regs; i++)
>> +        events[i] = _read_pending_irq_reg(omap4_prcm_irq_setup.mask[i],
>> +                          omap4_prcm_irq_setup.ack[i]);
>
> ... change to mask + i * 4 / ack + i * 4.

got it.

>
>>   }
>>
>>   /**
>> @@ -251,17 +253,16 @@ static void omap44xx_prm_ocp_barrier(void)
>>    */
>>   static void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
>>   {
>> -    saved_mask[0] =
>> -        omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
>> -                    OMAP4_PRM_IRQENABLE_MPU_OFFSET);
>> -    saved_mask[1] =
>> -        omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
>> -                    OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
>> +    int i;
>>
>> -    omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
>> -                 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
>> -    omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
>> -                 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
>> +    for (i = 0; i < omap4_prcm_irq_setup.nr_regs; i++) {
>> +        saved_mask[i] =
>> +            omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
>> +                        omap4_prcm_irq_setup.mask[i]);
>> +
>> +        omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
>> +                     omap4_prcm_irq_setup.mask[i]);
>
> ditto.
>
>> +    }
>>
>>       /* OCP barrier */
>>       omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
>> @@ -280,10 +281,12 @@ static void
>> omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
>>    */
>>   static void omap44xx_prm_restore_irqen(u32 *saved_mask)
>>   {
>> -    omap4_prm_write_inst_reg(saved_mask[0],
>> OMAP4430_PRM_OCP_SOCKET_INST,
>> -                 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
>> -    omap4_prm_write_inst_reg(saved_mask[1],
>> OMAP4430_PRM_OCP_SOCKET_INST,
>> -                 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
>> +    int i;
>> +
>> +    for (i = 0; i < omap4_prcm_irq_setup.nr_regs; i++)
>> +        omap4_prm_write_inst_reg(saved_mask[i],
>> +                     OMAP4430_PRM_OCP_SOCKET_INST,
>> +                     omap4_prcm_irq_setup.mask[i]);
>
> ...and here.
>
>>   }
>>
>>   /**
>> diff --git a/arch/arm/mach-omap2/prm_common.c
>> b/arch/arm/mach-omap2/prm_common.c
>> index 7add799..10ef0da 100644
>> --- a/arch/arm/mach-omap2/prm_common.c
>> +++ b/arch/arm/mach-omap2/prm_common.c
>> @@ -281,7 +281,6 @@ int omap_prcm_register_chain_handler(struct
>> omap_prcm_irq_setup *irq_setup)
>>           pr_err("PRCM: already initialized; won't reinitialize\n");
>>           return -EINVAL;
>>       }
>> -
>
> This change is against the coding style.
>

I will fix this. Thanks for catching this.

>>       if (nr_regs > OMAP_PRCM_MAX_NR_PENDING_REG) {
>>           pr_err("PRCM: nr_regs too large\n");
>>           return -EINVAL;
>> @@ -339,8 +338,8 @@ int omap_prcm_register_chain_handler(struct
>> omap_prcm_irq_setup *irq_setup)
>>           ct->chip.irq_mask = irq_gc_mask_clr_bit;
>>           ct->chip.irq_unmask = irq_gc_mask_set_bit;
>>
>> -        ct->regs.ack = irq_setup->ack + i * 4;
>> -        ct->regs.mask = irq_setup->mask + i * 4;
>> +        ct->regs.ack = irq_setup->ack[i];
>> +        ct->regs.mask = irq_setup->mask[i];
>
> ... and you can drop this change.
>
>>
>>           irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
>>           prcm_irq_chips[i] = gc;
>>
>
