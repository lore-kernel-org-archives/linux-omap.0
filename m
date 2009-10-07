From: John Faith <jfaith7@gmail.com>
Subject: Re: Timeout after setting SD/MMC clock, bus width on 3530
Date: Wed, 7 Oct 2009 13:05:18 -0700
Message-ID: <e0727e900910071305h2831ee4cxc90ff8c351d88cc5@mail.gmail.com>
References: <e0727e900910061418g565c17d9te1277811e1be17e6@mail.gmail.com>
	 <4b73d43f0910071054t6d60ef9dg30b3cc5d918bdb95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f178.google.com ([209.85.223.178]:63565 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759975AbZJGUFz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 16:05:55 -0400
Received: by iwn8 with SMTP id 8so3027545iwn.33
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 13:05:18 -0700 (PDT)
In-Reply-To: <4b73d43f0910071054t6d60ef9dg30b3cc5d918bdb95@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi John,
Thanks for the suggestion.  I tried changing to ".wires=3D1", but it
again ended in a panic in mmc_omap_irq(), so I must be missing another
piece.

On your other suggestion (off-list) I'm also investigating the CPU
pbias_mmc1 pin which the datasheet errata says should not be
connected.  Our board has this connected to VMMC, and I noticed that
this signal is not even listed in the BeagleBoard schematic (implied
NC?).


Thanks,
John


On Wed, Oct 7, 2009 at 10:54 AM, John Rigby <jcrigby@gmail.com> wrote:
> Your board setup file in arch/arm/mach-omap2/whatever.c should have a
> struct twl4030_hsmmc_info that sets up the platform dependent info
> about your board:
>
> static struct twl4030_hsmmc_info mmc[] =3D {
> =A0 =A0{
> =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0=3D 1,
> =A0 =A0 =A0 =A0.wires =A0 =A0 =A0 =A0=3D 4,
> =A0 =A0 =A0 =A0.gpio_cd =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0.gpio_wp =A0 =A0=3D -EINVAL,
> =A0 =A0},
> =A0 =A0{} =A0 =A0/* Terminator */
> };
>
> I believe you can set wires to 1 to force it to only use 1 wire.
>
>
> On Tue, Oct 6, 2009 at 3:18 PM, John Faith <jfaith7@gmail.com> wrote:
>>
>> Hi,
>> I have a prototype board based on the 3530EVM which cannot read its
>> microSD card. =A0I enabled CONFIG_MMC_DEBUG and other printks to the
>> 2.6.29rc3 kernel and can see that info like the transfer rate is
>> coming back but after I reach mmc_set_clock() and setting the bus
>> width, I just get timeouts (output below).
>>
>> Looking at DAT0-3 on a scope, I see activity on DAT0, but the other
>> lines just follow the MMC power, up for ~800ms then off.
>>
>> As an experiment, I tried commenting-out these 2 lines in
>> drivers/mmc/host/omap_hsmmc.c:
>> =A0mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
>> ...
>> =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>>
>> in an attempt to use slow, 1-wire transfers, but that got me a panic
>> in mmc_omap_irq().
>>
>> Assuming the hardware is functioning, is there a way to force the SD
>> controller into its simplest/slowest mode to improve my chances of
>> reading the card?
>>
=2E..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
