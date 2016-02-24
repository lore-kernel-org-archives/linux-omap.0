From: Lokesh Vutla <a0131933@ti.com>
Subject: Re: [PATCH v4 1/3] ARM: hwmod: RTC: Add lock and unlock functions
Date: Wed, 24 Feb 2016 14:59:32 +0530
Message-ID: <56CD77FC.8030103@ti.com>
References: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
 <1454650952-20154-2-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1602072209460.2182@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1602072209460.2182@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Monday 08 February 2016 03:54 AM, Paul Walmsley wrote:
> Hi Lokesh
> 
> I apologize for the delay.
> 
> A few comments:
> 
> On Fri, 5 Feb 2016, Lokesh Vutla wrote:
> 
>> RTC IP have kicker feature which prevents spurious writes to its registers.
>> In order to write into any of the RTC registers, KICK values has to be
>> written to KICK registers.
>> Introduce omap_hwmod_rtc_unlock/lock functions, which  writes into these
>> KICK registers inorder to lock and unlock RTC registers.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
> 
> ...
> 
>> +/**
>> + * omap_rtc_wait_not_busy - Wait for the RTC BUSY flag
>> + * @oh: struct omap_hwmod *
>> + *
>> + * For updating certain RTC registers, the MPU must wait
>> + * for the BUSY status in OMAP_RTC_STATUS_REG to become zero.
>> + * Once the BUSY status is zero, there is a 15-?s access
> 
> Probably best just to write out "microseconds" or "us" here to avoid the 
> high-bit character problem.
> 
>> + * period in which the MPU can program.
>> + */
>> +static void omap_rtc_wait_not_busy(struct omap_hwmod *oh)
>> +{
>> +	int i;
>> +
>> +	/* BUSY may stay active for 1/32768 second (~30 usec) */
>> +	omap_test_timeout(omap_hwmod_read(oh, OMAP_RTC_STATUS_REG)
>> +			  & OMAP_RTC_STATUS_REG, OMAP_RTC_MAX_READY_TIME, i);
> 
> This test looks bogus.  Shouldn't it AND the register value with 
> OMAP_RTC_STATUS_BUSY?  Right now the code is AND-ing with 0x44, which 
> doesn't include the BUSY bit.  So I guess the tests that you mentioned in 
> the first message of the series don't cover the BUSY case?
> 
>> +	/* now we have ~15 usec to read/write various registers */
>> +}
>> +
>> +/**
>> + * omap_hwmod_rtc_unlock - Unlock the Kicker mechanism.
>> + * @oh: struct omap_hwmod *
>> + *
>> + * RTC IP have kicker feature. This prevents spurious writes to its registers.
>> + * In order to write into any of the RTC registers, KICK values has te be
>> + * written in respective KICK registers. This is needed for hwmod to write into
>> + * sysconfig register.
>> + */
>> +void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
>> +{
>> +	local_irq_disable();
>> +	omap_rtc_wait_not_busy(oh);
>> +	omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
>> +	omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
>> +	local_irq_enable();
> 
> Finally, could you ask the IP block maintainer to confirm the 
> interpretation that, for any STATUS_REG read where the BUSY bit is 0, that 
> we are guaranteed to have at least 15 microseconds from that point in time 
> to access the IP block?  It appears to be this way from my reading of the 
> TRM; but to me, the phrasing is not explicit.  Another interpretation 
> could be that the BUSY bit reflects the IP block's current status.  If 
> this latter case is true, then to ensure that the IP block accesses 
> complete inside the access window, we'll either need to test the BUSY bit 
> after the writes to ensure that it is still 0, and otherwise repeat the 
> busy test and writes; or we'll need to wait for a 0->1 BUSY transition 
> before we wait for a 1->0 BUSY transition.

As per the HW folks, once SW sees the transistion from 1->0, it is
guaranteed that SW has 15.25 us to do all the write transactions for all
the TC updates.

Also as per TRM, in RTC there are three types of registers:
-> TC registers and TC alarm registers:
-> General registers
-> Compensation registers.

MPU must wait for the BUSY bit for accessing the TC registers and  MPU
can access the general registers at any point of time. SYSCONFIG, KICK
registers comes under general registers. Since hwmod modifies only the
sysconfig register, this omap_rtc_wait_not_busy() is not required here.
We can directly write into sysconfig and KICK registers. Does this sound
fine to you?
Shall I resend this patch without omap_rtc_wait_not_busy()?


Thanks and regards,
Lokesh


> 
>> +}
>> +
>> +/**
>> + * omap_hwmod_rtc_lock - Lock the Kicker mechanism.
>> + * @oh: struct omap_hwmod *
>> + *
>> + * RTC IP have kicker feature. This prevents spurious writes to its registers.
>> + * Once the RTC registers are written, KICK mechanism needs to be locked,
>> + * in order to prevent any spurious writes. This function locks back the RTC
>> + * registers once hwmod completes its write into sysconfig register.
>> + */
>> +void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
>> +{
>> +	local_irq_disable();
>> +	omap_rtc_wait_not_busy(oh);
>> +	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
>> +	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
>> +	local_irq_enable();
>> +}
>> -- 
>> 2.1.4
>>
> 
> 
> - Paul
> 
