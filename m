From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv5 01/11] OMAP: prcm: switch to a chained IRQ handler mechanism
Date: Fri, 15 Jul 2011 18:53:00 +0530
Message-ID: <CAAL8m4yyw5iYmHcpOJuOU_XGfnJuiUigjEkuNYQdQJxGPRyJMw@mail.gmail.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com> <1309861677-2769-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43049 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1GONXY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 09:23:24 -0400
Received: by ewy4 with SMTP id 4so646286ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Jul 2011 06:23:23 -0700 (PDT)
In-Reply-To: <1309861677-2769-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, Jul 5, 2011 at 3:57 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Introduce a chained interrupt handler mechanism for the PRCM
> interrupt, so that individual PRCM event can cleanly be handled by
> handlers in separate drivers. We do this by introducing PRCM event
> names, which are then matched to the particular PRCM interrupt bit
> depending on the specific OMAP SoC being used.
>
> arch/arm/mach-omap2/prcm.c implements the chained interrupt mechanism
> itself, with individual PRCM events for OMAP3 and OMAP4 being
> described in arch/arm/mach-omap2/prcm3xxx.c and
> arch/arm/mach-omap2/prcm4xxx.c respectively. At initialization time,
> the set of PRCM events is filtered against the SoC on which we are
> running, keeping only the ones that are actually useful. All the logi=
c
> is written to be generic with regard to OMAP3/OMAP4, even though OMAP=
3
> has single PRCM event registers and OMAP4 has two PRCM event
> registers.
>
> Patch tested on OMAP3 beagleboard.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Avinash.H.M <avinashhm@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 | =A0108 ++++++++=
--------------
> =A0arch/arm/mach-omap2/prcm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0158 ++++++=
++++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/prcm3xxx.c =A0 =A0 =A0 =A0 | =A0112 ++++++++++=
++++++++++++
> =A0arch/arm/mach-omap2/prcm4xxx.c =A0 =A0 =A0 =A0 | =A0137 ++++++++++=
+++++++++++++++++
> =A0arch/arm/plat-omap/include/plat/prcm.h | =A0 46 +++++++++
> =A06 files changed, 495 insertions(+), 70 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/prcm3xxx.c
> =A0create mode 100644 arch/arm/mach-omap2/prcm4xxx.c
>

[..]

> + =A0 =A0 =A0 if (irq_setup->base_irq < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("PRCM: failed to allocate irq de=
scs\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_set_chained_handler(irq_setup->irq,=
 NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq_setup->base_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i <=3D max_irq / 32; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc =3D irq_alloc_generic_chip("PRCM", 1=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_setup->base_irq + i=
 * 32, NULL, handle_level_irq);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ct =3D gc->chip_types;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ct->chip.irq_ack =3D irq_gc_ack;


With patch [1] already part of 3.0-rc7 Mainline.

irq_gc_ack needs to be changed as below.

ct->chip.irq_ack =3D irq_gc_ack_set_bit;

I dropped tmp patches from v5 and picked rest of v5 applied
on wip-runtime patches and tested same.

Most of the things worked fine on 3430SDP
System wide suspend (with console_suspend)
retention and off-mode.

I have hosted a branch with the same if some else
is interested in testing.

[rc7 + wip_uart runtime patches + irq_chaining patches]

git://gitorious.org/runtime_3-0/runtime_3-0.git
Branch: wip_irqchn

feel free to add,

Acked-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>

--
Thanks,
Govindraj.R

[1]:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D659fb32d1b67476f4ade25e9ea0e2642a5b9c4b5;hp=3Dd30e1521b2=
afb5e6f21ca8bc1a4b6ec2afc93597
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
