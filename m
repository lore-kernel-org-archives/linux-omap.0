From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
Date: Wed, 08 Jan 2014 11:19:28 +0100
Message-ID: <4812867.NuB3hNkV9d@wuerfel>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <20140108090808.GB16313@earth.universe> <52CD23E0.8030400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52CD23E0.8030400@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, "Kristo, Tero" <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 08 January 2014 15:39:36 Roger Quadros wrote:
> > What about the other clocks acquired in drivers/mfd/omap-usb-host.c? Shouldn't
> > all of those be provided by via the DT phandle?
> > 
> 
> All those clocks are identically named across the OMAP SoCs and are unique for each
> SoC, so providing DT phandle for all of them is not required.
> 
> The init_60m_fclk was renamed to l3init_60m_fclk in OMAP5, and hence the need for
> this binding.

What do you mean it was renamed? Is it a different version of the omap-usb-host
device then?

> > Should the clk_get be changed to of_clk_get()/of_clk_get_by_name() in the
> > driver? This would potentially remove the need of the init_60m_fclk name.
> > 
> 
> If we use of_clk_xxx() then we'll need to update DT nodes for OMAP4 and OMAP3 as
> well to explicitly provide the clock phandle. For now we make use of the fact that
> SoC clock data names the clock rightly i.e. "init_60m_fclk".

I'm getting the feeling that init_60m_fclk is not the name of the clock input
of the omap-usb-host device at all, but rather the name of a signal on the
omap soc, which would not be an appropriate identifier for the binding.

	Arnd
