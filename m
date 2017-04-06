From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] misc: sram-exec: Use aligned fncpy instead of memcpy
Date: Thu, 6 Apr 2017 14:35:29 -0500
Message-ID: <67706a7c-506f-a56a-9f57-874d97961fa0@ti.com>
References: <20170405192120.1009-1-d-gerlach@ti.com>
 <ab1583fc-0560-b4d2-851b-4be6201edf8b@ti.com>
 <20170406190747.GP23750@n2100.armlinux.org.uk>
 <9a970ac7-cb8f-28f4-3b84-ad8bedf1242c@ti.com>
 <20170406192954.GQ23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170406192954.GQ23750@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/06/2017 02:29 PM, Russell King - ARM Linux wrote:
> On Thu, Apr 06, 2017 at 02:14:12PM -0500, Dave Gerlach wrote:
>> On 04/06/2017 02:07 PM, Russell King - ARM Linux wrote:
>>> On Wed, Apr 05, 2017 at 02:22:33PM -0500, Dave Gerlach wrote:
>>>> Russell,
>>>> On 04/05/2017 02:21 PM, Dave Gerlach wrote:
>>>>> Currently the sram-exec functionality, which allows allocation of
>>>>> executable memory and provides an API to move code to it, is only
>>>>> selected in configs for the ARM architecture. Based on commit
>>>>> 5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
>>>>> function body copying") simply copying a C function pointer address
>>>>> using memcpy without consideration of alignment and Thumb is unsafe on
>>>>> ARM platforms.
>>>>>
>>>>> The aforementioned patch introduces the fncpy macro which is a safe way
>>>>> to copy executable code on ARM platforms, so let's make use of that here
>>>>> rather than the unsafe plain memcpy that was previously used by
>>>>> sram_exec_copy.
>>>>>
>>>>> In the future, architectures hoping to make use of the sram-exec
>>>>> functionality must define an fncpy macro just as ARM has done to
>>>>> guarantee or check for safe copying to executable memory before allowing
>>>>> the arch to select CONFIG_SRAM_EXEC.
>>>>>
>>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>>> ---
>>>>> drivers/misc/sram-exec.c | 3 ++-
>>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
>>>>> index ac522417c462..0057eabe5c03 100644
>>>>> --- a/drivers/misc/sram-exec.c
>>>>> +++ b/drivers/misc/sram-exec.c
>>>>> @@ -19,6 +19,7 @@
>>>>> #include <linux/sram.h>
>>>>>
>>>>> #include <asm/cacheflush.h>
>>>>> +#include <asm/fncpy.h>
>>>>>
>>>>> #include "sram.h"
>>>>>
>>>>> @@ -93,7 +94,7 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
>>>>> 	set_memory_nx((unsigned long)base, pages);
>>>>> 	set_memory_rw((unsigned long)base, pages);
>>>>>
>>>>> -	memcpy(dst, src, size);
>>>>> +	fncpy(dst, src, size);
>>>>>
>>>>> 	set_memory_ro((unsigned long)base, pages);
>>>>> 	set_memory_x((unsigned long)base, pages);
>>>>>
>>>>
>>>> Does this address your concerns from here [1]? Because the only user of this
>>>> code is ARM right now I already only build the sram-exec code in if
>>>> CONFIG_ARM is selected.
>>>
>>> Sorry, it does not.  Please read the comments in asm/fncpy.h.
>>>
>>> Deviating from the proscribed usage means your code is, quite simply,
>>> buggy.  There's no two ways about that.
>>>
>>
>> I understand there are many constraints to using fncpy, as this is what we
>> used before to copy our executable code. Apart from users being aware of
>> what these constraints are (8-byte aligned, position independent) and making
>> sure the code they are moving meets them, are you saying we need some sort
>> of additional strict enforcement of them? Because fncpy today will throw a
>> bug if you fail to align src and dst properly, so adding another check will
>> just double the messages to the user.
>
> Yes, fncpy() will throw a bug, but as I've already explained:
>
> 	sram = alloc();
>
> 	sram_func = fncpy(sram, func, func_size);
>
> 	sram_func();
>
> is the _only_ valid usage.
>
> You must not do:
>
> 	sram = alloc();
>
> 	fncpy(sram, func, func_size);
>
> 	sram();
>
> because that will not work with Thumb code.  The only permitted usage
> is as per the first example above, everything else is buggy.
>

I see exactly what you mean now. I missed that before, thank you for clarifying. 
Will update this patch and send a new version.

Regards,
Dave
