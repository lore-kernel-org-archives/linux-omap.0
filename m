From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC PATCH 2/5] OMAP4:I2C: Add device tree nodes for panda board
Date: Thu, 7 Jul 2011 22:29:14 +0530
Message-ID: <20110707165914.GA3124@manju-desktop>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-3-git-send-email-manjugk@ti.com>
	<20110706185712.GK4871@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110706185712.GK4871@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 06, 2011 at 12:57:12PM -0600, Grant Likely wrote:
> On Thu, Jun 30, 2011 at 03:07:24PM +0500, G, Manjunath Kondaiah wrote:
> > 
> > Add I2C and it's child device nodes for beagle board.
> > The I2C1 controller child devices are not populated and it
> > should be handled along with OMAP clock changes.
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > ---
> >  arch/arm/boot/dts/omap4-panda.dts |   57 +++++++++++++++++++++++++++++++++++++
> >  1 files changed, 57 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> > index 58909e9..f9af72f 100644
> > --- a/arch/arm/boot/dts/omap4-panda.dts
> > +++ b/arch/arm/boot/dts/omap4-panda.dts
> > @@ -8,4 +8,61 @@
> >  / {
> >  	model = "TI OMAP4 PandaBoard";
> >  	compatible = "ti,omap4-panda", "ti,omap4430";
> > +	interrupt-parent = <&gic>;
> > +
> > +	gic: interrupt-controller@48241000 {
> > +		compatible = "ti,omap-gic", "arm,gic";
> 
> ti,omap4-gic
> 
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> > +		reg = <0x48241000 0x1000>,
> > +		      <0X48240100 0x0200>;
> > +	};
> > +
> > +	i2c@48070000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "ti,omap_i2c";
> 
> ti,omap4-i2c.  Actually, it is quite possibly appropriate to do:
> 
> 	compatible = "ti,omap4-i2c", "ti,omap3-i2c";
ok. can also have "ti,omap2-i2c"
> 
> > +		reg = <0x48070000 0x100>;
> > +		interrupts = < 88 >;
> > +		interrupt-parent = <&gic>;
> > +		clock-frequency = <400>;
> 
> Frequency should be a Hz value, not kHz or MHz.
current i2c-omap driver expects value to be in KHz. Will change it in driver
and pass value in Hz here.

-Manjunath
