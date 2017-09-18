From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Mon, 18 Sep 2017 14:57:36 -0500
Message-ID: <d68b90bb-fa93-24e5-08f0-ab6d7bd2df22@ti.com>
References: <20170724212454.27574-1-d-gerlach@ti.com>
 <20170724212454.27574-3-d-gerlach@ti.com>
 <20170831140332.GD23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170831140332.GD23750-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Russell,
On 08/31/2017 09:03 AM, Russell King - ARM Linux wrote:
> On Mon, Jul 24, 2017 at 04:24:54PM -0500, Dave Gerlach wrote:
>> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
>> index 608008229c7d..46a7a6c41db7 100644
>> --- a/arch/arm/kernel/asm-offsets.c
>> +++ b/arch/arm/kernel/asm-offsets.c
>> @@ -28,6 +28,7 @@
>>  #include <asm/vdso_datapage.h>
>>  #include <asm/hardware/cache-l2x0.h>
>>  #include <linux/kbuild.h>
>> +#include <linux/ti-emif-sram.h>
>>  
>>  /*
>>   * Make sure that the compiler and target are compatible.
>> @@ -183,5 +184,8 @@ int main(void)
>>  #ifdef CONFIG_VDSO
>>    DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
>>  #endif
>> +  BLANK();
>> +  ti_emif_offsets();
>> +
>>    return 0; 
>>  }
> 
> This doesn't make me happy - I've been thinking about this for some time,
> and I think it's completely wrong for drivers to hook into asm-offsets.
> 
> Looking at the top-level Kbuild file, it looks like it would be easy
> for emif to auto-generate its own offsets.h header - it looks like it's
> a matter of using linux/kbuild.h to get the definitions, compiling to
> assembly (using $(call if_changed_dep,cc_s_c)) and then converting the
> assembly to the header file format ( using
> $(call filechk,offsets,__ASM_OFFSETS_H__), replacing __ASM_OFFSETS_H__
> with a more appropriate symbol.)
> 
> Could you please check whether this is possible, so we don't end up
> needing to hook lots of driver-specific assembly offsets stuff into
> the arch files?
> 

I was able to try this out and was successful, I will send an updated version
that generates a local emif-asm-offsets.h. Thanks for the suggestion.

Regards,
Dave
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
