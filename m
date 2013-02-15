From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] arm: dts: Add uart1 and uart2 to igep boards.
Date: Fri, 15 Feb 2013 11:03:51 +0100
Message-ID: <511E0807.8000200@ti.com>
References: <1355326422-12357-1-git-send-email-matthias.bgg@gmail.com>
 <50C8AC3C.9020908@ti.com>
 <CABuKBeJsHCq98Pe-BwPajbQ+2OLQpwrbtVTJe=j9thPDQCCBrg@mail.gmail.com>
 <CAAwP0s01Jxh0f-T0sd5D980dZPcEV0J1KzjPbNHkrXLaKA3YUg@mail.gmail.com>
 <CABuKBeJsg_P=aDr0s9iVOD+7YTNoVUFQJCJymJyJ7NqXHUBzKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CABuKBeJsg_P=aDr0s9iVOD+7YTNoVUFQJCJymJyJ7NqXHUBzKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org" <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, "ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Matthias,

On 2/15/2013 10:35 AM, Matthias Brugger wrote:
> 2013/1/26 Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> On Sat, Jan 26, 2013 at 4:16 PM, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> wrote:
>>> Hi Benoit,
>>>
>>> 2012/12/12 Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>:
>>>> Hi Matthias,
>>>>
>>>> On 12/12/2012 04:33 PM, Matthias Brugger wrote:
>>>>> This patch is a follow-up patch for Javier Martinez effort adding
>>>>> initial
>>>>> device tree support to IGEP technology devices. [1]
>>>>>
>>>>> It adds uart1 and uart2 bindings to the generic dtsi for the IGEP
>>>>> boards.
>>>>>
>>>>> [1] http://www.spinics.net/lists/linux-omap/msg83409.html
>>>>>
>>>>> Signed-off-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>> ---
>>>>>   arch/arm/boot/dts/omap3-igep.dtsi |   24 ++++++++++++++++++++++++
>>>>>   1 file changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi
>>>>> b/arch/arm/boot/dts/omap3-igep.dtsi
>>>>> index 125fe00..c02e3c0 100644
>>>>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>>>>> @@ -27,6 +27,20 @@
>>>>>   };
>>>>>
>>>>>   &omap3_pmx_core {
>>>>> +     uart1_pins: pinmux_uart1_pins {
>>>>> +             pinctrl-single,pins = <
>>>>> +                     0x152 0x100     /* uart1_rx.uart1_rx INPUT | MODE0
>>>>> */
>>>>> +                     0x14c 0         /* uart1_tx.uart1_tx OUTPUT |
>>>>> MODE0 */
>>>>> +             >;
>>>>> +     };
>>>>> +
>>>>> +     uart2_pins: pinmux_uart2_pins {
>>>>> +             pinctrl-single,pins = <
>>>>> +                     0x14a 0x100     /* uart2_rx.uart2_rx INPUT | MODE0
>>>>> */
>>>>> +                     0x148 0         /* uart2_tx.uart2_tx OUTPUT |
>>>>> MODE0 */
>>>>> +             >;
>>>>> +     };
>>>>> +
>>>>>        uart3_pins: pinmux_uart3_pins {
>>>>>                pinctrl-single,pins = <
>>>>>                        0x16e 0x100     /* uart3_rx.uart3_rx INPUT | MODE0
>>>>> */
>>>>> @@ -77,6 +91,16 @@
>>>>>        status = "disabled";
>>>>>   };
>>>>>
>>>>> +&uart1 {
>>>>> +       pinctrl-names = "default";
>>>>> +       pinctrl-0 = <&uart1_pins>;
>>>>> +};
>>>>> +
>>>>> +&uart2 {
>>>>> +       pinctrl-names = "default";
>>>>> +       pinctrl-0 = <&uart2_pins>;
>>>>> +};
>>>>> +
>>>>>   &uart3 {
>>>>>          pinctrl-names = "default";
>>>>>          pinctrl-0 = <&uart3_pins>;
>>>>>
>>>>
>>>> That looks good to me. I'll apply it on top of javier's series for 3.9.
>>>
>>> Can you pin-point me to the repository where this patches are in right
>>> now? I tried to figure it out these days, but didn't found where to
>>> clone the repository from.
>>>
>>> Thanks,
>>> Matthias
>>>
>>
>> Hi Matthias,
>>
>> OMAP DT tree is:
>> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
>
> Hi all,
>
> unfortunately I can't find the patch in this tree.

Sorry about that. I've never pushed the latest branch, and was busy the 
past month. I'll refresh the branch with all the pending patches.

Regards,
Benoit
