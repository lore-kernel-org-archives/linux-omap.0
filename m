From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/6] HACK: arm: reprogram twd based on clk notifier
Date: Wed, 14 Dec 2011 09:52:43 +0100
Message-ID: <CACRpkdYok311RJKsz55mA=Wd0fSjmSwjhYMgeMdLXCwb9OnwJw@mail.gmail.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
	<1323837088-2469-7-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53373 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab1LNIwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 03:52:45 -0500
Received: by iaeh11 with SMTP id h11so930108iae.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 00:52:44 -0800 (PST)
In-Reply-To: <1323837088-2469-7-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux@arm.linux.org.uk, andrew@lunn.ch, linaro-dev@lists.linaro.org, tony@atomide.com, eric.miao@linaro.org, jeremy.kerr@canonical.com, khilman@ti.com, sboyd@quicinc.com, magnus.damm@gmail.com, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, rnayak@ti.com, tglx@linutronix.de, linux-omap@vger.kernel.org, linus.walleij@stericsson.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, skannan@quicinc.com

Hi Mike,

I just sent new patches for the TWD CPUfreq stuff, including the bug fi=
x you
provide below for clk_prepare(). They're in Russell's patch tracker:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D7210/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D7211/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D7212/1

On Wed, Dec 14, 2011 at 5:31 AM, Mike Turquette <mturquette@ti.com> wro=
te:

> The primary purpose behind this change is to test the new clk notifie=
r
> code. =A0If you find it useful beyond that, please let me know!

This is way more elegant that the cpufreq way of doing things.
=46or several years I was confused by TI:s way of re-reading any
peripheral clock speed in CPUfreq notifiers when there was strictly
no theoretical requirement for the CPU to actually change it's frequenc=
y
when the clock frequency for that particular device changed.

See for example drivers/mmc/host/davinci_mmc.c:

#ifdef CONFIG_CPU_FREQ
static int mmc_davinci_cpufreq_transition(struct notifier_block *nb,
                                     unsigned long val, void *data)
{
        struct mmc_davinci_host *host;
        unsigned int mmc_pclk;
        struct mmc_host *mmc;
        unsigned long flags;

        host =3D container_of(nb, struct mmc_davinci_host, freq_transit=
ion);
        mmc =3D host->mmc;
        mmc_pclk =3D clk_get_rate(host->clk);

        if (val =3D=3D CPUFREQ_POSTCHANGE) {
                spin_lock_irqsave(&mmc->lock, flags);
                host->mmc_input_clk =3D mmc_pclk;
                calculate_clk_divider(mmc, &mmc->ios);
                spin_unlock_irqrestore(&mmc->lock, flags);
        }

        return 0;
}


=2E..what does the CPU has to do with the MMC host->clk again?
Absolutely nothing. There is no point in the MMC framework
knowing that the CPU is changing operating point.
(There is a similar hack in the s3c MMC driver.)

The clk notifiers are the sane way of doing this.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
