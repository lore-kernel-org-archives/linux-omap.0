From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] configs: ARM: omap2plus: Enable OMAP3_THERMAL
Date: Tue, 22 Oct 2019 15:19:19 -0700
Message-ID: <20191022221919.GF5610@atomide.com>
References: <20191007220540.30690-1-aford173@gmail.com>
 <20191022162223.GU5610@atomide.com>
 <CAHCN7xLy975mxX+cm56PMx-TKODEZjYPfMHb=byspKxYXXq7OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xLy975mxX+cm56PMx-TKODEZjYPfMHb=byspKxYXXq7OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191022 19:01]:
> On Tue, Oct 22, 2019 at 11:22 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > * Adam Ford <aford173@gmail.com> [191007 15:06]:
> > > The some in the OMAP3 family have a bandgap thermal sensor, but
> > > omap2plus has it disabled.
> > >
> > > This patch enables the OMAP3_THERMAL by default like the rest of
> > > the OMAP family.
> >
> > Looks like this breaks off mode during idle for omap3, and that's
> > probably why it never got enabled. The difference in power
> > consumption during idle is about 7mW vs 32mW for the SoC as
> > measured from torpedo shunt for main_battery_som.
> >
> > I think the right fix might be simply to add handling for
> > CPU_CLUSTER_PM_ENTER to the related thermal driver to disable
> > it during idle like we have for gpio-omap.c for example.
> 
> I am not sure I know where to start on fixing that issue.  Would you
> entertain enabling the driver if we set the device tree to 'disabled'
> by default?  This way if people want to to use it, it can be enabled
> on a per-device option.  Once the power stuff gets resolved, we might
> be able to enable it by default.  For people who are planning on using
> the DM3730 @ 1GHz in high temp environments, I am not sure they'll
> care about low power.

They should both work fine together though. They are not mutually
exclusive features.

> I'll try to look into it when I have time, but I was hoping a
> compromise might be a reasonable work-around.

It should be hopefully a trivial fix.. I have not looked at the
driver code though.

Regards,

Tony
