From: Santosh Shilimkar <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Mon, 16 Oct 2017 08:31:59 -0700
Message-ID: <19256977-40e1-a972-4de8-838a8da863cc@oracle.com>
References: <20171013205915.9652-1-d-gerlach@ti.com>
 <20171013205915.9652-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013205915.9652-3-d-gerlach-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On 10/13/2017 1:59 PM, Dave Gerlach wrote:
> Certain SoCs like Texas Instruments AM335x and AM437x require parts
> of the EMIF PM code to run late in the suspend sequence from SRAM,
> such as saving and restoring the EMIF context and placing the memory
> into self-refresh.
> 
> One requirement for these SoCs to suspend and enter its lowest power
> mode, called DeepSleep0, is that the PER power domain must be shut off.
> Because the EMIF (DDR Controller) resides within this power domain, it
> will lose context during a suspend operation, so we must save it so we
> can restore once we resume. However, we cannot execute this code from
> external memory, as it is not available at this point, so the code must
> be executed late in the suspend path from SRAM.
> 
> This patch introduces a ti-emif-sram driver that includes several
> functions written in ARM ASM that are relocatable so the PM SRAM
> code can use them. It also allocates a region of writable SRAM to
> be used by the code running in the executable region of SRAM to save
> and restore the EMIF context. It can export a table containing the
> absolute addresses of the available PM functions so that other SRAM
> code can branch to them. This code is required for suspend/resume on
> AM335x and AM437x to work.
> 
> In addition to this, to be able to share data structures between C and
> the ti-emif-sram-pm assembly code, we can automatically generate all of
> the C struct member offsets and sizes as macros by processing
> emif-asm-offsets.c into assembly code and then extracting the relevant
> data as is done for the generated platform asm-offsets.h files.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
> v4->v5:
> * Simplify Makefile to generate include/generated/ti-emif-asm-offsets.h
> 
If you are happy with this version from Dave, can I get your ack please?
I can add this to the driver-soc then.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
