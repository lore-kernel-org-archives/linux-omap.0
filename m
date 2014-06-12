From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V2 11/19] irqchip: crossbar: fix memory leak incase of
 invalid entry
Date: Thu, 12 Jun 2014 19:07:34 +0530
Message-ID: <5399AD1E.9010801@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com> <1402574007-13987-12-git-send-email-r.sricharan@ti.com> <20140612132023.GX8664@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140612132023.GX8664@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

Hi Jason,

On Thursday 12 June 2014 06:50 PM, Jason Cooper wrote:
> On Thu, Jun 12, 2014 at 05:23:19PM +0530, Sricharan R wrote:
>> From: Nishanth Menon <nm@ti.com>
>>
>> When the provided unused skip list entry is greater than max irqs
>> possible, we go to err3, but we fail to free register_offsets,
>> should have returned to err4 instead which ensures that allocated
> 
> s/returned/jumped/
 ok, will correct.

> 
>> register_offsets are freed as well.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  drivers/irqchip/irq-crossbar.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
>> index 42a2e62..fea3e5d 100644
>> --- a/drivers/irqchip/irq-crossbar.c
>> +++ b/drivers/irqchip/irq-crossbar.c
>> @@ -225,7 +225,7 @@ static int __init crossbar_of_init(struct device_node *node,
>>  
>>  			if (entry > max) {
>>  				pr_err("Invalid skip entry\n");
>> -				goto err3;
>> +				goto err4;
> 
> This would be a good opportunity to reduce the possibility of future
> errors.  Please consider renaming err{1,2,3,4} to something more
> recognizable while you are here.
> 
  Ok, this is done as a part of patch#13.

Regards,
 Sricharan 
