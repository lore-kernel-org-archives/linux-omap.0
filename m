From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: Convert to using %pOFn instead of device_node.name
Date: Thu, 30 Aug 2018 09:50:34 -0700
Message-ID: <153564783492.129321.1020703197103191812@swboyd.mtv.corp.google.com>
References: <20180828154433.5693-1-robh@kernel.org>
 <20180828154433.5693-3-robh@kernel.org>
 <153549455575.129321.22566359378173086@swboyd.mtv.corp.google.com>
 <CAL_JsqJ35s0vfor4AdzKRvxOsqSvSD+_y4J3vYNeVk9ZW6HtjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJ35s0vfor4AdzKRvxOsqSvSD+_y4J3vYNeVk9ZW6HtjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Quoting Rob Herring (2018-08-29 04:13:44)
> On Tue, Aug 28, 2018 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Rob Herring (2018-08-28 08:44:29)
> > > In preparation to remove the node name pointer from struct device_nod=
e,
> > > convert printf users to use the %pOFn format specifier.
> > >
> > > Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Cc: linux-omap@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> >
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> =

> Please apply to the clock tree. There's no dependencies and removing
> name will take some time.
> =


Alright. Applied to clk-next. Thanks!
