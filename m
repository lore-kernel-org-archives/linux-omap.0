From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 8/10] omap timer cleanup for v3.5 merge window
Date: Fri, 11 May 2012 00:07:37 -0700
Message-ID: <CAOesGMh3-fwR5nVR2kLd59itir+VSZkprjyAwf5nm1FStXGzSA@mail.gmail.com>
References: <E1SSYJA-0006UJ-4H@merlin.infradead.org>
	<20120510185130.GJ21851@atomide.com>
	<20120510202415.GO21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39928 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab2EKHHi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 03:07:38 -0400
Received: by yhmm54 with SMTP id m54so2285159yhm.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 00:07:37 -0700 (PDT)
In-Reply-To: <20120510202415.GO21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Rothwell <sfr@canb.auug.org.au>

[+sfr]

On Thu, May 10, 2012 at 1:24 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tony Lindgren <tony@atomide.com> [120510 11:55]:
>> * Tony Lindgren <tony@atomide.com> [120510 11:49]:
>> > The following changes since commit bfd17879866b36e95c58721da070d9f=
2ac7f8901:
>> >
>> > =A0 Merge tag 'omap-devel-c-for-3.5' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/pjw/omap-pending into devel-hwmod-data (2012-05-09 =
09:58:42 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >
>> > =A0 git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma=
p tags/omap-cleanup-timer-for-v3.5
>> >
>> > for you to fetch changes up to 1fe97c8f6a1de67a5f56e029a818903d5be=
d8017:
>> >
>> > =A0 ARM: OMAP: Make OMAP clocksource source selection using kernel=
 param (2012-05-09 10:07:05 -0700)
>> >
>> > ----------------------------------------------------------------
>> > Timer changes to make it easier to support various SoCs
>> >
>> > ----------------------------------------------------------------
>>
>> And this has a conflict for common headers:
> ...
>
> Also looks like this produces a merge conflict with linux-next
> commit bd0493ea (ARM: 7413/1: move read_{boot,persistent}_clock to
> the architecture level). To resolve, the line to add
> register_persistent_clock(NULL, omap_read_persistent_clock);
> needs to be resolved as below.

Thanks for the heads up. Stephen, see below for tomorrow's -next rebuil=
d.


-Olof

>
> Regards,
>
> Tony
>
>
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@@ -69,40 -69,55 +70,41 @@@ static void omap_read_persistent_clock(
> =A0 =A0 =A0 =A0*ts =3D *tsp;
> =A0}
>
> =A0-int __init omap_init_clocksource_32k(void)
> =A0+/**
> =A0+ * omap_init_clocksource_32k - setup and register counter 32k as =
a
> =A0+ * kernel clocksource
> =A0+ * @pbase: base addr of counter_32k module
> =A0+ * @size: size of counter_32k to map
> =A0+ *
> =A0+ * Returns 0 upon success or negative error code upon failure.
> =A0+ *
> =A0+ */
> =A0+int __init omap_init_clocksource_32k(void __iomem *vbase)
> =A0{
> =A0- =A0 =A0 =A0static char err[] __initdata =3D KERN_ERR
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: can't register c=
locksource!\n";
> =A0-
> =A0- =A0 =A0 =A0if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 pbase;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long size =3D SZ_4K;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0void __iomem *base;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0struct clk *sync_32k_ick;
> =A0-
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap16xx()) {
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pbase =3D OMAP16XX_TI=
MER_32K_SYNCHRONIZED;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D SZ_1K;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (cpu_is_omap2420())
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pbase =3D OMAP2420_32=
KSYNCT_BASE + 0x10;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (cpu_is_omap2430())
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pbase =3D OMAP2430_32=
KSYNCT_BASE + 0x10;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (cpu_is_omap34xx())
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pbase =3D OMAP3430_32=
KSYNCT_BASE + 0x10;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (cpu_is_omap44xx())
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pbase =3D OMAP4430_32=
KSYNCT_BASE + 0x10;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0-
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0/* For this to work we must have a st=
atic mapping in io.c for this area */
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0base =3D ioremap(pbase, size);
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!base)
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0-
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0sync_32k_ick =3D clk_get(NULL, "omap_=
32ksync_ick");
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!IS_ERR(sync_32k_ick))
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(sync_32k_i=
ck);
> =A0-
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0timer_32k_base =3D base;
> =A0-
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 120000 rough estimate from the cal=
culations in
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 * __clocksource_updatefreq_scale.
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0clocks_calc_mult_shift(&persistent_mu=
lt, &persistent_shift,
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A032768=
, NSEC_PER_SEC, 120000);
> =A0-
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clocksource_mmio_init(base, "32k_=
counter", 32768, 250, 32,
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0clocksource_mmio_readl_up))
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(err, "32k_coun=
ter");
> =A0-
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0setup_sched_clock(omap_32k_read_sched=
_clock, 32, 32768);
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0register_persistent_clock(NULL, omap_=
read_persistent_clock);
> =A0+ =A0 =A0 =A0int ret;
> =A0+
> =A0+ =A0 =A0 =A0/*
> =A0+ =A0 =A0 =A0 * 32k sync Counter register offset is at 0x10
> =A0+ =A0 =A0 =A0 */
> =A0+ =A0 =A0 =A0sync32k_cnt_reg =3D vbase + OMAP2_32KSYNCNT_CR_OFF;
> =A0+
> =A0+ =A0 =A0 =A0/*
> =A0+ =A0 =A0 =A0 * 120000 rough estimate from the calculations in
> =A0+ =A0 =A0 =A0 * __clocksource_updatefreq_scale.
> =A0+ =A0 =A0 =A0 */
> =A0+ =A0 =A0 =A0clocks_calc_mult_shift(&persistent_mult, &persistent_=
shift,
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A032768, NSEC_PER_SEC, =
120000);
> =A0+
> =A0+ =A0 =A0 =A0ret =3D clocksource_mmio_init(sync32k_cnt_reg, "32k_c=
ounter", 32768,
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0250, =
32, clocksource_mmio_readl_up);
> =A0+ =A0 =A0 =A0if (ret) {
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("32k_counter: can't register c=
locksource\n");
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
> =A0+
> =A0+ =A0 =A0 =A0setup_sched_clock(omap_32k_read_sched_clock, 32, 3276=
8);
> =A0+ =A0 =A0 =A0pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n"=
);
> ++ =A0 =A0 =A0register_persistent_clock(NULL, omap_read_persistent_cl=
ock);
> =A0+
> =A0 =A0 =A0 =A0return 0;
> =A0}
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
