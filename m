From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: Regression 3.11-rc1: omap4panda: no usb and consequently no
 ethernet
Date: Fri, 26 Jul 2013 12:23:52 +0200
Message-ID: <51F24E38.4090008@broadcom.com>
References: <51E7AA24.6080600@broadcom.com> <51E7CEF3.5000408@ti.com>
 <51E7D080.6070401@broadcom.com> <51E7D1D2.1060006@ti.com>
 <51E7E1B7.6090104@broadcom.com> <51E7E2AD.8020106@ti.com>
 <51F122D5.80205@broadcom.com> <51F1E39D.2030902@ti.com>
 <51F1E65B.4020005@ti.com> <51F24BD6.9010405@broadcom.com>
 <51F24C47.8060802@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F24C47.8060802@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 07/26/2013 12:15 PM, Arend van Spriel wrote:
> On 07/26/2013 12:13 PM, Arend van Spriel wrote:
>> On 07/26/2013 05:00 AM, Joel Fernandes wrote:
>>> On 07/25/2013 09:49 PM, Joel Fernandes wrote:
>>>
>>> [..]
>>>
>>>>> Can I get back on this topic. When USB and ethernet was working for me
>>>>> as stated above, I was not doing tftpboot. When I use tftpboot the
>>>>> images are obtained from the tftp server, but after kernel has started
>>>>> there is nothing in /sys/bus/usb/devices/.
>>>>
>>>> I quickly tried 3.11-rc2 + Roger's USB PHY clock patch on
>>>> omap4-panda-es
>>>> and enabled following USB options:
>>>>
>>>> CONFIG_USB_MUSB_HDRC=y
>>>> CONFIG_USB_PHY=y
>>>> CONFIG_OMAP_USB2=y
>>>> CONFIG_OMAP_CONTROL_USB=y
>>>> CONFIG_USB_MUSB_OMAP2PLUS=y
>>>> CONFIG_MFD_OMAP_USB_HOST=y
>>>> CONFIG_USB_EHCI_HCD=y
>
> Aaargh. Missing this one. Will retry.

Yes. That is working although it seems I don't need the MUSB stuff.

Regards,
Arend

>>>> CONFIG_USB_OHCI_HCD=y
>>>> CONFIG_USB_EHCI_HCD_OMAP=y
>>>
>>> Sorry I missed saying I also set had to set CONFIG_NOP_USB_XCEIV=y
>>
>> Here are the results of the dutch jury ;-)
>>
>> [    2.537109] HS USB OTG: no transceiver configured
>> [    2.542541] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
>> with status -517
>> [    2.542541] platform musb-hdrc.0.auto: Driver musb-hdrc requests
>> probe deferral
>>
>> I am surely missing something here. Either in device tree or .config.
>>
>> Regards,
>> Arend
>
