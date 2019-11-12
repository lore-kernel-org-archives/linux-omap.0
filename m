From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch v3 02/10] ARM: dts: dra7: add cam clkctrl node
Date: Tue, 12 Nov 2019 07:29:49 -0800
Message-ID: <20191112152949.GF5610@atomide.com>
References: <20191112142753.22976-1-bparrot@ti.com>
 <20191112142753.22976-3-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112142753.22976-3-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191112 14:25]:
> Add clkctrl nodes for CAM domain.
> 
> Note that because of the current dts node name dependency for mapping to
> clock domain, we must still use "cam-clkctrl@" naming instead of generic
> "clock@" naming for the node. And because of this, it's probably best to
> apply the dts node addition together along with the other clock changes.

Thanks for updating this too.

Tero, for merging, you could create a separate clock dts changes branch
too on your clock changes if needed, up to you. Anyways best that you
queue all the clock changes and clock related dts changes:

Acked-by: Tony Lindgren <tony@atomide.com>
