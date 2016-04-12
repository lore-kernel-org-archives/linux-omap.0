From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: dts: AM572x-IDK Initial Support
Date: Tue, 12 Apr 2016 14:15:08 -0700
Message-ID: <20160412211508.GF5995@atomide.com>
References: <1459182909-23502-1-git-send-email-nm@ti.com>
 <20160328211015.GA28249@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160328211015.GA28249@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Schuyler Patton <spatton@ti.com>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [160328 14:11]:
> On Mon, Mar 28, 2016 at 11:35:09AM -0500, Nishanth Menon wrote:
> > From: Schuyler Patton <spatton@ti.com>
> > 
> > The AM572x-IDK board is a board based on TI's AM5728 SOC
> > which has a dual core 1.5GHz A15 processor. This board is a
> > development platform for the Industrial market with:
> > - 2GB of DDR3L
> > - Dual 1Gbps Ethernet
> > - HDMI,
> > - PRU-ICSS
> > - uSD
> > - 16GB eMMC
> > - CAN
> > - RS-485
> > - PCIe
> > - USB3.0
> > - Video Input Port
> > - Industrial IO port and expansion connector
> > 
> > The link to the data sheet and TRM can be found here:
> > 
> > http://www.ti.com/product/AM5728
> > 
> > This patch creates a common dtsi file that will provide a common board
> > dtsi file to define the nodes that are common to AM57xx (including the
> > upcoming AM5718) IDK boards.
> > 
> > Initial support is only for basic peripherals
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applying into omap-for-v4.7/dt thanks.

Tony
