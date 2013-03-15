From: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] gpio: omap: dts: Move interrupt-controller from
 #interrupt-cells description
Date: Fri, 15 Mar 2013 14:13:47 +0100
Message-ID: <CAAwP0s3c4DMfaUJj1OGRqRX_W0Ec80uAjx5sdu8rXCHkg78zmg@mail.gmail.com>
References: <1362430597-5855-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAAwP0s1FynkxpFRK0oC7r2PAOQvxoATfrmU787n4k5PZmvt+XQ@mail.gmail.com>
 <51431A68.5090605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51431A68.5090605-l0cyMroinI0@public.gmane.org>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 15, 2013 at 1:56 PM, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org> wrote:
> Hi Javier,
>
> On 03/15/2013 01:18 PM, Javier Martinez Canillas wrote:
>> On Mon, Mar 4, 2013 at 9:56 PM, Javier Martinez Canillas
>> <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
>>> The binding documentation for the OMAP GPIO controller has the description
>>> for the "#interrupt-cells" property after the "interrupt-controller".
>>> This is confusing so is better to move the "interrupt-controller" after
>>> "#interrupt-cells" description.
>
> Mmm, your are doing the opposite  :-)
>
> I guess what we do want is that:
>
>     gpio-controller;
>     #gpio-cells = <2>;
>     interrupt-controller;
>     #interrupt-cells = <2>;
>
> So we move "#interrupt-cells" after the "interrupt-controller" description.
>

Indeed!

I got confused I guess...

I'll send a v3 patch fixing the changelog

>>> While being there, change the properties order to be consistent with
>>> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
>>> Documentation/devicetree/bindings/gpio/gpio.txt.
>>>
>>> Reported-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>>> Acked-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>>> ---
>>>
>>> Changes since v1:
>>>   - Change the properties order to be consistent with the rest of the
>>>     DT bindings docs suggested by Jon Hunter.
>>>
>>>  .../devicetree/bindings/gpio/gpio-omap.txt         |    8 ++++----
>>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> index bff51a2..a56e3a5 100644
>>> --- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> @@ -5,12 +5,12 @@ Required properties:
>>>    - "ti,omap2-gpio" for OMAP2 controllers
>>>    - "ti,omap3-gpio" for OMAP3 controllers
>>>    - "ti,omap4-gpio" for OMAP4 controllers
>>> +- gpio-controller : Marks the device node as a GPIO controller.
>>>  - #gpio-cells : Should be two.
>>>    - first cell is the pin number
>>>    - second cell is used to specify optional parameters (unused)
>>> -- gpio-controller : Marks the device node as a GPIO controller.
>>> +- interrupt-controller: Mark the device node as an interrupt controller.
>>>  - #interrupt-cells : Should be 2.
>>> -- interrupt-controller: Mark the device node as an interrupt controller
>>>    The first cell is the GPIO number.
>>>    The second cell is used to specify flags:
>>>      bits[3:0] trigger type and level flags:
>>> @@ -29,8 +29,8 @@ Example:
>>>  gpio4: gpio4 {
>>>      compatible = "ti,omap4-gpio";
>>>      ti,hwmods = "gpio4";
>>> -    #gpio-cells = <2>;
>>>      gpio-controller;
>>> -    #interrupt-cells = <2>;
>>> +    #gpio-cells = <2>;
>>>      interrupt-controller;
>>> +    #interrupt-cells = <2>;
>>>  };
>>> --
>>> 1.7.7.6
>>>
>>
>> Hello,
>>
>> Any comments on this patch?
>>
>> I know is just a trivial documentation fix but I think it can be quite
>> helpful for people referring to gpio-omap binding.
>
> I do agree. The patch is good, but the changelog is confusing.
>
> Regards,
> Benoit
>

Thanks a lot for your feedback and best regards,
Javier
