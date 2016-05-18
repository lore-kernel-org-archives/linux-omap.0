From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
Date: Wed, 18 May 2016 09:12:20 -0500
Message-ID: <573C7844.5030107@ti.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
 <1462830111-28172-2-git-send-email-d-gerlach@ti.com>
 <20160512163759.GW5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160512163759.GW5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
On 05/12/2016 11:37 AM, Russell King - ARM Linux wrote:
> On Mon, May 09, 2016 at 04:41:49PM -0500, Dave Gerlach wrote:
>> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
>> index 66a978d05958..c6eef3c98074 100644
>> --- a/arch/arm/mm/ioremap.c
>> +++ b/arch/arm/mm/ioremap.c
>> @@ -400,6 +400,20 @@ EXPORT_SYMBOL(ioremap_wc);
>>    * clocks that would affect normal memory for example. Please see
>>    * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
>>    */
>> +void __iomem *ioremap_exec(resource_size_t res_cookie, size_t size)
>> +{
>> +	return arch_ioremap_caller(res_cookie, size, MT_MEMORY_RWX,
>> +				   __builtin_return_address(0));
>> +}
>> +EXPORT_SYMBOL(ioremap_exec);
>> +
>> +void __iomem *ioremap_exec_nocache(resource_size_t res_cookie, size_t size)
>> +{
>> +	return arch_ioremap_caller(res_cookie, size, MT_MEMORY_RWX_NONCACHED,
>> +				   __builtin_return_address(0));
>> +}
>> +EXPORT_SYMBOL(ioremap_exec_nocache);
>
> I think these should be called memremap_exec() and similar.  Please
> see the description of memremap() in kernel/memremap.c.  If you're
> going to be executing code, the region must not have I/O side effects
> and according to the new definition of memremap() vs ioremap(), the
> memremap() interfaces fit better.
>
> Please also get these reviewed by Dan Williams who provided the
> memremap() API.

Ok thank you for the pointer. I agree, the memremap API looks like a 
better fit for this. I think it likely makes the most sense to still add 
these ioremap_exec and ioremap_exec_nocache and then call them through 
the memremap API based on new flags. This will fit into the current use 
model for memremap as it currently uses all of the other ioremap calls 
internally, and doing it how I just described will let this code evolve 
along with memremap.

I will put v2 together this way and send it out.

Regards,
Dave

>
> Thanks.
>
