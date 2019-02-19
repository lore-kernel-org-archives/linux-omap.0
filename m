From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] arm/mach-omap2/display: fix possible object reference
 leak
Date: Tue, 19 Feb 2019 18:30:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1902191824410.27989@hadrien>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn> <20190219170516.GL15711@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219170516.GL15711@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, wen.yang99@zte.com.cn
List-Id: linux-omap@vger.kernel.org



On Tue, 19 Feb 2019, Tony Lindgren wrote:

> Hi,
>
> Adding devicetree list, Julia, Rob and Tomi to Cc.
>
> * Peng Hao <peng.hao2@zte.com.cn> [190212 23:11]:
> > of_find_device_by_node() takes a reference to the struct device
> > when it finds a match via get_device.When returning error we should
> > call put_device.
> >
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > ---
> >  arch/arm/mach-omap2/display.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> > index f86b72d..c6aa9ed 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
> >  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> >  	if (r) {
> >  		pr_err("Unable to populate DSS submodule devices\n");
> > +		put_device(&pdev->dev);
> >  		return r;
> >  	}
>
> In general, if the device tree node is never used afterwards,
> should this be just:
>
> 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> 	of_node_put(dev_node);

Are these solving the same problems?  The of_node_put looks clearly
necessary, whether there is a success or failure.  I'm not familiar with
put_device.  I see that it does a kobject_put, but I don't know what
happens because of that.  But it looks like an inconsistency that Peng's
patch only considers the failure case, while your suggestion happens
always.

I guess Peng's patch is motivated by a Coccinelle script that Wen Yang
(also from ZTE) has been working on.  Perhaps there is a need to adjust
what is suggested by that script.

[Wen Yang added to CC]

julia

> 	if (r) {
> 		...
> 	}
>
> If so, Julia might have a Coccinelle recpipe for it?
>
> Regards,
>
> Tony
>
