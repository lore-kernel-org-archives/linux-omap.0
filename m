From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Mon, 4 Feb 2013 12:57:17 +0100
Message-ID: <CABxcv==7KiBbkTyr7VLVw82F=9vVWRftpbyZWub_CVp3pQW0tQ@mail.gmail.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
 <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
 <CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com>
 <510F8F49.9020800@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <510F8F49.9020800-p8DiymsW2f8@public.gmane.org>
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
To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 4, 2013 at 11:36 AM, Florian Vaussard
<florian.vaussard-p8DiymsW2f8@public.gmane.org> wrote:
> Hi Javier,
>
>

Hi Florian,

> On 02/04/2013 10:27 AM, Javier Martinez Canillas wrote:
>>
>> Hi Florian,
>>
>> On Mon, Jan 28, 2013 at 6:54 PM, Florian Vaussard
>> <florian.vaussard-p8DiymsW2f8@public.gmane.org> wrote:
>>>
>>> Add device-tree support for the GPMC controller on the OMAP3.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>> ---
>>>   arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
>>>   1 files changed, 11 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>>> index 6c63118..2ddae38 100644
>>> --- a/arch/arm/boot/dts/omap3.dtsi
>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>> @@ -403,5 +403,16 @@
>>>                          ti,timer-alwon;
>>>                          ti,timer-secure;
>>>                  };
>>> +
>>> +               gpmc: gpmc@6e000000 {
>>> +                       compatible = "ti,omap3430-gpmc";
>>> +                       ti,hwmods = "gpmc";
>>> +                       reg = <0x6e000000 0x1000000>;
>>> +                       interrupts = <20>;
>>> +                       gpmc,num-cs = <8>;
>>> +                       gpmc,num-waitpins = <4>;
>>> +                       #address-cells = <2>;
>>> +                       #size-cells = <1>;
>>> +               };
>>>          };
>>>   };
>>
>>
>> I had the same patch on a tree I was working on to add DT support for
>> gpmc-smsc911x on an OMAP3 board but I was waiting for Daniel's patches
>> to hit mainline before sending the RFC. So please feel free to add:
>>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>>
>
> Great, the smsc911x was on my TODO list, I can cross it out :) BTW,
> do you have a public git for this, so I can test your work on my setup?
>

Yes, it is the gpmc-smsc911x-wip branch on my github linux tree [1]

That branch is Linus master tree + linux-omap/omap-for-v3.9/gpmc +
linux-omap-dt/for_3.9/dts

plus these patches:

Javier Martinez Canillas (4):
      ARM: OMAP: gpmc-smsc911x: add DT dev node init function
      ARM: OMAP: gpmc: add support for gpmc-smsc911x child nodes
      ARM: dts: OMAP: Add an GPMC node for OMAP3
      ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support

You can browse these patches here [2].

With these patches I have ethernet working on my IGEPv2 but this board
uses an OMAP GPIO pin as the smsc911x IRQ line, so it needs to set a
mux pin (mcspi1_cs2.gpio_176 INPUT | MODE4) or it will fallback on
poll mode.

For some reasons I still couldn't figure out (I'm still learning about
Device Trees) adding:

       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);

to the gpmc-smsc911x child node parse function (gpmc_smsc911x_init_dt)
didn't have a functional effect and I had to initialize the defined
pinctrl-single pins for the smsc911x in the omap3_pmx_core device node
instead of pmc_smsc911x@0 as I do for other devices (mmc, uarts, etc).

So I just removed the devm_pinctrl_get_select_default() call in
gpmc_smsc911x_init_dt() in for this RFC.

I don't know if this is because arch/arm/mach-omap2/gpmc-smsc911x.c is
not a real platform driver (is just a wrapper/helper function) and
doesn't have a probe function.

Which brings me to the question if my approach of adding a binding for
gpmc-smsc911x is correct or if we should extend/use the binding that
already exist for smsc911x
(Documentation/devicetree/bindings/net/smsc911x.txt).

> For the GPMC support, I will have to make a few more more as discussed with
> Tony, and as I will be away for more than 2 weeks, feel free to go ahead
> before me. This patchset was only at an RFC stage.
>
> Regards,
>
> Florian
>

Yes, I saw on the list that Tony asked you too extend the GPMC DT
support. Flash support is on my TODO list too but I don't know if I'm
going to have time to work on this in the next few weeks.

Since you are thinking to change the binding, there is something I
want to discuss with you.

We have two different version for each IGEP board, one that uses NAND
memory and another that has OneNAND.

With board files this is easy because the flash memory type is
hardcoded (in hardware) using sysboot pins [3]. So we check the
sysboot value and call board_nand_init() or board_onenand_init()
accordingly and pass the same static struct mtd_partition
igep_flash_partitions[] in both cases.

But with DT this is a little bit trickier since you have to define
either a nand@0 or onenand@0 child node for the gpmc device node. So,
we will have to create lots of dts and dtsi to handle each combination
(IGEPv2 + NAND, IGEPv2 + OneNAND, IGEP COM + NAND, etc).

I wonder if we could just have a generic gpmc-flash binding and maybe
use a "gpmc, flash_type" property or something like that to decide if
gpmc_onenand_init() or gpmc_nand_init() has to be called.

Thanks a lot and best regards,
Javier

[1]: git://github.com/martinezjavier/linux.git
[2]: https://github.com/martinezjavier/linux/commits/gpmc-smsc911x-wip
[3]: http://omappedia.org/wiki/Bootloader_Project#SYSBOOT_Pins
