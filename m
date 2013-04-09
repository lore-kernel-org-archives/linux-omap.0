From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support
 for AUXCLKs
Date: Tue, 9 Apr 2013 10:43:20 -0700
Message-ID: <20130409174319.GP10155@atomide.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com>
 <1363703220-4777-2-git-send-email-rogerq@ti.com>
 <20130403234242.GE10155@atomide.com> <515D2D30.3000306@ti.com>
 <20130404164137.GH10155@atomide.com> <515EA9E3.1010409@ti.com>
 <20130405155851.GA10155@atomide.com> <5163E589.1040809@ti.com>
 <20130409164928.GL10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130409164928.GL10155@atomide.com>
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
Cc: "Menon, Nishanth" <nm@ti.com>, grygorii.strashko@ti.com, linux@arm.linux.org.uk, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130409 09:54]:
> * Roger Quadros <rogerq@ti.com> [130409 03:00]:
> > On 04/05/2013 06:58 PM, Tony Lindgren wrote:
> > > 
> > > Can't you just use the clock name there to get it?
> > 
> > In device tree we don't pass around clock names. You can either get
> > a phandle or an index to the clock.
> > 
> > e.g. Documentation/devicetree/bindings/clock/imx31-clock.txt
> 
> Yes I understand that. But the driver/clock/omap driver can just
> remap the DT device initially so the board specific clock is
> found from the clock alias table. Basically initially a passthrough
> driver that can be enhanced to parse DT clock bindings and load
> data from /lib/firmware.

Actually probably the driver/clock/omap can even do even less
initially. There probably even no need to remap clocks there.

As long as the DT clock driver understands that a board specific
auxclk is specified in the DT it can just call clk_add_alias() so
the driver will get the right auxclk from cclock44xx_data.c.

Then other features can be added later on like to allocate a
clock entirely based on the binding etc.

Regards,

Tony 
