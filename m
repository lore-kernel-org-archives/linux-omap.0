From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap5: dwc3 interface status in /sys
Date: Thu, 18 Oct 2018 13:57:30 +0300
Message-ID: <dc99d686-9b77-dabf-2d0d-81083e4f98ec@ti.com>
References: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
 <33FDF48F-4B64-4CE4-BC95-43BAB70B6C37@goldelico.com>
 <7a765a99-f273-e92c-1437-f3e5535fbaaf@ti.com>
 <CAH8TKc-0wDXg4VaOho3_uat3JGQSGa=dQyMu7fJEwi6Tce2Z3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAH8TKc-0wDXg4VaOho3_uat3JGQSGa=dQyMu7fJEwi6Tce2Z3g@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: hns@goldelico.com, Kernel development list <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On 18/10/2018 13:50, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Oct 16, 2018 at 1:27 PM Roger Quadros <rogerq@ti.com> wrote:
>>
>> Felipe,
>>
>> On 16/10/2018 12:29, H. Nikolaus Schaller wrote:
>>> Hi,
>>>
>>>> Am 17.09.2018 um 10:24 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>>>
>>>> Hi Felipe,
>>>> I have made otg mode work on the omap5-uevm with help from Roger
>>>> and now I wonder how to read the interface status for GUI display.
>>>>
>>>> On omap3/twl4030 systems we can simply read
>>>>
>>>>      /sys/bus/platform/devices/musb-hdrc.0.auto/mode
>>>>
>>>> and get reports e.g. "b_peripheral", "a_host", "b_idle" etc. which can easily
>>>> be translated into icons for GUI display.
>>>>
>>>> We have not found a similar attribute for dwc3 (except part of this information
>>>> in
>>>>
>>>>      /sys/kernel/debug/4a030000.dwc3
>>>>
>>>> but mounting debugfs for GUI purposes isn't a good idea).
>>>>
>>>> So do you think it is possible to provide such information to
>>>>
>>>>      /sys/devices/platform/44000000.ocp/4a020000.omap_dwc3/4a030000.dwc3?
>>>
>>> any suggestions?
>>
>> This question is not specific to omap5.
>> What is your opinion? If you think it is OK, I can provide a patch for it.
> 
> sounds like this should be part of DRD/OTG core, no?

Yes Felipe.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
