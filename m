From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch v2 3/5] ARM: dts: dra7: add vpe clkctrl node
Date: Fri, 8 Nov 2019 09:06:41 -0800
Message-ID: <20191108170641.GI5610@atomide.com>
References: <20191104203841.3628-1-bparrot@ti.com>
 <20191104203841.3628-4-bparrot@ti.com>
 <20191108165554.GF5610@atomide.com>
 <20191108170231.ubwfu2nvcwjfabas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191108170231.ubwfu2nvcwjfabas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191108 17:00]:
> Tony Lindgren <tony@atomide.com> wrote on Fri [2019-Nov-08 08:55:54 -0800]:
> > Hi,
> > 
> > * Benoit Parrot <bparrot@ti.com> [191104 20:39]:
> > > Add clkctrl nodes for VPE module.
> > 
> > Can you please add a comment describing that we currently need to
> > use custom node names here instead of the standard naming?
> 
> Tony, what do you mean "custom node name" here?
> I followed the exact same syntax that was already there... confused..

Oh sorry for being unclear. Yeah so the conclusion of the discussion was
that we still need custom node names for now.

And for patch "[PATCH] clk: ti: add clkctrl data dra7 sgx" I added you to
Cc, and it has this in the patch description:

"Note that because of the current dts node name dependency for mapping to
 clock domain, we must still use "gpu-clkctrl@" naming instead of generic
 "clock@" naming for the node. And because of this, it's probably best to
 apply the dts node addition together along with the other clock changes."

So can you please add something similar to your clock node patches too
to explain why we cannot use standard node names there?

Regards,

Tony
