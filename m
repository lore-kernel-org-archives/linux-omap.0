From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V2 09/19] irqchip: crossbar: fix kerneldoc warning
Date: Thu, 12 Jun 2014 19:09:31 +0530
Message-ID: <5399AD93.40601@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com> <1402574007-13987-10-git-send-email-r.sricharan@ti.com> <20140612131434.GV8664@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140612131434.GV8664@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

Hi Jason,

On Thursday 12 June 2014 06:44 PM, Jason Cooper wrote:
> On Thu, Jun 12, 2014 at 05:23:17PM +0530, Sricharan R wrote:
>> From: Nishanth Menon <nm@ti.com>
>>
>> kernel doc style is wrong in code. fix it to squelch
>> kerneldoc warnings:
> 
> I would re-word the above to mention that we need to add missing
> properties for kerneldoc (@write, @safemap), and we're doing some
> cleanup of harmless warnings while we are here.
> 
 Ok, will do this.

>> Warning(drivers/irqchip/irq-crossbar.c:27): missing initial short description on line:
>>  * struct crossbar_device: crossbar device description
>> Info(drivers/irqchip/irq-crossbar.c:27): Scanning doc for struct
>> Warning(drivers/irqchip/irq-crossbar.c:39): No description found for parameter 'write'
>> Warning(drivers/irqchip/irq-crossbar.c:42): missing initial short description on line:
>>  * struct crossbar_data: Platform specific data
>> Info(drivers/irqchip/irq-crossbar.c:42): Scanning doc for struct
>> Warning(drivers/irqchip/irq-crossbar.c:50): No description found for parameter 'safe_map'
>> 4 warnings
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  drivers/irqchip/irq-crossbar.c |    7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
>> index 58790d4..7d4db07 100644
>> --- a/drivers/irqchip/irq-crossbar.c
>> +++ b/drivers/irqchip/irq-crossbar.c
>> @@ -23,11 +23,13 @@
>>  #define IRQ_SKIP	-3
>>  #define GIC_IRQ_START	32
>>  
>> -/*
>> +/**
>> + * struct crossbar_device - crossbar device descriptio
> 
> s/descriptio/description/
 Ok, will correct.

Regards,
 Sricharan
