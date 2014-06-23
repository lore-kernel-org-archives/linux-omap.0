From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V3 16/16] irqchip: crossbar: allow for quirky hardware
 with direct hardwiring of GIC
Date: Mon, 23 Jun 2014 12:52:44 +0530
Message-ID: <53A7D5C4.6090201@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com> <1402917796-31574-17-git-send-email-r.sricharan@ti.com> <20140621025723.GF21711@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140621025723.GF21711@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de, joe@perches.com
List-Id: linux-omap@vger.kernel.org

Hi Jason,

On Saturday 21 June 2014 08:27 AM, Jason Cooper wrote:
> On Mon, Jun 16, 2014 at 04:53:16PM +0530, Sricharan R wrote:
>> From: Nishanth Menon <nm@ti.com>
>>
>> On certain platforms such as DRA7, SPIs 0, 1, 2, 3, 5, 6, 10, 131,
>> 132, 133 are direct wired to hardware blocks bypassing crossbar.
>> This quirky implementation is *NOT* supposed to be the expectation
>> of crossbar hardware usage. However, these are already marked in our
>> description of the hardware with SKIP and RESERVED where appropriate.
>>
>> Unfortunately, we need to be able to refer to these hardwired IRQs.
>> So, to request these, crossbar driver can use the existing information
>> from it's table that these SKIP/RESERVED maps are direct wired sources
>> and generic allocation/programming of crossbar should be avoided.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
>>  .../devicetree/bindings/arm/omap/crossbar.txt      |   12 ++++++++++--
>>  drivers/irqchip/irq-crossbar.c                     |   20 ++++++++++++++++++--
>>  2 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> index 8210ea4..438ccab 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> @@ -42,8 +42,10 @@ Documentation/devicetree/bindings/arm/gic.txt for further details.
>>  
>>  An interrupt consumer on an SoC using crossbar will use:
>>  	interrupts = <GIC_SPI request_number interrupt_level>
>> -request number shall be between 0 to that described by
>> -"ti,max-crossbar-sources"
>> +When the request number is between 0 to that described by
>> +"ti,max-crossbar-sources", it is assumed to be a crossbar mapping. If the
>> +request_number is greater than "ti,max-crossbar-sources", then it is mapped as a
>> +quirky hardware mapping direct to GIC.
>>  
>>  Example:
>>  	device_x@0x4a023000 {
>> @@ -51,3 +53,9 @@ Example:
>>  		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>>  		...
>>  	};
>> +
>> +	device_y@0x4a033000 {
>> +		/* Direct mapped GIC SPI 1 used */
>> +		interrupts = <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>;
> 
> Ideally, I'd like to see a macro here so that it's clear that we crossed
> a magic threshold. eg:
> 
> #define MAX_SOURCES     400
> #define DIRECT_IRQ(irq) (MAX_SOURCES + irq)
> ...
> 		interrupts = <GIC_SPI DIRECT_IRQ(1) IRQ_TYPE_LEVEL_HIGH>;
> 
> and, then:
> 
> 		ti,max-crossbar-sources = <MAX_SOURCES>;
> 
 Ok, thats more good for readability. Will add that macro then.

Regards,
 Sricharan
