From: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE:
Date: Wed, 16 Feb 2011 17:47:10 +0530
Message-ID: <3897a14de7c3109761d242f2b6e54eb2@mail.gmail.com>
References: <1297857190-27449-1-git-send-email-hemahk@ti.com> <4D5BBC61.2000905@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D5BBC61.2000905-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

 Hi,
>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
>Sent: Wednesday, February 16, 2011 5:31 PM
>To: Hema HK
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re:
>
>On 16-02-2011 14:53, Hema HK wrote:
>
>> From: Hema HK<hemahk-l0cyMroinI0@public.gmane.org
>
>> Moved all the board specific internal PHY functions out of
>usb_musb.c file
>> as this file is shared between the OMAP2+ and AM35xx platforms.
>> There exists a file which has the functions specific to internal PHY
>> used for OMAP4 platform. Moved all phy specific functions to
>this file
>> and passing these functions through board data in the board file.
>
>> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>
>> Index: linux-2.6/arch/arm/mach-omap2/board-am3517evm.c
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/mach-omap2/board-am3517evm.c
>> +++ linux-2.6/arch/arm/mach-omap2/board-am3517evm.c
>> @@ -409,6 +409,10 @@ static struct omap_musb_board_data musb_
>>   	.interface_type         = MUSB_INTERFACE_ULPI,
>>   	.mode                   = MUSB_OTG,
>>   	.power                  = 500,
>> +	.set_phy_power		= am35x_musb_phy_power,
>> +	.clear_irq		= am35x_musb_clear_irq,
>> +	.set_mode		= am35x_musb_set_mode,
>> +	.reset			= am35x_musb_reset,
>>   };
>>
>>   static __init void am3517_evm_musb_init(void)
>[...]
>> Index: linux-2.6/arch/arm/mach-omap2/Makefile
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/mach-omap2/Makefile
>> +++ linux-2.6/arch/arm/mach-omap2/Makefile
>> @@ -218,7 +218,8 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board
>>   					   hsmmc.o \
>>   					   omap_phy_internal.o
>>
>> -obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
>> +obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
>> +					   omap_phy_internal.o \
>>
>>   obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
>
>    Doesn't the above board needs board data modified as well?

There is no "musb_board_data" for the above board file.

Regards,
Hema

>
>WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
