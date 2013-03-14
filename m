From: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet
 child nodes
Date: Thu, 14 Mar 2013 22:56:38 +0100
Message-ID: <CAAwP0s3shNns9n5SFjM5XhOTDt-_UaQ0xU7woD+YaO9+0gbH=Q@mail.gmail.com>
References: <1363293217-21926-1-git-send-email-javier.martinez@collabora.co.uk>
 <51423663.2030108@ti.com>
 <7F615964-BC49-4FA6-9D8E-CA6FEFC9C276@collabora.co.uk>
 <51424128.8030405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51424128.8030405-l0cyMroinI0@public.gmane.org>
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
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "<linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 14, 2013 at 10:29 PM, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> wrote:
>
> On 03/14/2013 04:08 PM, Javier Martinez Canillas wrote:
>>
>>
>> Javier
>>
>> Hi Jon,
>>
>> On 14/03/2013, at 21:43, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> wrote:
>>
>>>
>>> On 03/14/2013 03:33 PM, Javier Martinez Canillas wrote:
>>>> Besides being used to interface with external memory devices,
>>>> the General-Purpose Memory Controller can be used to connect
>>>> Pseudo-SRAM devices such as ethernet controllers to OMAP2+
>>>> processors using the TI GPMC as a data bus.
>>>>
>>>> This patch allows an ethernet chip to be defined as an GPMC
>>>> child device node.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>>>> ---
>>>>
>>>> Changes since v1:
>>>>  - Improve the DT binding documentation explaining that even when the GPMC
>>>>    maximum bus address width is 16-bit, it supports devices with 32-bit
>>>>    registers address width and the device property especifying this has to
>>>>    be set accordingly; suggested by Jon Hunter.
>>>>
>>>>
>>>> Documentation/devicetree/bindings/net/gpmc-eth.txt |  101 ++++++++++++++++++++
>>>> arch/arm/mach-omap2/gpmc.c                         |    8 ++
>>>> 2 files changed, 109 insertions(+), 0 deletions(-)
>>>> create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>>>> new file mode 100644
>>>> index 0000000..8c8be58
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>>>> @@ -0,0 +1,101 @@
>>>> +Device tree bindings for Ethernet chip connected to TI GPMC
>>>> +
>>>> +Besides being used to interface with external memory devices, the
>>>> +General-Purpose Memory Controller can be used to connect Pseudo-SRAM devices
>>>> +such as ethernet controllers to processors using the TI GPMC as a data bus.
>>>> +
>>>> +Ethernet controllers connected to TI GPMC are represented as child nodes of
>>>> +the GPMC controller with an "ethernet" name.
>>>> +
>>>> +All timing relevant properties as well as generic GPMC child properties are
>>>> +explained in a separate documents. Please refer to
>>>> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>> +
>>>> +For the properties relevant to the ethernet controller connected to the GPMC
>>>> +refer to the binding documentation of the device. For example, the documentation
>>>> +for the SMSC 911x is Documentation/devicetree/bindings/net/smsc911x.txt
>>>> +
>>>> +Child nodes need to specify the GPMC bus address width using the "bank-width"
>>>> +property but is possible that an ethernet controller also has a property to
>>>> +specify the I/O registers address width. Even when the GPMC has a maximum 16-bit
>>>> +address width, it supports devices with 32-bit word registers.
>>>> +For example with an SMSC LAN911x/912x controller connected to the TI GPMC on an
>>>> +OMAP2+ board, "bank-width = <2>;" and "reg-io-width = <4>;".
>>>> +
>>>> +Required properties:
>>>> +- bank-width:        Address width of the device in bytes. GPMC supports 8-bit
>>>> +            and 16-bit devices and so must be either 1 or 2 bytes.
>>>> +- compatible:        Compatible string property for the ethernet child device.
>>>> +- gpmc,cs-on:        Chip-select assertion time
>>>> +- gpmc,cs-rd-off:    Chip-select de-assertion time for reads
>>>> +- gpmc,cs-wr-off:    Chip-select de-assertion time for writes
>>>> +- gpmc,oe-on:        Output-enable assertion time
>>>> +- gpmc,oe-off        Output-enable de-assertion time
>>>> +- gpmc,we-on:        Write-enable assertion time
>>>> +- gpmc,we-off:        Write-enable de-assertion time
>>>> +- gpmc,access:        Start cycle to first data capture (read access)
>>>> +- gpmc,rd-cycle:    Total read cycle time
>>>> +- gpmc,wr-cycle:    Total write cycle time
>>>> +- reg:            Chip-select, base address (relative to chip-select)
>>>> +            and size of the memory mapped for the device.
>>>> +            Note that base address will be typically 0 as this
>>>> +            is the start of the chip-select.
>>>> +
>>>> +Optional properties:
>>>> +- gpmc,XXX        Additional GPMC timings and settings parameters. See
>>>> +            Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>
>>> Should we add "reg-io-width" here and say can be 2 or 4 and to refer to
>>> the above description?
>>>
>>
>> I'm not sure about that, this property is not used (neither relevant) to the GPMC driver but is used by the smsc911x driver.
>>
>> Other Ethernet chips could not need that (e.g: supports only 32 bit word accesses) or can have a different property. Uses should check the documentation binding for the connected device.
>
> Good point. Let's not bother adding that.
>
>>>> +
>>>> +Optional properties for partiton table parsing:
>>>> +- #address-cells: should be set to 1
>>>> +- #size-cells: should be set to 1
>>>
>>> Sorry should have caught this earlier. The above is not relevant for
>>> ethernet.
>>>
>>
>> I should have catch that before sending the first version!
>>
>> I took the properties from your gpmc-nor.txt documentation and this is a left over. Will send a v3 removing that.
>>

ok v3 sent removing this left over.

>> Sorry for being so carelessly...
>
> No problem. Thanks for getting this done. Now just to figure out how to
> handle the darn gpio interrupt ;-)
>

yes, I'll try to do that as my next step :-)

> Jon
> --

Thanks a lot for your help and best regards,
Javier
