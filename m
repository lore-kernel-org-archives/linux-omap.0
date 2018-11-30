From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date: Fri, 30 Nov 2018 15:51:55 -0800
Message-ID: <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130153729.GG53235@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2018-11-30 07:37:29)
> Hi,
> =

> * Tero Kristo <t-kristo@ti.com> [181130 09:21]:
> > On 30/11/2018 09:57, Stephen Boyd wrote:
> > > No that is not preferred. Can the omap2_clk_deny_idle() function be
> > > integrated closer into the clk framework in some way that allows it to
> > > be part of the clk_ops structure? And then have that take a clk_hw
> > > structure instead of a struct clk? I haven't looked at this in any
> > > detail whatsoever so I may be way off right now.
> > =

> > It could be added under the main clk_ops struct, however this would
> > introduce two new func pointers to it which are not used by anything el=
se
> > but OMAP. Are you aware of any other platforms requiring similar featur=
e?
> =

> From consumer usage point of view, I'm still wondering about
> the relationship of clk_deny_idle() and clkdm_deny_idle().
> =

> It seems that we need to allow reset control drivers call
> clk_deny_idle() for the duration of reset. And it seems the
> clk_deny_idle() should propagate to also up to the related
> clock domain driver to do clkdm_deny_idle().
> =

> So maybe clk_deny_idle() is could just be something like:
> =

> dev =3D clk_get_device(clk);
> ...
> error =3D pm_runtime_get(dev);
> ...
> pm_runtime_put(dev);
> ...
> =

> And that way it would just propagate to the parent clock
> domain driver and the clock framework does not need to know
> about clockdomains. A clockdomain could be just a genpd
> domain.
> =

> Or do you guys have better ideas?
> =


Wouldn't the device link in clk framework patches do this for you if we
had the RUNTIME_PM flag passed in. If this is about keeping the clock
controller active when a consumer device is using it then I think it may
work.
