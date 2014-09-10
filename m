From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: omap5: Add dr_mode for dwc3
Date: Wed, 10 Sep 2014 15:03:33 +0300
Message-ID: <54103E15.3090406@compulab.co.il>
References: <1381402195-29257-1-git-send-email-kishon@ti.com> <1381402195-29257-2-git-send-email-kishon@ti.com> <52580F34.8030809@ti.com> <20140416161619.GH28035@saruman.home> <540D9449.3090008@compulab.co.il> <20140908132403.GA22409@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140908132403.GA22409-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/08/2014 04:24 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Sep 08, 2014 at 02:34:33PM +0300, Dmitry Lifshitz wrote:
>> Hi Felipe, Roger
>>
>> On 04/16/2014 07:16 PM, Felipe Balbi wrote:
>>> On Fri, Oct 11, 2013 at 05:46:12PM +0300, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 10/10/2013 01:49 PM, Kishon Vijay Abraham I wrote:
>>>>> From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>>>>>
>>>>> Added dr_mode property in dwc3 and set its default mode to device.
>>>>
>>>> If there is a specific reason why this is not set to "otg", we need
>>>> to explain it here.
>>>>
>>>> AFAIK the port is meant to be used as OTG port.
>>>
>>> we still don't have the workaround for dual role ports, I've been
>>> working on it but still need to retest and make sure it's working fine
>>> before merging upstream.
>>>
>>
>>
>> Does the OTG port suppose to work with OMAP5? I mean role switching
>> mechanism?
>>
>> I'm testing kernel v3.16 with OMAP5 based board (CM-T54).
>>
>> If I set CONFIG_USB_DWC3_DUAL_ROLE, than nothing is going on when I plug
>> some device/host cable into micro USB3.0 port (VBUS/ID detection with extcon
>> events works fine).
>
> Dual role does not work. We allow the driver to the built with both Host
> and Peripheral support because some platforms have more than one port
> and building the driver with dual role allows us to make one port host
> and one peripheral.
>

Please, can you provide some detail about platforms with several ports.
How do that ports are connected to DWC3?


Thanks,

Dmitry


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
