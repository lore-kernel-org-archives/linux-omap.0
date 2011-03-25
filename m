From: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] usb: otg: OMAP4430: Fix omap4430_phy_init function
Date: Fri, 25 Mar 2011 12:48:15 +0530
Message-ID: <481a54d509a321c24d039fcd1b1d685f@mail.gmail.com>
References: <1300964764-6794-1-git-send-email-hemahk@ti.com> <4D8B4482.4040506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D8B4482.4040506-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
>Sent: Thursday, March 24, 2011 6:48 PM
>To: Hema HK
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: [PATCH 1/2] usb: otg: OMAP4430: Fix
>omap4430_phy_init function
>
>Hello.
>
>On 24-03-2011 14:06, Hema HK wrote:
>
>> omap4430_phy_init() function can be called with no device pointer
>> to powerdown the UTMI PHY during board init when USB is disabled.
>> Fix the function accordingly.
>
>> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/mach-omap2/omap_phy_internal.c |   44
>++++++++++++++++--------------
>>   1 files changed, 23 insertions(+), 21 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
>b/arch/arm/mach-omap2/omap_phy_internal.c
>> index e2e605f..a959e2f 100644
>> --- a/arch/arm/mach-omap2/omap_phy_internal.c
>> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
>> @@ -50,34 +50,36 @@ int omap4430_phy_init(struct device *dev)
>>   {
>>   	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>>   	if (!ctrl_base) {
>> -		dev_err(dev, "control module ioremap failed\n");
>> +		printk(KERN_ERR "control module ioremap failed\n");
>
>    Use pr_err().

This is fixed in the next version of the patch submitted yesterday.

>
>>   		return -ENOMEM;
>>   	}
>>   	/* Power down the phy */
>>   	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>> -	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
>>
>> -	if (IS_ERR(phyclk)) {
>> -		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
>> -		iounmap(ctrl_base);
>> -		return PTR_ERR(phyclk);
>> -	}
>> +	if (dev) {
>> +		phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
>
>    Couldn't clk_get() be called with NULL device ptr?

Can be called with NULL pointer, but there will be issue with dev_err.
And moreover, when there is no device built, there is no point in getting
the clocks.

This function is called with NULL dev pointer only when there is no
device built but has to powerdown the PHY.

Regards,
Hema
>
>WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
