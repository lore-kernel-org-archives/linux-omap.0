From: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] usb: otg: OMAP4430: Fix omap4430_phy_init function
Date: Thu, 24 Mar 2011 16:45:45 +0530
Message-ID: <6177f004fc5dad2940b35d1f41c8d05f@mail.gmail.com>
References: <1300964764-6794-1-git-send-email-hemahk@ti.com> <20110324110824.GH14602@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110324110824.GH14602-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
>Sent: Thursday, March 24, 2011 4:38 PM
>To: Hema HK
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: [PATCH 1/2] usb: otg: OMAP4430: Fix
>omap4430_phy_init function
>
>On Thu, Mar 24, 2011 at 04:36:04PM +0530, Hema HK wrote:
>> omap4430_phy_init() function can be called with no device pointer
>> to powerdown the UTMI PHY during board init when USB is disabled.
>> Fix the function accordingly.
>>
>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/mach-omap2/omap_phy_internal.c |   44
>++++++++++++++++--------------
>>  1 files changed, 23 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
>b/arch/arm/mach-omap2/omap_phy_internal.c
>> index e2e605f..a959e2f 100644
>> --- a/arch/arm/mach-omap2/omap_phy_internal.c
>> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
>> @@ -50,34 +50,36 @@ int omap4430_phy_init(struct device *dev)
>>  {
>>  	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>>  	if (!ctrl_base) {
>> -		dev_err(dev, "control module ioremap failed\n");
>> +		printk(KERN_ERR "control module ioremap failed\n");
>
>use pr_err()

OK.
>
>>  		return -ENOMEM;
>>  	}
>>  	/* Power down the phy */
>>  	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>> -	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
>>
>> -	if (IS_ERR(phyclk)) {
>> -		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
>> -		iounmap(ctrl_base);
>> -		return PTR_ERR(phyclk);
>> -	}
>> +	if (dev) {
>
>you can avoid this nesting level:
>
>if (!dev)
>	return;

:-) Yes.

Regards,
Hema
>
>--
>balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
