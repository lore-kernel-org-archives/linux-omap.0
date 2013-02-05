From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/6] ARM: dts: omap5: add dwc3 omap dt data
Date: Tue, 5 Feb 2013 14:37:05 +0530
Message-ID: <5110CBB9.5080307@ti.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com>
 <1359112312-6918-5-git-send-email-kishon@ti.com> <510432BF.80808@mvista.com>
 <5110C2E6.30504@ti.com> <20130205083828.GE32118@arwen.pp.htv.fi>
 <5110C6EC.6050606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5110C6EC.6050606-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 February 2013 02:16 PM, kishon wrote:
> Hi,
>
> On Tuesday 05 February 2013 02:08 PM, Felipe Balbi wrote:
>> On Tue, Feb 05, 2013 at 01:59:26PM +0530, kishon wrote:
>>> On Sunday 27 January 2013 01:17 AM, Sergei Shtylyov wrote:
>>>> Hello.
>>>>
>>>> On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:
>>>>
>>>>> Add dwc3 omap glue data to the omap5 dt data file. The information
>>>>> about
>>>>> the dt node added here is available @
>>>>> Documentation/devicetree/bindings/usb/omap-usb.txt
>>>>
>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>>   arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>
>>>>> diff --git a/arch/arm/boot/dts/omap5.dtsi
>>>>> b/arch/arm/boot/dts/omap5.dtsi
>>>>> index 5f59bf2..1703a72 100644
>>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>>> @@ -513,6 +513,17 @@
>>>>>               ti,type = <2>;
>>>>>           };
>>>>>
>>>>> +        omap_dwc3@4a020000 {
>>>>> +            compatible = "ti,dwc3";
>>>>> +            ti,hwmods = "usb_otg_ss";
>>>>> +            reg = <0x4a020000 0x1ff>;
>>>>
>>>>     Shoudn't the "reg" length be 0x200 here? It's length, not limit.
>>>
>>> I think 0x1ff is correct. I got the data from hwmod data.
>>
>> hwmod is utterly wrong. Looking at TRM, it says the size here is 64KiB
>> (0x10000), so is the size for dwc3 itself. Please don't blindly trust
>> hwmod, make sure you read data from TRM ;-)
>
> hmm..ok. But it has only 17 registers :-D
>
As Felipe said, it should be 0x200. And if you are
interested in lesser space, there is no need to map entire 64 KB
address space if it isn't being used.

Regards,
Santosh
