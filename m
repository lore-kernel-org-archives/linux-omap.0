From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be
 used on both cpus
Date: Fri, 3 Aug 2012 10:32:01 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7F6AC@DBDE01.ent.ti.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
 <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
 <501B7AE6.8080405@gmail.com>
 <76308EBE-F802-411A-973A-7BBC7575FE5A@dominion.thruhere.net>
 <BDB76D4F-31B0-47D0-B1A1-64A743D091D3@dominion.thruhere.net>
 <CAMQu2gxLAVk-LN8R1xBeeL1=iZ-mLSRmtZe4wpQYQPTBsY5RMA@mail.gmail.com>
 <FF29FBF3-67EC-478E-9A74-65F8A2870BDC@dominion.thruhere.net>
 <79CD15C6BA57404B839C016229A409A83EA7F59B@DBDE01.ent.ti.com>
 <CAMQu2gzgfbeB0D18fKhmOaKUkY8Q_px+k9dq+jKEHc3YEuMMVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40838 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab2HCKcM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 06:32:12 -0400
In-Reply-To: <CAMQu2gzgfbeB0D18fKhmOaKUkY8Q_px+k9dq+jKEHc3YEuMMVQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, Daniel Mack <zonque@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ccross@android.com" <ccross@android.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Aug 03, 2012 at 15:18:15, Shilimkar, Santosh wrote:
> On Fri, Aug 3, 2012 at 3:12 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Fri, Aug 03, 2012 at 15:03:07, Koen Kooi wrote:
> >>
> >> Op 3 aug. 2012, om 11:27 heeft "Shilimkar, Santosh" <santosh.shilimkar@ti.com> het volgende geschreven:
> >>
> >> > On Fri, Aug 3, 2012 at 2:00 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
> >> >>
> >> >> Op 3 aug. 2012, om 09:21 heeft Koen Kooi <koen@dominion.thruhere.net> het volgende geschreven:
> >> >>
> >> >>>
> >> >>> Op 3 aug. 2012, om 09:16 heeft Daniel Mack <zonque@gmail.com> het volgende geschreven:
> >> >>>
> >> >>>> On 30.03.2012 15:27, Santosh Shilimkar wrote:
> >> >>>>> For coupled cpuidle to work when both cpus are active, it needs a global timer
> >> >>>>> that can handle events for both cpus.  This timer is used as the broadcast
> >> >>>>> clock-event when the per-cpu timer hardware stop in low power states.
> >> >>>>> Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
> >> >>>>> set the irq to allow the clockevent core to determine the affinity of the
> >> >>>>> timer.
> >> >>>>
> >> >>>> These patches made it to mainline now, shortly befor 3.6-rc1, and it
> >> >>>> breaks boot on my AM33xx board.
> >> >>>>
> >> >>>> Once I revert 1/3, the board boots again but crashes with the Ooops
> >> >>>> below. With the entire series reverted, everything works again as
> >> >>>> expected. Any idea?
> >> >>>>
> >> >>>> The upstream commit ids are
> >> >>>>
> >> >>>> 11d6ec2e "ARM: OMAP: timer: allow gp timer clock-event to be used on
> >> >>>> both cpus"
> >> >>>> 5b4d5bcc "ARM: OMAP4: CPUidle: add synchronization for coupled idle states"
> >> >>>> b93d70ae "ARM: OMAP4: CPUidle: Open broadcast clock-event device."
> >> >>>
> >> >>> I've had boot problems with cpuidle enabled as well, what happens if you disable it? Is the revert still needed in that case?
> >> >>
> >> >> To answer my own question: No, the reverts aren't needed if you disable cpuidle.
> >> >
> >> > This is really strange since CPUIDLE code is really OMAP4 specific.
> >> > obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
> >> >
> >> > May be omap2plus build some how the code gets executed on AMXX
> >> >
> >> > Can you try below and see if the boot with CPUIDLE enabled goes away on
> >> > AMXX
> >> >
> >> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> >> > index ea24174..195e756 100644
> >> > --- a/arch/arm/mach-omap2/pm44xx.c
> >> > +++ b/arch/arm/mach-omap2/pm44xx.c
> >> > @@ -147,6 +147,9 @@ int __init omap4_pm_init(void)
> >> >        struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
> >> >        struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
> >> >
> >> > +       if (!cpu_is_omap44xx())
> >> > +               return -ENODEV;
> >> > +
> >> >        if (omap_rev() == OMAP4430_REV_ES1_0) {
> >> >                WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
> >> >                return -ENODEV;
> >>
> >> That does seem to fix it:
> >>
> >> root@beaglebone:~# zcat /proc/config.gz | grep -i cpu_idle
> >> CONFIG_CPU_IDLE=y
> >> CONFIG_CPU_IDLE_GOV_LADDER=y
> >> CONFIG_CPU_IDLE_GOV_MENU=y
> >> CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y
> >> root@beaglebone:~# zcat /proc/config.gz | grep -i omap4
> >> CONFIG_ARCH_OMAP4=y
> >> CONFIG_MACH_OMAP4_PANDA=y
> >> # CONFIG_OMAP4_ERRATA_I688 is not set
> >> # CONFIG_KEYBOARD_OMAP4 is not set
> >> CONFIG_OMAP4_DSS_HDMI=y
> >>
> >
> > This patch is not required, Without this patch is works for me,
> >
> Which is good news.Do you have CPUIDLE enabled in your build when you tested
> it. Note that CPUIDLE is not enabled by-default in omap2plus build and as I see
> from Koen's email, he did enable it in his testing.
> 
> Please confirm that 3.6-rc1 boots fine even with CPUIDLE enabled and
> we don't need
> the above mentioned patch. If it is not the case, I can post the fix.
> 

Just FYI, I have also tested with CPUIDLE enabled and it worked for me.

Thanks,
Vaibhav
