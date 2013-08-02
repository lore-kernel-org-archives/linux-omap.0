From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
Date: Fri, 2 Aug 2013 08:32:02 -0400
Message-ID: <51FBA6C2.5090702@ti.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
 <20130802095350.GI2465@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130802095350.GI2465@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Friday 02 August 2013 05:53 AM, Will Deacon wrote:
> On Thu, Aug 01, 2013 at 07:17:13PM +0100, Santosh Shilimkar wrote:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> The generic code is well equipped to differentiate between
>> SMP and UP configurations.However, there are some devices which
>> use Cortex-A9 MP core IP with 1 CPU as configuration. To let
>> these SOCs to co-exist in a CONFIG_SMP=y build by leveraging
>> the SMP_ON_UP support, we need to additionally check the
>> number the cores in Cortex-A9 MPCore configuration. Without
>> such a check in place, the startup code tries to execute
>> ALT_SMP() set of instructions which lead to CPU faults.
>>
>> The issue was spotted on TI's Aegis device and this patch
>> makes now the device work with omap2plus_defconfig which
>> enables SMP by default. The change is kept limited to only
>> Cortex-A9 MPCore detection code.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>>
>> Acked-by: Sricharan R <r.sricharan@ti.com>
>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/kernel/head.S |   18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
>> index 9cf6063..4924b11 100644
>> --- a/arch/arm/kernel/head.S
>> +++ b/arch/arm/kernel/head.S
>> @@ -486,7 +486,23 @@ __fixup_smp:
>>  	mrc	p15, 0, r0, c0, c0, 5	@ read MPIDR
>>  	and	r0, r0, #0xc0000000	@ multiprocessing extensions and
>>  	teq	r0, #0x80000000		@ not part of a uniprocessor system?
>> -	moveq	pc, lr			@ yes, assume SMP
>> +	bne    __fixup_smp_on_up	@ no, assume UP
>> +
>> +	@ Core indicates it is SMP.  Check for Aegis SOC where a single
>> +	@ Cortex-A9 CPU is present but SMP operations fault.
>> +	mov	r4, #0x41000000
>> +	orr	r4, r4, #0x0000c000
>> +	orr	r4, r4, #0x00000090
>> +	teq	r3, r4			@ Check for ARM Cortex-A9
>> +	movne	pc, lr			@ Not ARM Cortex-A9,
>> +
>> +	mrc	p15, 4, r0, c15, c0	@ get SCU base address
>> +	teq	r0, #0x0		@ '0' on actual UP A9 hardware
>> +	beq	__fixup_smp_on_up	@ So its an A9 UP
> 
> What if somebody builds an MP A9 with the private peripheral base address at
> 0x0?
> 
Good point though we at least haven't seen one yet on the kernel lists.
Any other way to avoid A9 UP case proceeding to the actual address 0
read which might be anything on a SOC.

Regards,
Santosh
