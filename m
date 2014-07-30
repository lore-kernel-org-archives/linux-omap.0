From: Pekon Gupta <pekon.gupta@gmail.com>
Subject: Re: [PATCH] ARM: dts: dra7-evm: add parallel NOR flash support
Date: Thu, 31 Jul 2014 01:10:17 +0530
Message-ID: <CAK1JQxoJMAGqRCYxJBCLp0_0QN+t7COmxU01wSWVjPR0AY0LdQ@mail.gmail.com>
References: <1406113130-23939-1-git-send-email-pekon@ti.com>
	<53D7904C.20600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:52916 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaG3TkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jul 2014 15:40:19 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so1724266wgg.24
        for <linux-omap@vger.kernel.org>; Wed, 30 Jul 2014 12:40:18 -0700 (PDT)
In-Reply-To: <53D7904C.20600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

Hi Roger,

On Tue, Jul 29, 2014 at 5:45 PM, Roger Quadros <rogerq@ti.com> wrote:
> On 07/23/2014 01:58 PM, Pekon Gupta wrote:
> > This patch adds support for parallel NOR device (S29GL512S10) present on J6-EVM.
> > The Flash device is connected to GPMC controller on chip-select[0] and accessed
> > as memory-mapped device. It has data-witdh=x16, capacity-64MBytes(512Mbits) and
> > is CFI compatible.
> > As multiple devices are share GPMC pins on this board, so following board
> > settings are required to detect NOR device:
> >      SW5.1 (NAND_BOOTn) = OFF (logic-1)
> >      SW5.2 (NOR_BOOTn)  = ON  (logic-0) /* Active-low */
> >      SW5.3 (eMMC_BOOTn) = OFF (logic-1)
> >      SW5.4 (QSPI_BOOTn) = OFF (logic-1)
>
> Why does NOR have any dependency on states of eMMC_BOOTn and QSPI_BOOTn?
>
If you see the schematics of J6-EVM, GPMC data and control lines are shared
between NAND, NOR, eMMC (and probably QSPI also).
I don't have access to TI's hardaware or board schematics anymore, so
please double check.

> >
> > Also to maintain NAND Boot functionality, following setting are kept as default
> > - NAND status="enabled"
> > - NOR status="disabled"
>
> Too bad they designed the hardware so that either NOR or NAND can be used at a time.
> Better to mention about this limitation by stating that CS0 is shared between NOR and NAND
> and only one can be used at a time.
>
NAND/NOR/eMMC/QSPI effectively all are storage devices, so users may
not use all of
them at once, so may be to optimize usage of pins they added multiple
devices on CS0.
Sorry, I may not be able to re-spin this patch anytime soon, as I have
no access to TI
resources so request you to please re-send it with appropriate commit
log change as you wish.

> >
> > Signed-off-by: Pekon Gupta <pekon@ti.com>
> > ---
> >
> > /* Flash read/write access tested after enabling NOR sub-node in DT */
> >    linux#> flash_erase /dev/mtd9 0 0
> >    linux#> dd if=/dev/urandom of=/tmp/source.hex  bs=1c count=2048
> >    linux#> mtd_debug write /dev/mtd9 0x0 2048 /tmp/source.hex
> >    linux#> mtd_debug read  /dev/mtd9 0x0 2048 /tmp/destination.hex
> >    linux#> diff /tmp/source.hex  /tmp/destination.hex
> >
> >
> >  arch/arm/boot/dts/dra7-evm.dts | 141 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 140 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> > index 4adc280..1ee9727 100644
> > --- a/arch/arm/boot/dts/dra7-evm.dts
> > +++ b/arch/arm/boot/dts/dra7-evm.dts
> > @@ -151,6 +151,66 @@
> >                       0xd0    (PIN_OUTPUT | MUX_MODE0)        /* gpmc_be0n_cle */
> >               >;
> >       };
> > +
> > +     nor_flash_x16: nor_flash_x16 {
> > +             /* On DRA7 EVM, NOR_BOOTn comes from DIP switch
> > +              * So NOR flash requires following switch settings:
> > +              * SW5.1 (NAND_BOOTn) = OFF (logic-1)
> > +              * SW5.2 (NOR_BOOTn)  = ON  (logic-0) Active-low
> > +              * SW5.3 (eMMC_BOOTn) = OFF (logic-1)
> > +              * SW5.4 (QSPI_BOOTn) = OFF (logic-1)
> > +              */
>
> The only requirement for NOR_BOOTn is SW5.2 = ON and SW5.1 (NAND_BOOTn) = OFF.
>
As mentioned above, please check board schematics
IIRC, GPMC lines pass through various levels of on-board
bi-directional multiplexers,
And 'select' lines of these multiplexers are controlled indirectly via
these xxx_BOOTn switches.

[...]

> >  &i2c1 {
> > @@ -417,8 +477,9 @@
> >       status = "okay";
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&nand_flash_x16>;
> > -     ranges = <0 0 0 0x01000000>;    /* minimum GPMC partition = 16MB */
> > +     ranges = <0 0 0x08000000 0x04000000>;   /* address offset=128MB, range=512Mb=64MB */
> >       nand@0,0 {
> > +             status = "okay";
>
> Not needed. If it is not explicitly disabled it is always enabled by default.
>
Yes, but good to have clarity in DTS, as most users will just copy-paste TI-EVM
DTS and then tweak it for their own custom board DTS. So better to have this
mentioned explicitely.


with regards, pekon
