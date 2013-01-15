From: kishon <kishon@ti.com>
Subject: Re: [RFC PATCH 2/7] ARM: OMAP: devices: create device for usb part
 of control module
Date: Tue, 15 Jan 2013 19:56:11 +0530
Message-ID: <50F56703.1060202@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com> <1358239378-10030-3-git-send-email-kishon@ti.com> <50F5514A.2040207@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <50F5514A.2040207@mvista.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: grant.likely@secretlab.ca, b-cousson@ti.com, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, arnd@arndb.de, balbi@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 15 January 2013 06:23 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 15-01-2013 12:42, Kishon Vijay Abraham I wrote:
>
>> A seperate driver has been added to handle the usb part of control
>> module. A device for the above driver is created here, using the register
>> address information to be used by the driver for powering on the PHY and
>> for writing to the mailbox.
>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   arch/arm/mach-omap2/devices.c |   50
>> +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>
>> diff --git a/arch/arm/mach-omap2/devices.c
>> b/arch/arm/mach-omap2/devices.c
>> index 5e304d0..a761faf4 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
> [...]
>> @@ -254,6 +255,54 @@ static inline void omap_init_camera(void)
>>   #endif
>>   }
>>
>> +#if (defined(CONFIG_OMAP_CONTROL_USB) || \
>> +                defined(CONFIG_OMAP_CONTROL_USB_MODULE))
>
>     () around || not needed, and you're indenting the second line too much.
>
>> +static inline void __init omap_init_control_usb(void)
>> +{
>> +    int ret = 0;
>
>     Initializer not needed.
>
>> +
>> +    if (cpu_is_omap44xx()) {
>> +        ret = platform_device_register(&omap4_control_usb);
>> +        if (ret)
>> +            pr_err("Error registering omap_control_usb device: %d\n"
>> +                , ret);
>
>     Please leave the comma on the previous line.

Sure. I'll fix it.

Thanks
Kishon
