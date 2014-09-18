From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 3/3] mtd: nand: Force omap_elm to be built as a module if
 omap2_nand is a module
Date: Thu, 18 Sep 2014 09:40:19 +0100
Message-ID: <CAAEAJfAQq=Nb6mBE=XX89-8ZptXWjMt2Nz-Sb9SDSKEUT0QFrg@mail.gmail.com>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1410443224-18477-4-git-send-email-ezequiel@vanguardiasur.com.ar>
	<5412B66F.8050505@ti.com>
	<20140912165636.GA7276@arch>
	<5416A2FF.3050503@ti.com>
	<20140918030049.GB8127@brian-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:63636 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbaIRIkV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 04:40:21 -0400
Received: by mail-qa0-f52.google.com with SMTP id m5so639305qaj.25
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2014 01:40:20 -0700 (PDT)
In-Reply-To: <20140918030049.GB8127@brian-ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, pekon <pekon@pek-sem.com>

On 18 September 2014 04:00, Brian Norris <computersforpeace@gmail.com> =
wrote:
> On Mon, Sep 15, 2014 at 11:27:43AM +0300, Roger Quadros wrote:
>> On 09/12/2014 07:56 PM, Ezequiel Garcia wrote:
>> > On 12 Sep 12:01 PM, Roger Quadros wrote:
>> >> On 09/11/2014 04:47 PM, Ezequiel Garcia wrote:
>> >>> This commit adds a hidden option to build the omap_elm as a modu=
le, if
>> >>> omap2_nand is a module (and similarly in the built-in case).
>> >>>
>> >>> This fixes the following build error when omap2_nand is chosen b=
uilt-in,
>> >>> and omap_elm is chosen as a module:
>> >>>
>> >>> drivers/built-in.o: In function `omap_nand_probe':
>> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:2010: undefined referen=
ce to `elm_config'
>> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1980: undefined referen=
ce to `elm_config'
>> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1927: undefined referen=
ce to `elm_config'
>> >>> drivers/built-in.o: In function `omap_elm_correct_data':
>> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1444: undefined referen=
ce to `elm_decode_bch_error_page'
>> >>>
>> >>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> >>> ---
>> >>>  drivers/mtd/nand/Kconfig  | 8 +++++++-
>> >>>  drivers/mtd/nand/Makefile | 2 +-
>> >>>  2 files changed, 8 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> >>> index f1cf503..12e8ee8 100644
>> >>> --- a/drivers/mtd/nand/Kconfig
>> >>> +++ b/drivers/mtd/nand/Kconfig
>> >>> @@ -96,7 +96,7 @@ config MTD_NAND_OMAP2
>> >>>
>> >>>  config MTD_NAND_OMAP_BCH
>> >>>   depends on MTD_NAND_OMAP2
>> >>> - tristate "Support hardware based BCH error correction"
>> >>> + bool "Support hardware based BCH error correction"
>> >>>   default n
>> >>>   select BCH
>> >>>   help
>> >>> @@ -106,6 +106,12 @@ config MTD_NAND_OMAP_BCH
>> >>>     legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM=
 engine
>> >>>     so they should not enable this config symbol.
>> >>>
>> >>> +config MTD_NAND_OMAP_BCH_BUILD
>> >>> + tristate
>> >>> + depends on MTD_NAND_OMAP2
>> >>> + default m if MTD_NAND_OMAP2=3Dm && MTD_NAND_OMAP_BCH
>> >>> + default y if MTD_NAND_OMAP2=3Dy && MTD_NAND_OMAP_BCH
>
> I think the last 2 lines could be combined:
>
>         default MTD_NAND_OMAP2 if MTD_NAND_OMAP_BCH
>
>> >>> +
>> >>>  config MTD_NAND_IDS
>> >>>   tristate
>> >>>
>> >>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefi=
le
>> >>> index 4bcdeb0..3580188 100644
>> >>> --- a/drivers/mtd/nand/Makefile
>> >>> +++ b/drivers/mtd/nand/Makefile
>> >>> @@ -27,7 +27,7 @@ obj-$(CONFIG_MTD_NAND_NDFC)             +=3D n=
dfc.o
>> >>>  obj-$(CONFIG_MTD_NAND_ATMEL)             +=3D atmel_nand.o
>> >>>  obj-$(CONFIG_MTD_NAND_GPIO)              +=3D gpio.o
>> >>>  obj-$(CONFIG_MTD_NAND_OMAP2)             +=3D omap2_nand.o
>> >>> -obj-$(CONFIG_MTD_NAND_OMAP_BCH)          +=3D omap_elm.o
>> >>> +obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)    +=3D omap_elm.o
>> >>>  obj-$(CONFIG_MTD_NAND_CM_X270)           +=3D cmx270_nand.o
>> >>>  obj-$(CONFIG_MTD_NAND_PXA3xx)            +=3D pxa3xx_nand.o
>> >>>  obj-$(CONFIG_MTD_NAND_TMIO)              +=3D tmio_nand.o
>
> Apparently I came up with a nearly identical solution, so it must be
> good! ;)
>
>> >> The overall logic seems to work but I still see the following iss=
ue.
>> >>
>> >> In menuconfig, the OMAP_BCH option is still visible as a boolean =
even though
>> >> the ELM module finally gets built as a module.
>> >> This can be confusing to the user and I'd avoid that behaviour.
>> >>
>> >
>> > Yes, I know. But it's either this solution or no solution at all, =
I think.
>> >
>> > Let me give some further context about this patch, so we can have =
more
>> > information to decide.
>> >
>> > First of all (and IMO) the user doesn't have to know about the ELM=
 being
>> > a module or not, because modprobe will load it (since omap2_nand d=
epends
>> > on omap_elm's symbols).
>> >
>> > So, the new way seems a bit more intuitive for me. The user choses=
 if he
>> > wants to have hardware BCH support, and such support gets built th=
e right
>> > way.
>> >
>> > If we still consider this highly confusing, and we want to avoid i=
t,
>> > then it seems we can only make omap_elm a boolean, which means it'=
ll always
>> > be built-in. I crafted this patch in an effort to avoid making it =
boolean.
>> >
>> > Finally, the solution is taken from media/usb/stk1160. For good or=
 for bad,
>> > we have a precedent in doing things this way.
>> >
>> > Ultimately, I don't care much as I don't think anyone will build i=
t as a module,
>> > except maybe for testing the driver under probe/remove cycles.
>> >
>> OK. I personally prefer boolean than the Kconfig magic as it makes m=
y life a bit
>> easier and less confusing to the user i.e. wysiwyg ;).
>>
>> Let's see what the MTD maintainers prefer.
>> Brian and David, any insights on this problem?
>
> It seems like 'elm' serves more as an accessory piece of omap2.{o,ko}=
,
> not really a separate module, so it's possible it'd make your life ev=
en
> easier to just link elm.o into omap2.o. There's no requirement that t=
wo
> source files create two separate kernel modules. I think this would
> present the simplest possible interface to the user.
>
> Thoughts?
>

Yeah, but that means a larger refactoring, because now you'd have to
call the ELM driver probe() from the NAND driver probe().

It'd be a nice cleanup, but maybe this is the second step?
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
