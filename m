From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 0/9] ARM: dts: omap2+: GPMC NAND node fixes
Date: Mon, 29 Feb 2016 18:13:48 +0200
Message-ID: <56D46E3C.5000908@ti.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
 <20160226184431.GB13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160226184431.GB13417-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 26/02/16 20:44, Tony Lindgren wrote:
> Hi,
> 
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [160223 08:37]:
>> Hi Tony,
>>
>> These patches are a preparatory step towards the NAND DT cleanup
>> done in [1].
> 
> OK great NAND keeps working for me. I've pushed these into an
> immutable branch against v4.5-r1 named omap-for-v4.6/dt-gpmc.
> 
> I have also merged that branch into omap-for-v4.6/dt.
> 
> Please feel free to use omap-for-v4.6/dt-gpmc branch as an
> immutable base for the GPMC driver changes.

Thanks.

> 
> And please let me know what additional patches I may need to
> apply into omap-for-v4.6/dt for new files that are not in
> omap-for-v4.6/dt-gpmc.

We need to fix the following
gpmc node in dm814x.dtsi + nand node in dra62x-j5eco-evm.dts + nand node in dm8148-evm.


> 
> Note that I also fixed two typos below:

Thanks :)

cheers,
-roger

> 
>> Roger Quadros (9):
>>   ARM: dts: dra7: Fix NAND device nodes.
> 
> I removed the trailing period here.
> 
>>   ARM: dts: dra7: Remove redundant nand property
>>   ARM: dts: am437x: Fix NAND device nodes
>>   ARM: dts: am437x: Disable wait pin monitoring for NAND
>>   ARM: dts: am335x: Fix NAND device nodes
>>   ARM: dts: am335x: Disable wait pin monitoring for NAND
>>   ARM: dts: dm816x: Fix NAND device nodes
>>   ARM: dts: dm8168-evm: ARM: dts: Disable wait pin monitoring for NAND
>>   ARM: dts: omap3: Fix NAND device nodess
> 
> I removed the extra s in nodes here.
> 
> Regards,
> 
> Tony
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
