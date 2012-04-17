From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Wed, 18 Apr 2012 00:50:56 +0300
Message-ID: <CANOLnONNMPzu4GyLd_vr4qaDwqUoRHMpKaiE-GQOJDDd2VL8Jw@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38643 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab2DQVu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 17:50:57 -0400
Received: by iagz16 with SMTP id z16so9482289iag.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 14:50:57 -0700 (PDT)
In-Reply-To: <87y5puwhus.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Tue, Apr 17, 2012 at 5:30 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>>
>> Ok I did some tests, all in mostly idle system with just init, busyb=
ox
>> shell and dd doing a NAND read to /dev/null .
>
> Hmm, I seem to get a hang using dd to read from NAND /dev/mtdX on my
> Overo. =C2=A0I saw your patch 'mtd: omap2: fix resource leak in prefe=
tch-busy
> path' but that didn't seem to help my crash.

I see overo doesn't set 16bit flag, I think it has NAND on 16bit bus?
Perhaps try this:

--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -517,7 +517,7 @@ static void __init overo_init(void)
        omap_serial_init();
        omap_sdrc_init(mt46h32m32lf6_sdrc_params,
                                  mt46h32m32lf6_sdrc_params);
-       omap_nand_flash_init(0, overo_nand_partitions,
+       omap_nand_flash_init(NAND_BUSWIDTH_16, overo_nand_partitions,
                             ARRAY_SIZE(overo_nand_partitions));
        usb_musb_init(NULL);
        usbhs_init(&usbhs_bdata);

Also only pandora is using NAND DMA mode right now in mainline, the
default polling mode won't exhibit the latency problem (with all other
polling consequences like high CPU usage), so this is needed too for
the test:

--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -127,6 +127,7 @@ void __init omap_nand_flash_init(int options,
struct mtd_partition *parts,
                nand_data.parts =3D parts;
                nand_data.nr_parts =3D nr_parts;
                nand_data.devsize =3D options;
+               nand_data.xfer_type =3D NAND_OMAP_PREFETCH_DMA;

                printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
                if (gpmc_nand_init(&nand_data) < 0)

I also forgot to mention I was using ubifs in my test (dd'ing large
file from it), I don't think it has much effect, but if you want to
try with that:
=2Econfig
CONFIG_MTD_UBI=3Dy
CONFIG_UBIFS_FS=3Dy
--
ubiformat /dev/mtdX -s 512
ubiattach /dev/ubi_ctrl -m X # X from mtdX
ubimkvol /dev/ubi0 -m -N somename
mount -t ubifs ubi0:somename /mnt

>> To me it looks like this results from many small things adding up..
>> Idle is called so often that pwrdm_p*_transition() and those
>> pwrdm_for_each_clkdm() walks start slowing everything down, perhaps
>> because they access lots of registers on slow buses?
>
> Yes PRCM register accesses are unfortunately rather slow, and we've
> known that for some time, but haven't done any detailed analysis of t=
he
> overhead.
>
> Using the function_graph tracer, I was able to see that the pre/post
> transition are taking an enormous amount of time:
>
> =C2=A0- pwrdm pre-transition: 1400+ us at 600MHz (4000+ us at 125MHz)
> =C2=A0- pwrdm post-transtion: 1600+ us at 600MHz (6000+ us at 125MHz)

Hmm, with this it wouldn't be able to do ~500+ calls/sec I was seeing,
so the tracer overhead is probably quite large too..

> Notice the big difference between 600MHz OPP and 125MHz OPP. =C2=A0Ar=
e you
> using CPUfreq at all in your tests? =C2=A0If using cpufreq + ondemand
> governor, you're probably running at low OPP due to lack of CPU activ=
ity
> which will also affect the latencies in the idle path.

I used performance governor in my tests, so it all was at 600MHz.

> I'm looking into this in more detail know, and will likely have a few
> patches for you to experiment with.

Sounds good,


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
