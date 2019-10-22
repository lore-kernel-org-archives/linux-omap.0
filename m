From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 1/2] configs: ARM: omap2plus: Enable OMAP3_THERMAL
Date: Tue, 22 Oct 2019 14:01:08 -0500
Message-ID: <CAHCN7xLy975mxX+cm56PMx-TKODEZjYPfMHb=byspKxYXXq7OA@mail.gmail.com>
References: <20191007220540.30690-1-aford173@gmail.com> <20191022162223.GU5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022162223.GU5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 22, 2019 at 11:22 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Adam Ford <aford173@gmail.com> [191007 15:06]:
> > The some in the OMAP3 family have a bandgap thermal sensor, but
> > omap2plus has it disabled.
> >
> > This patch enables the OMAP3_THERMAL by default like the rest of
> > the OMAP family.
>
> Looks like this breaks off mode during idle for omap3, and that's
> probably why it never got enabled. The difference in power
> consumption during idle is about 7mW vs 32mW for the SoC as
> measured from torpedo shunt for main_battery_som.
>
> I think the right fix might be simply to add handling for
> CPU_CLUSTER_PM_ENTER to the related thermal driver to disable
> it during idle like we have for gpio-omap.c for example.

I am not sure I know where to start on fixing that issue.  Would you
entertain enabling the driver if we set the device tree to 'disabled'
by default?  This way if people want to to use it, it can be enabled
on a per-device option.  Once the power stuff gets resolved, we might
be able to enable it by default.  For people who are planning on using
the DM3730 @ 1GHz in high temp environments, I am not sure they'll
care about low power.

I'll try to look into it when I have time, but I was hoping a
compromise might be a reasonable work-around.

adam
>
> Regards,
>
> Tony
>
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index 8f1c2b6f9e56..7e14a8c8bb29 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -292,6 +292,7 @@ CONFIG_THERMAL_GOV_FAIR_SHARE=y
> >  CONFIG_THERMAL_GOV_USER_SPACE=y
> >  CONFIG_CPU_THERMAL=y
> >  CONFIG_TI_THERMAL=y
> > +CONFIG_OMAP3_THERMAL=y
> >  CONFIG_OMAP4_THERMAL=y
> >  CONFIG_OMAP5_THERMAL=y
> >  CONFIG_DRA752_THERMAL=y
> > --
> > 2.17.1
> >
