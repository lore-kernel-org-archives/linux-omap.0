From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Date: Fri, 28 Sep 2018 08:57:29 -0700
Message-ID: <153815024975.119890.6463829001501352147@swboyd.mtv.corp.google.com>
References: <20180822090319.29167-1-johan@kernel.org>
 <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
 <9a80b925-a36e-3895-f91b-4716d5524249@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9a80b925-a36e-3895-f91b-4716d5524249@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2018-09-20 00:11:08)
> On 31/08/18 00:46, Stephen Boyd wrote:
> > Quoting Johan Hovold (2018-08-22 02:03:19)
> >> Fix child-node lookup which by using the wrong OF helper was searching
> >> the whole tree depth-first, something which could end up matching an
> >> unrelated node.
> >>
> >> Also fix the related node-reference leaks.
> >>
> >> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
> >> Signed-off-by: Johan Hovold <johan@kernel.org>
> >> ---
> > =

> > Applied to clk-next
> > =

> =

> Stephen, this patch causes a merge conflict with some of the code I am =

> planning to send a pull-req against (the clkctrl work series: =

> https://patchwork.kernel.org/project/linux-clk/list/?series=3D13841)
> =

> Would it be possible to drop this from clk-next, and for me to =

> pick-it-up via my own branch? I can get this setup either today or tomorr=
ow.
> =

> Alternatively I need an immutable branch against which I can work.
> =


clk-ti-of-node is immutable. You can base on top of that and send a PR.
Does that work for you?
