From: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/7] usb: otg: OMAP4430: Add phy_suspend function pointer
 to twl4030_usb_data
Date: Fri, 4 Feb 2011 11:33:43 +0530
Message-ID: <44c09d133e4e3ba82ee862cd082acef0@mail.gmail.com>
References: <yes> <1296726587-10530-4-git-send-email-hemahk@ti.com> <4D4AB2A5.7000002@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D4AB2A5.7000002-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
>Sent: Thursday, February 03, 2011 7:20 PM
>To: Hema HK
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>Felipe Balbi; Tony Lindgren
>Subject: Re: [PATCH 4/7] usb: otg: OMAP4430: Add phy_suspend
>function pointer to twl4030_usb_data
>
>Hello.
>
>On 03-02-2011 12:49, Hema HK wrote:
>
>> Introduce the .phy_suspend function pointer to
>twl4030_usb_data structure.
>> assign the function to it for both sdp board and panda boards.
>> This will be used by the twl6030-usb transceiver driver.
>
>> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
>> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>[...]
>
>> Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
>> +++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -272,6 +272,7 @@ static struct twl4030_usb_data omap4_usb
>>   	.phy_exit	= omap4430_phy_exit,
>>   	.phy_power	= omap4430_phy_power,
>>   	.phy_set_clock	= omap4430_phy_set_clk,
>> +	.phy_suspend	= omap4430_phy_suspend,
>>   };
>>
>>   static struct omap2_hsmmc_info mmc[] = {
>> Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
>> +++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -153,6 +153,7 @@ static struct twl4030_usb_data omap4_usb
>>   	.phy_exit	= omap4430_phy_exit,
>>   	.phy_power	= omap4430_phy_power,
>>   	.phy_set_clock	= omap4430_phy_set_clk,
>> +	.phy_suspend	= omap4430_phy_suspend,
>>   };
>>
>>   static struct omap2_hsmmc_info mmc[] = {
>> Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
>> +++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>> @@ -88,6 +88,7 @@ extern int omap4430_phy_power(struct dev
>>   extern int omap4430_phy_set_clk(struct device *dev, int on);
>>   extern int omap4430_phy_init(struct device *dev);
>>   extern int omap4430_phy_exit(struct device *dev);
>> +extern int omap4430_phy_suspend(struct device *dev, int suspend);
>>
>>   #endif
>>
>> Index: linux-2.6/include/linux/i2c/twl.h
>> ===================================================================
>> --- linux-2.6.orig/include/linux/i2c/twl.h
>> +++ linux-2.6/include/linux/i2c/twl.h
>> @@ -600,6 +600,8 @@ struct twl4030_usb_data {
>>   	int		(*phy_power)(struct device *dev, int
>iD, int on);
>>   	/* enable/disable  phy clocks */
>>   	int		(*phy_set_clock)(struct device *dev, int on);
>> +	/* suspend/resume of phy */
>> +	int		(*phy_suspend)(struct device *dev, int suspend);
>>   };
>
>    I think this patch should contain only this change, and
>the initializers
>and 'extern' declaration should be merged to the previous patch.
>    Also, where do you call this method? Ah, I see, in the
>next patch. I think
>it should be merged to this one then.

No. if I do that git bisect fails.
Initializer does not make any sense without function poointer declaration.
Only extern can be moved to previous patch but, I think it is OK to extern
it
while using.

Regards,
Hema
>
>WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
