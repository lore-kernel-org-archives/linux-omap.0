From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
Date: Wed, 25 May 2016 10:45:55 -0500
Message-ID: <5745C8B3.2050609@ti.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
 <573C7844.5030107@ti.com> <20160518175102.GX5783@n2100.arm.linux.org.uk>
 <3861017.ZJOlWYvEFT@wuerfel> <20160518205758.GY5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160518205758.GY5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 05/18/2016 03:57 PM, Russell King - ARM Linux wrote:
> On Wed, May 18, 2016 at 10:25:03PM +0200, Arnd Bergmann wrote:
>> The ARM version of ioremap_exec() that gets added in this patch is cached
>> (like memremap()), but then the asm-generic version is not? This is
>> even more confusing, it should at least do roughly the same thing across
>> architectures.
>>
>> There should also be some documentation about what the expected behavior is, e.g.:
>>
>> - is memremap_exec() by default cached or not? (I assume it would
>>    be like memremap())
>> - If we have an interface that does explicit uncached executable mapping,
>>    what about architectures on which this is not possible? Should they
>>    fall back to cached or non-executable, or cause a link error?

Yes by default memremap_exec is cached, I do plan to add more explicit 
documentation.

Well, I dont think that memremap_exec will be called directly but rather 
using a flag with memremap as arch_memremap_wb is now, to keep the 
memremap API unified, so a link error will prevent this. Also, the 
function may be present in code but not actually used in all cases, the 
example that comes to mind is the drivers/misc/sram.c code where other 
runtime options are perfectly valid for determining how to map memory 
even on architectures that can't memremap_exec_nocache.

I think that a remap that can't deliver what you have asked for should 
return NULL here because if you are requesting executable, noncached 
memory you presumably will try to execute from it and fail, so the 
mapping should fail as it isn't actually valid if it can't do what you want.

>
> Another important point is whether atomic instructions / kernel locks
> can be located within the mapped memory.
>

At this point I'd imagine most of the users of this would be copying 
small chunks of relocatable code (likely written in assembly) that would 
handle low-level tasks without the need for atomic instructions/locks, 
but is this something we should explicitly forbid in documentation?

Regards,
Dave
