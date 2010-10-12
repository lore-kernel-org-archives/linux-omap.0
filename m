From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP: control: add functions for DSP boot
 address/mode control
Date: Tue, 12 Oct 2010 13:58:37 -0700
Message-ID: <20101012205837.GZ25462@atomide.com>
References: <20101011203659.24425.2381.stgit@twilight.localdomain>
 <20101011203710.24425.94685.stgit@twilight.localdomain>
 <AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com>
 <alpine.DEB.2.00.1010111449240.16871@utopia.booyaka.com>
 <20101011211616.GE25462@atomide.com>
 <alpine.DEB.2.00.1010111519410.16871@utopia.booyaka.com>
 <AANLkTinwZ87BepJE9RuxJ6BitQ9N5dWTDT7WZTJHNqNO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50667 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0JLV30 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 17:29:26 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinwZ87BepJE9RuxJ6BitQ9N5dWTDT7WZTJHNqNO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, fernando.lugo@ti.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [101012 03:52]:
> On Tue, Oct 12, 2010 at 12:35 AM, Paul Walmsley <paul@pwsan.com> wrot=
e:
> > On Mon, 11 Oct 2010, Tony Lindgren wrote:
> >> Would be nice to get the dspbridge into working shape. Sounds we s=
till
> >> need the following:
> >>
> >> - memblock fixes
> >> - this series to fix the control module related issues
> >> - platform data for the boards
> >>
> >> Is that all, or are we also missing something else?
> >
> > A few other things should be done also.
> >
> > 1. Most of the code in drivers/staging/tidspbridge/code/tiomap3430.=
c in
> > the bridge_brd_monitor(), bridge_brd_start(), and bridge_brd_stop()=
 should
> > be moved into a file in arch/arm/mach-omap2. =C2=A0The DSPBridge dr=
iver should
> > call those functions (to reset the DSP, start it, etc.) through
> > platform_data function pointers. =C2=A0Once that happens, patch 3 o=
f the
> > control module-related series would not be needed, since that code =
would
> > be in arch/arm/mach-omap2 anyway.
> >
> > 2. The direct CM/PRM/RM register access should be removed from that
> > arch/arm/mach-omap2 code. =C2=A0That should be handled directly by =
the
> > clock/hwmod/whatever code.
> >
> > 3. DSPBridge should be converted to use PM runtime, and the
> > arch/arm/mach-omap2 portion should use omap_device, omap_hwmod, etc=
=2E
>=20
> Before starting to clean things up, I would rather have something tha=
t
> works, which AFAIK includes:
>=20
>  1) revert or fix iommu migration
>  2) fix ioremap() usage on RAM
>=20
> Only then we can have some minimal confidence that the cleaning up is
> not introducing further breakage.

Well we should get it working, but we should also do it in a sane way :=
)

I guess you're now looking into this patch from Russell?

https://patchwork.kernel.org/patch/245631/

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
