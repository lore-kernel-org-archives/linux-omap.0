From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
Date: Thu, 7 Mar 2019 14:13:29 -0600
Message-ID: <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com> <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430092947.GC2270@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Michal Simek <michal.simek@xilinx.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 30, 2018 at 4:30 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Apr 30, 2018 at 11:03:25AM +0200, Linus Walleij wrote:
> > On Thu, Apr 19, 2018 at 5:14 PM, Grygorii Strashko
> > <grygorii.strashko@ti.com> wrote:
> > > On 04/19/2018 09:05 AM, Wolfram Sang wrote:
> > >>
> > >> We should get drvdata from struct device directly. Going via
> > >> platform_device is an unneeded step back and forth.
> > >>
> > >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >> ---
> > >>
> > >> Build tested only. buildbot is happy. Please apply individually.
> > >
> > >
> > > for gpio-omap.c:
> > > Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >
> > Hm I only see the responses not the actual patch, I guess I will find it
> > sooner or later.
> >
> > Wolfram: if I don't find it, poke me with something sharp so I get to apply it.
>
> I had the same problem, turned out this got classified as spam by Google
> for some reason. Maybe try your spam folder?

It's been almost a year later, and several Linux revisions, and this
still seems stuck somewhere/somehow.

adam
>
> Thierry
