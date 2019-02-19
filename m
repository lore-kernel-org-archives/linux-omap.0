From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/mach-omap2/display: fix possible object reference
 leak
Date: Tue, 19 Feb 2019 09:58:14 -0800
Message-ID: <20190219175814.GO15711@atomide.com>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
 <20190219170516.GL15711@atomide.com>
 <alpine.DEB.2.20.1902191830490.27989@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1902191830490.27989@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Peng Hao <peng.hao2@zte.com.cn>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, wen.yang99@zte.com.cn
List-Id: linux-omap@vger.kernel.org

* Julia Lawall <julia.lawall@lip6.fr> [190219 17:33]:
> On Tue, 19 Feb 2019, Tony Lindgren wrote:
> > In general, if the device tree node is never used afterwards,
> > should this be just:
> >
> > 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> > 	of_node_put(dev_node);
> > 	if (r) {
> > 		...
> > 	}
> >
> > If so, Julia might have a Coccinelle recpipe for it?
> 
> Unfortunately this is not really an ideal case for Coccinelle, because
> node is the result of calling a local function and Coccinelle doesn't by
> default do any interprocedural analysis.  It is possible to write a rule
> that explicitly looks for one function that returns a device node and then
> the pattern of its usage in the caller, though.

OK thanks for the information.

Regards,

Tony
