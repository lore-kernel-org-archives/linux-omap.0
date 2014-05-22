From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 00/16] OMAP: GPMC: Restructure OMAP GPMC driver (NAND)
 : DT binding change proposal
Date: Thu, 22 May 2014 13:51:49 +0200
Message-ID: <CABxcv=nbgGhVN+XYO8s=mYOpoLU9-kWuEqc+FLMaSbWS7BJNyQ@mail.gmail.com>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com>
	<20140521160818.GA1150@arch.cereza>
	<537DB17A.6060608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <537DB17A.6060608-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Roger,

On Thu, May 22, 2014 at 10:12 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Hi Ezequiel,
>
> On 05/21/2014 07:08 PM, Ezequiel Garcia wrote:
>> Hi Roger,
>>
>> On 21 May 02:20 PM, Roger Quadros wrote:
>>>
>>> For DT boot:
>>> - The GPMC controller node should have a chip select (CS) node for each used
>>>   chip select. The CS node must have a child device node for each device
>>>   attached to that chip select. Properties for that child are GPMC agnostic.
>>>
>>>   i.e.
>>>      gpmc {
>>>              cs0 {
>>>                      nand0 {
>>>                      }
>>>              };
>>>
>>>              cs1 {
>>>                      nor0 {
>>>                      }
>>>              }
>>>              ...
>>>      };
>>>
>>
>> While I agree that the GPMC driver is a bit messy, I'm not sure it's possible
>> to go through such a complete devicetree binding re-design (breaking backwards
>> compatibility) now that the binding is already in production.
>
> Why not? especially if the existing bindings are poorly dones. Is anyone using these
> bindings burning the DT into ROM and can't change it when they update the kernel?
>

While I do agree that your DT bindings are much better than the
current ones, there is a policy that DT bindings are an external API
and once are released with a kernel are set in stone and can't be
changed.

The rationale here is that DT only describes hardware and since
hardware does not change, there is no need to change the DT on
subsequent kernel releases.

While that may be true in theory, in practice our understanding of the
hardware keeps evolving. It may be possible that the person adding
those binding didn't understand the hardware fully or did not have
access to all the documentation.

So given that the GPMC bindings are really awful maybe we can make an
exception here? I don't even know who should decide this, if Tony as
OMAP maintainer or the DT maintainers.

> I wouldn't bother much about backward compatibility but just focus on not breaking
> functionality with all GPMC users while cleaning up the existing bindings.
>
>>
>> AFAIK, TI's SDK 7.0 is released, with a v3.8.x kernel which uses this GPMC
>> binding. And then you have the ISEE board too, using this binding.
>
> How does this prevent them from not using the new bindings when they update the kernel?
>

In the particular case of ISEE boards, the vendor still ships a very
old kernel that uses board files and platform data so probably is not
an issue for mainline users to update their DTB but I see that there
are many users of the GPMC binding in mainline:

$ git grep "gpmc[:@_a-zA-Z0-9]* {" arch/arm/boot/dts/ | wc -l
36

>>
>> Also, what's the problem with the current devicetree binding (not that I'm fan
>> of it)?
>>

Like Ezequiel said, I'm not a big fan of the current binding neither
but I don't know how safe is to break backward compatibility at this
point.

Best regards,
Javier

>
> The existing binding uses this format
>
>         gpmc {
>                 ranges <cs-num 0 IO_partition_start IO_partition_size,
>                         cs-num 0 IO_partition_start IO_partition_size,
>                         ...>
>
>                 node-name0 {
>                         compatible = "<id for device on this chip select>";
>                         reg = <cs-num IO_offset IO_size>;
>
>                         <gpmc cs properties>;
>
>                         <device specific properties>;
>                 };
>
>                 node-name1 {
>                         ...
>                 };
>         };
>
> with requirements that
> - chip select number (cs-num) is encoded in range id
> - child's node-name is used to identify device type (NAND, Onenand, etc) and driver expects that.
>
> All this results in the following issues
> - No way to define entire GPMC I/O map (typically 1st 1GB), without assigning them to a Chip select. i.e. incomplete hardware description.
>   TI SoCs variants can have different GPMC I/O sizes, some can have 512MB others can have 1GB. There needs to be a way to specify that.
> - No clean way to specify GPMC register map for use by child nodes. NAND controller which can be one of the children needs to use the GPMC register map.
> - Tricky to define multiple devices within a single chip select region.
> - Uses node name to identify device type like nand and onenand. Doesn't use compatible id for them.
> - GPMC CS properties are mixed with device properties, resulting in unnecessary binding documents like
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/net/gpmc-eth.txt
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
>
> To solve these issues, I'm proposing the following format
>
>         gpmc {
>                 ranges <0 0 IO_start IO_size            /* entire GPMC I/O space e.g. 1GB or 512MB */
>                         1 0 Reg_start Reg_size>;        /* GPMC register space */
>
>                 cs0 {
>                         ranges <0 0 IO_partition_start IO_partition_size>;      /* CS0 IO partition e.g. 16MB */
>
>                         gpmc,cs-num = <0>;              /* pass chip select number explicitly */
>                         <gpmc cs properties>;
>
>                         dev0 {
>                                 compatible = "<id for device on this chip select>";
>                                 reg = <0 IO_offset IO_size                      /* Device IO region e.g. 1KB */
>                                         1 Reg_offset Reg_size>;
>
>                                 <device specific properties>;
>                         };
>
>                         dev1 {
>                         ...
>                         };
>                 };
>
>                 cs1 {
>                         ...
>                 };
>         };
>
> All I'm doing is splitting up the CS node and the device node and removing the cs-num encoding from the ranges property.
> This results in a much cleaner DT binding and code.
>
> The format is similar to the one used by the ti-aemif driver.
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
>
> Having a unified format for all TI memory controllers will make life much easier for us.
>
> cheers,
> -roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
