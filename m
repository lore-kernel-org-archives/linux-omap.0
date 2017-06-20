From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Tue, 20 Jun 2017 14:03:35 -0500
Message-ID: <fdfa1059-17f7-74f7-4b88-2941af07a538@ti.com>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-3-d-gerlach@ti.com>
 <20170620144243.GB23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170620144243.GB23750-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
On 06/20/2017 09:42 AM, Russell King - ARM Linux wrote:
> On Fri, May 19, 2017 at 12:57:08PM -0500, Dave Gerlach wrote:
>> +	.arm
>> +	.align 3
>> +
>> +ENTRY(ti_emif_sram)
> 
> Will you ever want to have any of this code as Thumb?

I cannot see any requirement for that. I will say it is tested and
inter-operates happily with CONFIG_THUMB_KERNEL, but because it's constrained to
am335x and am437x I don't think there are unknown situations where every single
instruction must be THUMB.

> 
>> +extern inline void ti_emif_offsets(void)
>> +{
> 
> "extern inline" is frowned upon in the kernel - any reason this
> can't be "static inline" ?

It should be static.

> 
> Any reason not to provide a stub for when it's not configured,
> and eliminate the ifdef in arch/arm/kernel/asm-offsets.c ?
> 

No, I just was following the ifdef example set by others in the file, a stub
would be cleaner I agree.

Regards,
Dave
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
