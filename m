From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
Date: Mon, 29 Oct 2012 19:33:06 -0500
Message-ID: <CAD=GYpY5-X3BJZEQ1aD4+mKxFNvb4Ug67FtXdLbNwKxWoFvA3w@mail.gmail.com>
References: <1349879449-22657-1-git-send-email-mporter@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5592106563859399859=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Hiremath,
 Vaibhav" <hvaibhav@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5592106563859399859==
Content-Type: multipart/alternative; boundary=00235452fd84fbbb8f04cd3bedb1

--00235452fd84fbbb8f04cd3bedb1
Content-Type: text/plain; charset=ISO-8859-1

Hi Guraraja,

I am interested in this thread. I've been trying Gururaja's patches for
audio as well.

I rebased  Guraja's patches on top of Matt's EDMA patches which were
applied to the beaglebone 3.7 kernel repo. With some fixes to make it
compile with CONFIG_DUMMY_REGULATOR enabled, Currently it breaks at
set_dai_fmt in davinci-mcasp.c when an audio file is played.

Could you try my tree on EVM?  dts changes may be required to use mcasp1 on
EVM,
https://github.com/joelagnel/linux-kernel/commits/3.7

v3.7-rc2-fixes to v3.7-rc2-audio commits are Gururaja's patches which I
applied, and after that are my commits to enable config , add dt data and
some fixes.

Thanks,
Joel

On Mon, Oct 29, 2012 at 10:45 AM, Hebbar, Gururaja
<gururaja.hebbar@ti.com>wrote:

> Matt,
>
> On Wed, Oct 10, 2012 at 20:00:49, Porter, Matt wrote:
> > 6ea74cb ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage
> > exposes a bug in the AM33XX clock data for mcasp. After moving to
> > clk_get() usage, the _init() of all registered hwmods fails on mcasp0
> > due to incorrect clock data causing clk_get() to fail. This causes all
> > successive hwmods to fail to _init() leaving them in a bad state.
> >
> > This patch updates the mcasp clock entries so clk_get() will succeed.
> > It is tested on BeagleBone and is needed for 3.7-rc1 to fix AM33xx
> > boot.
>
>
> I want to test Audio on AM335x Evm with your EDMA patches. I have few
> patches for AM335x.
> Can you share the link to the repo & branch on which I need to rebase?
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
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--00235452fd84fbbb8f04cd3bedb1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guraraja,<div><br></div><div>I am interested in this thread. I&#39;ve be=
en trying Gururaja&#39;s patches for audio as well.</div><div><br></div><di=
v>I rebased =A0Guraja&#39;s patches on top of=A0Matt&#39;s EDMA patches whi=
ch were applied to the beaglebone 3.7 kernel repo. With some fixes to make =
it compile with CONFIG_DUMMY_REGULATOR enabled, Currently it breaks at set_=
dai_fmt in davinci-mcasp.c when an audio file is played.</div>
<div><br></div><div>Could you try my tree on EVM? =A0dts changes may be req=
uired to use mcasp1 on EVM,</div><div><a href=3D"https://github.com/joelagn=
el/linux-kernel/commits/3.7">https://github.com/joelagnel/linux-kernel/comm=
its/3.7</a></div>
<div><br></div><div>v3.7-rc2-fixes to v3.7-rc2-audio commits are Gururaja&#=
39;s patches which I applied, and after that are my commits to enable confi=
g , add dt data and some fixes.</div><div><br></div><div>Thanks,</div><div>
Joel<br><br><div class=3D"gmail_quote">On Mon, Oct 29, 2012 at 10:45 AM, He=
bbar, Gururaja <span dir=3D"ltr">&lt;<a href=3D"mailto:gururaja.hebbar@ti.c=
om" target=3D"_blank">gururaja.hebbar@ti.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
Matt,<br>
<br>
On Wed, Oct 10, 2012 at 20:00:49, Porter, Matt wrote:<br>
&gt; 6ea74cb ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage<=
br>
&gt; exposes a bug in the AM33XX clock data for mcasp. After moving to<br>
&gt; clk_get() usage, the _init() of all registered hwmods fails on mcasp0<=
br>
&gt; due to incorrect clock data causing clk_get() to fail. This causes all=
<br>
&gt; successive hwmods to fail to _init() leaving them in a bad state.<br>
&gt;<br>
&gt; This patch updates the mcasp clock entries so clk_get() will succeed.<=
br>
&gt; It is tested on BeagleBone and is needed for 3.7-rc1 to fix AM33xx<br>
&gt; boot.<br>
<br>
<br>
I want to test Audio on AM335x Evm with your EDMA patches. I have few<br>
patches for AM335x.<br>
Can you share the link to the repo &amp; branch on which I need to rebase?<=
br>
The patches are related to mcasp dt node, mcasp pinmux in dt, etc...<br>
<br>
&gt;<br>
..snip..<br>
..snip..<br>
&gt;<br>
<br>
<br>
Thanks &amp; Regards,<br>
Gururaja<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-omap&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</blockquote></div><br></div>

--00235452fd84fbbb8f04cd3bedb1--


--===============5592106563859399859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5592106563859399859==--
