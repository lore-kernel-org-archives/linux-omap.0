From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Thu, 20 May 2010 13:32:38 +0400
Message-ID: <4BF501B6.7070303@ru.mvista.com>
References: <1274184586-28843-1-git-send-email-ajay.gupta@ti.com> <19F8576C6E063C45BE387C64729E7394044E535C95@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E535C95-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "andrea.marson-0U1K5dsi4As@public.gmane.org" <andrea.marson-0U1K5dsi4As@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Gupta, Ajay Kumar wrote:

>> AM35x supports only 32bit read operations so we need to have
>> workaround for 8bit and 16bit read operations.

>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>> ---
>> Patch created against linus'tree + all musb patches in Greg's queue
>> Changes from v1:
>> 	- removed unnecessary parens.
>> 	- Removed 'memcpy' for 32 bit read loops.

>>  drivers/usb/musb/am3517.c    |   30 ++++++++++++++++++++++++++++++
>>  drivers/usb/musb/musb_core.c |    2 ++
>>  2 files changed, 32 insertions(+), 0 deletions(-)

>> diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
>> index b74e664..3299c66 100644
>> --- a/drivers/usb/musb/am3517.c
>> +++ b/drivers/usb/musb/am3517.c
> [...]
>> +	}
>> +}
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 4093f6d..9c59a8e 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -262,6 +262,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16
>> len, const u8 *src)
>>  	}
>>  }
>>
>> +#if !defined(CONFIG_MACH_OMAP3517EVM)

> Fixes/workaround based on CONFIG_MACH_OMAP3517EVM will be good only for
> OMAP3517EVM and would not scale well to other boards based on AM35x.
> (As commented earlier by Sergei)

> I just got to know of another board "LIZARD" based on AM35x so we really
> need to find a solution for this. 

> This problem is due to the fact that AM35x is based on OMAP35x but musb ip
> Is updated to RTL1.8 using CPPI4.1 DMA engine

    Is that really the only difference?

> thus we need to have a
> config option to differentiate musb ips between actual OMAP3 and AM35x
> platforms.

> I am thinking of adding new config option OMAP_MUSB_RTL18 which should be
> selected by all the boards based on AM35x in arch/arm/mach-omap2/Kconfig.

> The same config option can be used for all the workaround/fixes specific
> to AM35x musb platform.

> ------------------
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b72ae06..3ab1156 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -95,6 +95,7 @@ config MACH_OMAP3517EVM
>         bool "OMAP3517/ AM3517 EVM board"
>         depends on ARCH_OMAP3 && ARCH_OMAP34XX
>         select OMAP_PACKAGE_CBB
> +       select OMAP_MUSB_RTL18
> 
>  config PMIC_TPS65023
>         bool "TPS65023 Power Module"
> ------------------
> 
> Does anyone has a better option to fix this issue or any comment on this
> approach?

    Why not introduce CONFIG_ARCH_AM35x instead?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
