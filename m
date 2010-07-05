From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH resend 1/3] AM35x: Add musb support
Date: Mon, 05 Jul 2010 14:34:55 +0400
Message-ID: <4C31B54F.6040109@ru.mvista.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com> <20100705095015.GP15951@atomide.com> <4C31ADCA.40607@ru.mvista.com> <20100705102322.GR15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705102322.GR15951-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Tony Lindgren wrote:

>>>> AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
>>>> It has USB phy built inside the IP itself.

>>>> Also added ARCH_AM35x which is required to differentiate musb ips
>>>> between OMAP3x and AM35x. This config would be used for below purposes,
>>>>        - Select am35x.c instead of omap2430.c for compilation
>>>>          at drivers/usb/musb directory. Please note there are
>>>>          significant differneces in these two files as musb ip
>>>>          in quite different on AM35x.
>>>>        - Select workaround codes applicable for AM35x musb issues.
>>>>          one such workaround is for bytewise read issue on AM35x.

>>> <snip>

>>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>>> index b31b6f1..52a6752 100644
>>>> --- a/arch/arm/mach-omap2/Kconfig
>>>> +++ b/arch/arm/mach-omap2/Kconfig
>>>> @@ -84,6 +84,7 @@ config MACH_OMAP3517EVM
>>>> 	bool "OMAP3517/ AM3517 EVM board"
>>>> 	depends on ARCH_OMAP3
>>>> 	select OMAP_PACKAGE_CBB
>>>> +	select ARCH_AM35x
>>>> config MACH_OMAP3_PANDORA
>>>> 	bool "OMAP3 Pandora"

>>> No thanks..

>>>> --- a/arch/arm/plat-omap/Kconfig
>>>> +++ b/arch/arm/plat-omap/Kconfig
>>>> @@ -5,6 +5,14 @@ menu "TI OMAP Implementations"
>>>> config ARCH_OMAP_OTG
>>>> 	bool
>>>> +config ARCH_AM35x
>>>> +	bool
>>>> +	help
>>>> +	  Select this option if your platform is based on AM35x. As
>>>> +	  AM35x has an updated MUSB with CPPI4.1 DMA so this config
>>>> +	  is introduced to differentiate musb ip between OMAP3x and
>>>> +	  AM35x platforms.
>>>> +
>>>> choice
>>>> 	prompt "OMAP System Type"
>>>> 	default ARCH_OMAP2PLUS

>>> ..this should not be needed.

>>    I think Ajay has explained why it's needed. The option is
>> necessary in one or another form.

> It's not needed for omaps, we can already build in support for
> omap2, omap3 and omap4 into the same kernel binary.

    Not with AM35x USB support merged -- at least you won't be able to build 
single kernel with monolithic MUSB support.

> If a Kconfig option is needed for optionally compiling in the support
> for am35x musb, it should be called USB_MUSB_AM35X or similar that
> gets selected if the boards using it are selected.

    Do you mean that we should have this option in drivers/usb/musb/Kconfig?

> Regards,
> Tony

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
