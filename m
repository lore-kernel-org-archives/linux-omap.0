From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 11 May 2012 09:52:59 -0500
Message-ID: <4FAD27CB.5060102@ti.com>
References: <4FA9588E.9020906@ti.com> <87sjfal65t.fsf@ti.com>
 <4FAA4DB9.8060504@ti.com> <4FAAB1A3.9040806@ti.com> <4FAAC549.6010206@ti.com>
 <4FAAE564.6040708@ti.com> <20120510084422.GB27276@mudshark.cambridge.arm.com>
 <4FAC0F05.3060803@ti.com> <20120511122547.GE17453@mudshark.cambridge.arm.com>
 <4FAD1865.70003@ti.com> <20120511134920.GC2626@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120511134920.GC2626@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson,
 Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Will,

On 05/11/2012 08:49 AM, Will Deacon wrote:
> On Fri, May 11, 2012 at 02:47:17PM +0100, Jon Hunter wrote:
>> On 05/11/2012 07:25 AM, Will Deacon wrote:
>>> I figured I may as well take perf for a spin and see how I got on. The good
>>> news is that the hwmod bits all seem to work as before and the correct IRQs
>>> are requested:
>>>
>>> root@florentine-pogen:~# cat /proc/interrupts
>>>            CPU0       CPU1
>>>  29:      44527      17916       GIC  twd
>>>  33:          0          0       GIC  arm-pmu
>>>  34:          0          0       GIC  arm-pmu
>>>
>>> But, unfortunately, as you can see from the above, I just can't persuade them
>>> to fire. The PMU counters do tick, but they happily increment through zero
>>> without us realising. I retested with my perf/omap4 branch to make sure my
>>> board is ok, and the irqs do fire there.
>>>
>>> Any ideas?
>>
>> Do you disable OMAP2/3 support in the kernel config, so that CPU_HAS_PMU
>> is enabled?
> 
> I enabled OMAP3 debug peripherals, so I selected CPU_HAS_PMU that way.

I tried the same (make omap2plus_defconfig and enabled the above
option), and I do see the interrupts firing on both 4430 and 4460...

/ # cat /proc/interrupts
           CPU0       CPU1
 29:       1023        404       GIC  twd
 33:        401          0       GIC  arm-pmu
 34:          0        441       GIC  arm-pmu


What is your kernel commit ID that you applied the patches on top of?

What board are you using? Blaze, panda, etc, and is it 4430 or 4460?

Cheers
Jon
