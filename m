From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] ARM: dts: dra72-evm: Add NAND support
Date: Tue, 28 Oct 2014 17:04:28 +0200
Message-ID: <544FB07C.80406@ti.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com> <1413888080-2669-2-git-send-email-rogerq@ti.com> <54468D29.4070706@ti.com> <CAGo_u6q5SO74FYK61Zyx-oweiui=zatJzWjomVm7y6VES+a7Kg@mail.gmail.com> <20141021173211.GA13160@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141021173211.GA13160@kahuna>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Nishant,

On 10/21/2014 08:32 PM, Nishanth Menon wrote:
> On 12:16-20141021, Nishanth Menon wrote:
>> On Tue, Oct 21, 2014 at 11:43 AM, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
>>> Roger,
>>>
>>> On 10/21/2014 05:41 AM, Roger Quadros wrote:
>>>> DRA72-evm has a 256MB 16-bit wide NAND chip. Add
>>>> pinmux and NAND node.
>>>>
>>>> The NAND chips 'Chip select' and 'Write protect' can be
>>>> controlled using DIP Switch SW5. To use NAND,
>>>> the switch must be configured like so:
>>>>
>>>> SW5.1 (NAND_SELn) = ON (LOW)
>>>> SW5.9 (GPMC_WPN) = OFF (HIGH)
>>>
>>> Could we move this description to the dts as a comment? it would be
>>> little more easier to refer to than figuring it out from git log. I
>>> recollect trying to figure this out while attempting to test out NAND
>>> previously, never actually thought to check in git log. just a
>>> suggestion..
>>
>> [...]
>>
>>>> +&gpmc {
>>>> +     status = "okay";
>>>> +     pinctrl-names = "default";
>>>> +     pinctrl-0 = <&nand_default>;
>>>> +     ranges = <0 0 0 0x01000000>;    /* minimum GPMC partition = 16MB */
>>>> +     nand@0,0 {
>>>> +             /* To use NAND, DIP switch SW5 must be set like so:
> 		      ^^ minor:
> 		      /*
> 		       * To use NAND,.... 
>>>> +              * SW5.1 (NAND_SELn) = ON (LOW)
>>>> +              * SW5.9 (GPMC_WPN) = OFF (HIGH)
>>>> +              */
>>
>> [...]
>>
>> Uggh.. ignore my comment - I see you already did that.. my bad.. i missed it :(
>>
>> Quickly trying to test this, I got the following:
>> "
>>
>> [    1.840728] omap-gpmc 50000000.gpmc: GPMC revision 6.0
>> [    1.847290] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xca
>> [    1.854003] nand: Micron MT29F2G16ABAEAWP
>> [    1.858245] nand: 256MiB, SLC, page size: 2048, OOB size: 64
>> [    1.864227] omap2-nand omap2-nand.0: CONFIG_MTD_NAND_OMAP_BCH not enabled
>> [    1.871459] omap2-nand: probe of omap2-nand.0 failed with error -22
>> "
>>
>> Full log: http://hastebin.com/ozugepemin.md
>>
>> Does this depend on
>> http://marc.info/?l=linux-omap&m=141389532511600&w=2 to function? I
>> assume yes.
> 
> looks like we'd want Tony to enable CONFIG_MTD_NAND_OMAP_BCH in
> omap2plus_defconfig?
> 
> With that, it works like a charm..
> http://slexy.org/raw/s29rfTTWB4
> 
> 
> Feel free to add my:
> Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 

Thanks for testing. Sorry for being silent for a while. This whole thread
got moved accidentally to old-inbox ;). Took a while to figure out if I really
sent these patches or just in my dreamworld. :)

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
