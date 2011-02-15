From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
Date: Tue, 15 Feb 2011 14:29:23 +0000
Message-ID: <20110215142923.GC11199@n2100.arm.linux.org.uk>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4D5A81D8.2080800@ru.mvista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: tony@atomide.com, David Cohen <dacohen@gmail.com>, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 15, 2011 at 04:38:32PM +0300, Sergei Shtylyov wrote:
>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
>> index 14ee686..4244a07 100644
>> --- a/arch/arm/mach-omap2/iommu2.c
>> +++ b/arch/arm/mach-omap2/iommu2.c
>> @@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>   	da = iommu_read_reg(obj, MMU_FAULT_AD);
>>   	*ra = da;
>>
>> -	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
>> +	dev_dbg(obj->dev, "%s:\tda:%08x ", __func__, da);
>
>    Note that dev_dbg() will only print something if either DEBUG or  
> CONFIG_DYNAMIC_DEBUG are defined...
>
>>
>>   	for (i = 0; i<  ARRAY_SIZE(err_msg); i++) {
>>   		if (stat & (1<<  i))
>> -			printk("%s ", err_msg[i]);
>> +			printk(KERN_DEBUG "%s ", err_msg[i]);
>
>    ... unlike printk(KERN_DEBUG...). You probably want to use pr_debug() instead.

No - this isn't starting a new line.  pr_cont() here.

>>   	}
>> -	printk("\n");
>> +	printk(KERN_DEBUG "\n");
>
>    Here too... Although wait, it should be KERN_CONT instead! Debug 
> levels are only attributed to the whole lines.

And pr_cont() here too.  If you care about using KERN_CONT which is
just a static marker to allow automated printk level checking easier.
