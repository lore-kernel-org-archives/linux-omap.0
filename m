From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V2 10/19] irqchip: crossbar: DRA7: Fix unused crossbar
 list
Date: Thu, 12 Jun 2014 18:51:08 +0530
Message-ID: <5399A944.40000@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com> <1402574007-13987-11-git-send-email-r.sricharan@ti.com> <20140612131600.GW8664@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140612131600.GW8664@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

Hi Jason,

On Thursday 12 June 2014 06:46 PM, Jason Cooper wrote:
> On Thu, Jun 12, 2014 at 05:23:18PM +0530, Sricharan R wrote:
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> On DRA7 compatible IRQ crossbar, IRQ 10 default mapped to L3_APP_IRQ,
>> IRQ133 is default mapped to NMI pin, 139 and 140 crossbars are
>> unused(not routed). Mark these as unused crossbar IRQs.
>>
>> Technical Reference Manual documentation update expected
>> DRA72x-TRMINC00067 is being used to track the update.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Reported-by: Sricharan R <r.sricharan@ti.com>
>> Reported-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  drivers/irqchip/irq-crossbar.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
>> index 7d4db07..42a2e62 100644
>> --- a/drivers/irqchip/irq-crossbar.c
>> +++ b/drivers/irqchip/irq-crossbar.c
>> @@ -253,8 +253,8 @@ err1:
>>  	return -ENOMEM;
>>  }
>>  
>> -/* irq number 10 cannot be used because of hw bug */
>> -static int dra_irqs_unused[] = { 10 };
>> +/* irq number 10,133,139 and 140 cannot be used because of hw bug */
>> +static int dra_irqs_unused[] = { 10 , 133, 139, 140 };
> 
> see my earlier comment regarding a potential dts property.
> 
Ok, if dts would be the better approach then I can change this.

Regards,
 Sricharan
