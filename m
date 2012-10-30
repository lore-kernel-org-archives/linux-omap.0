From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
Date: Mon, 29 Oct 2012 19:35:54 -0500
Message-ID: <CAD=GYpbBc-zTpkvWrf-4AYQy0dUniCML5ndC4cQfzOJ1MOU0mw@mail.gmail.com>
References: <1349879449-22657-1-git-send-email-mporter@ti.com>
	<1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

[resending, because the first post got rejected due to non-plaintext]

Hi Guraraja,

I am interested in this thread. I've been trying Gururaja's patches for
audio as well.

I rebased =A0Guraja's patches on top of Matt's EDMA patches which were
applied to the beaglebone 3.7 kernel repo. With some fixes to make it
compile with CONFIG_DUMMY_REGULATOR enabled, Currently it breaks at
set_dai_fmt in davinci-mcasp.c when an audio file is played.

Could you try my tree on EVM? =A0dts changes may be required to use mca=
sp1 on
EVM, https://github.com/joelagnel/linux-kernel/commits/3.7

v3.7-rc2-fixes to v3.7-rc2-audio commits are Gururaja's patches which I
applied, and after that are my commits to enable config , add dt data a=
nd
some fixes.

Thanks,
Joel

On Mon, Oct 29, 2012 at 10:45 AM, Hebbar, Gururaja
<gururaja.hebbar@ti.com> wrote:
>
> Matt,
>
> On Wed, Oct 10, 2012 at 20:00:49, Porter, Matt wrote:
> > 6ea74cb ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usa=
ge
> > exposes a bug in the AM33XX clock data for mcasp. After moving to
> > clk_get() usage, the _init() of all registered hwmods fails on mcas=
p0
> > due to incorrect clock data causing clk_get() to fail. This causes =
all
> > successive hwmods to fail to _init() leaving them in a bad state.
> >
> > This patch updates the mcasp clock entries so clk_get() will succee=
d.
> > It is tested on BeagleBone and is needed for 3.7-rc1 to fix AM33xx
> > boot.
>
>
> I want to test Audio on AM335x Evm with your EDMA patches. I have few
> patches for AM335x.
> Can you share the link to the repo & branch on which I need to rebase=
?
> The patches are related to mcasp dt node, mcasp pinmux in dt, etc...
>
> >
> ..snip..
> ..snip..
> >
>
>
> Thanks & Regards,
> Gururaja
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
