From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v6 4/4] ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
Date: Thu, 26 Sep 2013 15:26:11 +0200
Message-ID: <CAAwP0s1J8=_0bz5Cryjuy4EL4Ky9f33Bm6zZ-x+jm=EGh+VGiQ@mail.gmail.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-5-git-send-email-pekon@ti.com> <20130925191559.GF23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA16D3D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62739 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab3IZN0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 09:26:32 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA16D3D@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "olof@lixom.net" <olof@lixom.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Rob Herring (robherring2@gmail.com)" <robherring2@gmail.com>, "Mark Rutland (mark.rutland@arm.com)" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Stephen Warren <swarren@wwwdotorg.org>

On Thu, Sep 26, 2013 at 1:28 PM, Gupta, Pekon <pekon@ti.com> wrote:
>> From: Brian Norris [mailto:computersforpeace@gmail.com]
>>
>> On Thu, Sep 12, 2013 at 05:20:19PM +0530, Pekon Gupta wrote:
>> > DT property values for OMAP based gpmc-nand have been updated
>> > to match changes in commit:
>> >     6faf096 ARM: OMAP2+: cleaned-up DT support of various ECC
>> schemes
>>
>> Whose commit ID is this? Your patch is not merged yet, so don't use a
>> commit ID.
>>
>> > Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> >
>> > Signed-off-by: Pekon Gupta <pekon@ti.com>
>> > ---
>> >  arch/arm/boot/dts/am335x-evm.dts | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/boot/dts/am335x-evm.dts
>> b/arch/arm/boot/dts/am335x-evm.dts
>> > index e8ec875..e28a2ac 100644
>> > --- a/arch/arm/boot/dts/am335x-evm.dts
>> > +++ b/arch/arm/boot/dts/am335x-evm.dts
>> > @@ -268,7 +268,7 @@
>> >                     nand@0,0 {
>> >                             reg = <0 0 0>; /* CS0, offset 0 */
>> >                             nand-bus-width = <8>;
>> > -                           ti,nand-ecc-opt = "bch8";
>> > +                           ti,nand-ecc-scheme = "bch8";
>> >                             gpmc,device-nand = "true";
>> >                             gpmc,device-width = <1>;
>> >                             gpmc,sync-clk-ps = <0>;
>>
>> This change should probably go in patch 1 anyway, when you break the
>> ABI.
>>
> As this patch series touches three different trees..
> (1) arch/arm/boot/dts/..  maintained by Benoit Cousson (benoit.cousson@linaro.org)

Hi Pekon,

Please note that Benoit's current email address is bcousson@baylibre.com.

I had cc'ed him now with the correct address.

> (2) arch/arm/mach-omap2/.. maintained by Tony Lindgren (tony@atomide.com)
> (3) driver/mtd/nand/.. maintained by Brian Norris <computersforpeace@gmail.com>
>
> It was observed that there were conflicts usually during final merge,
> Hence I separated out the patches.
> However, if all are in sync and the series gets committed in above trees
> simultaneously, then this conflicts can be avoided.
> So, if Tony & Benoit are ok then I'll merge this [PATCH 4/4] in [PATCH 1/4].
>
> with regards, pekon
> --

Best regards,
Javier
