From: John Rigby <jcrigby@gmail.com>
Subject: Re: Timeout after setting SD/MMC clock, bus width on 3530
Date: Wed, 7 Oct 2009 11:54:11 -0600
Message-ID: <4b73d43f0910071054t6d60ef9dg30b3cc5d918bdb95@mail.gmail.com>
References: <e0727e900910061418g565c17d9te1277811e1be17e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:54683 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759744AbZJGRys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 13:54:48 -0400
Received: by qyk32 with SMTP id 32so4531184qyk.1
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 10:54:11 -0700 (PDT)
In-Reply-To: <e0727e900910061418g565c17d9te1277811e1be17e6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Faith <jfaith7@gmail.com>
Cc: linux-omap@vger.kernel.org

Your board setup file in arch/arm/mach-omap2/whatever.c should have a
struct twl4030_hsmmc_info that sets up the platform dependent info
about your board:

static struct twl4030_hsmmc_info mmc[] =3D {
    {
        .mmc        =3D 1,
        .wires        =3D 4,
        .gpio_cd    =3D -EINVAL,
        .gpio_wp    =3D -EINVAL,
    },
    {}    /* Terminator */
};

I believe you can set wires to 1 to force it to only use 1 wire.


On Tue, Oct 6, 2009 at 3:18 PM, John Faith <jfaith7@gmail.com> wrote:
>
> Hi,
> I have a prototype board based on the 3530EVM which cannot read its
> microSD card. =A0I enabled CONFIG_MMC_DEBUG and other printks to the
> 2.6.29rc3 kernel and can see that info like the transfer rate is
> coming back but after I reach mmc_set_clock() and setting the bus
> width, I just get timeouts (output below).
>
> Looking at DAT0-3 on a scope, I see activity on DAT0, but the other
> lines just follow the MMC power, up for ~800ms then off.
>
> As an experiment, I tried commenting-out these 2 lines in
> drivers/mmc/host/omap_hsmmc.c:
> =A0mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> ...
> =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> in an attempt to use slow, 1-wire transfers, but that got me a panic
> in mmc_omap_irq().
>
> Assuming the hardware is functioning, is there a way to force the SD
> controller into its simplest/slowest mode to improve my chances of
> reading the card?
>
> Thanks!
> ,
> John
>
> ...
> mmc0: starting CMD9 arg 8fe40000 flags 00000007
> MMC: IRQ Status is 1
> drivers/mmc/core/sd.c 102 mmc_decode_csd() csd_struct=3D0
> =A0tacc_ns=3D0
> =A0tacc_clks=3D0
> =A0max_dtr=3D25000000
> =A0cmdclass=3D1461
> =A0capacity=3D7744512
> drivers/mmc/core/sd.c 67 mmc_decode_cid() manfid=3D3
> =A0prod_name=3DSU04G
> =A0card type=3D1
> =A0card state=3D8
> mmc0: starting CMD7 arg 8fe40000 flags 00000015
> MMC: IRQ Status is 1
> mmc0: starting CMD55 arg 8fe40000 flags 00000095
> MMC: IRQ Status is 1
> mmc0: starting CMD51 arg 00000000 flags 000000b5
> MMC: IRQ Status is 3
> drivers/mmc/core/sd.c 183 mmc_decode_scr()
> mmc0: starting CMD6 arg 00fffff1 flags 000000b5
> MMC: IRQ Status is 3
> drivers/mmc/core/sd.c 261 mmc_switch_hs()
> mmc0: starting CMD6 arg 80fffff1 flags 000000b5
> MMC: IRQ Status is 3
> card->csd.max_dtr=3D25000000
> mmc_card_highspeed true
> max_dtr=3D50000000
> drivers/mmc/core/core.c:443 mmc_set_clock()
> mmc_app_set_bus_width()
> mmc_app_set_bus_width MMC_BUS_WIDTH_4
> mmc0: starting CMD55 arg 8fe40000 flags 00000095
> MMC: IRQ Status is 18000
> mmc0: starting CMD55 arg 8fe40000 flags 00000095
> drivers/mmc/host/omap_hsmmc.c 535
> MMC: IRQ Status is 18000
> mmc0: starting CMD55 arg 8fe40000 flags 00000095
> MMC: IRQ Status is 18000
> mmc0: starting CMD55 arg 8fe40000 flags 00000095
> MMC: IRQ Status is 18000
> drivers/mmc/core/sd.c 559 mmc_app_set_bus_width failed
> mmc0: error -110 whilst initialising SD card
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
