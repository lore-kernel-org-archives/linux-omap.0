From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch v4 2/3] ARM: dts: dra7: add vpe clkctrl node
Date: Tue, 12 Nov 2019 07:26:07 -0800
Message-ID: <20191112152607.GC5610@atomide.com>
References: <20191112142657.22898-1-bparrot@ti.com>
 <20191112142657.22898-3-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112142657.22898-3-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191112 14:24]:
> Add clkctrl nodes for VPE module.
> 
> Note that because of the current dts node name dependency for mapping to
> clock domain, we must still use "vpe-clkctrl@" naming instead of generic
> "clock@" naming for the node. And because of this, it's probably best to
> apply the dts node addition together along with the other clock changes.

Thanks looks good to me now. Yeah it's probably best to queue this one
along with the clock driver changes. I can then collect the dts related
driver dts change on top of a branch from Tero. So please feel free to
add this:

Acked-by: Tony Lindgren <tony@atomide.com>
