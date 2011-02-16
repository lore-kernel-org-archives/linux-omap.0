From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [4/7 v2] usb: otg: OMAP4430: Add phy_suspend function pointer
 to
Date: Wed, 16 Feb 2011 14:36:31 +0300
Message-ID: <4D5BB6BF.7050603@ru.mvista.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com> <1297762958-26199-4-git-send-email-hemahk@ti.com> <4D5A6F20.5060109@ru.mvista.com> <137f7a77ed983ac5f3d08eaea0b2bb66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <137f7a77ed983ac5f3d08eaea0b2bb66-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 16-02-2011 8:14, Hema Kalliguddi wrote:

>>> From: Kalliguddi, Hema<hemahk-l0cyMroinI0@public.gmane.org>

>>> Introduce the .phy_suspend function pointer to
>> twl4030_usb_data structure.
>>> assign the function to it for both sdp board and panda boards.
>>> This will be used by the twl6030-usb transceiver driver.

>>> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>>> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
>>> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

>> [...]

>>> Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
>>> ===================================================================
>>> --- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
>>> +++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
>>> @@ -272,6 +272,7 @@ static struct twl4030_usb_data omap4_usb
>>>    	.phy_exit	= omap4430_phy_exit,
>>>    	.phy_power	= omap4430_phy_power,
>>>    	.phy_set_clock	= omap4430_phy_set_clk,
>>> +	.phy_suspend	= omap4430_phy_suspend,
>>>    };
>>>
>>>    static struct omap2_hsmmc_info mmc[] = {
>>> Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
>>> ===================================================================
>>> --- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
>>> +++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
>>> @@ -153,6 +153,7 @@ static struct twl4030_usb_data omap4_usb
>>>    	.phy_exit	= omap4430_phy_exit,
>>>    	.phy_power	= omap4430_phy_power,
>>>    	.phy_set_clock	= omap4430_phy_set_clk,
>>> +	.phy_suspend	= omap4430_phy_suspend,
>>>    };
>>>
>>>    static struct omap2_hsmmc_info mmc[] = {
>>> Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>>> ===================================================================
>>> --- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
>>> +++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>>> @@ -88,6 +88,7 @@ extern int omap4430_phy_power(struct dev
>>>    extern int omap4430_phy_set_clk(struct device *dev, int on);
>>>    extern int omap4430_phy_init(struct device *dev);
>>>    extern int omap4430_phy_exit(struct device *dev);
>>> +extern int omap4430_phy_suspend(struct device *dev, int suspend);

>>     I think this *extern* declaration should be a part of the
>> previous patch.

> What is the problem if extern when using?

    I think 'extern' declaration should be in the same place where this 
function is defined, else you're just defining an unused function. Same goes 
for the 'phy_suspend' initializers...

>>>    #endif
>>>
>>> Index: linux-2.6/include/linux/i2c/twl.h
>>> ===================================================================
>>> --- linux-2.6.orig/include/linux/i2c/twl.h
>>> +++ linux-2.6/include/linux/i2c/twl.h
>>> @@ -600,6 +600,8 @@ struct twl4030_usb_data {
>>>    	int		(*phy_power)(struct device *dev, int iD, int on);
>>>    	/* enable/disable  phy clocks */
>>>    	int		(*phy_set_clock)(struct device *dev, int on);
>>> +	/* suspend/resume of phy */
>>> +	int		(*phy_suspend)(struct device *dev, int suspend);
>>>    };

>>     I'd make the above the only change in this patch, and add
>> all the other
>> changes into the previous patch (which then I'd change places
>> with that one).

> No. if I do that git bisect fails.

    How in the world it will fail?

> Initializer does not make any sense without function poointer declaration.

    I said "which then I'd changed places with that one", i.e. put this patch 
first and the previous patch second. Otherwise, you're just doing things 
beckwards: first you define the method implementation, and then you declare 
the method itself... it should be vice versa.

> Regards,
> Hema

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
