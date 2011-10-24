From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Mon, 24 Oct 2011 15:59:50 +0200
Message-ID: <20111024135950.GV8708@ponder.secretlab.ca>
References: <4E9EB61C.1040207@ti.com>
	<20111019144215.GA32007@S2100-06.ap.freescale.net>
	<4E9FAF42.5060200@ti.com>
	<20111020061408.GE32007@S2100-06.ap.freescale.net>
	<4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<20111024092411.GE8708@ponder.secretlab.ca>
	<20111024130429.GD1755@S2100-06.ap.freescale.net>
	<20111024130636.GB26033@opensource.wolfsonmicro.com>
	<20111024134025.GE1755@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111024134025.GE1755@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Rajendra Nayak <rnayak@ti.com>, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 24, 2011 at 09:40:26PM +0800, Shawn Guo wrote:
> On Mon, Oct 24, 2011 at 03:06:37PM +0200, Mark Brown wrote:
> > On Mon, Oct 24, 2011 at 09:04:31PM +0800, Shawn Guo wrote:
> > 
> > > If we can attach the device_node of 'regulators' node to dev->of_node
> > > when calling regulator_register(regulator_desc, dev, ...) from
> > > regulator driver, the regulator core will be able to find all nodes under
> > > 'regulators' using for_each_child_of_node(dev->of_node, child).
> > 
> > Please provide concrete examples of the bindings you're talking about,
> > the really important thing here is how sane the bindings look and I've
> > really got no idea what any of what you're talking about will look like
> > or if they make sense.
> > 
> The only thing different from what I attached last time is the
> compatible string added to 'regulators' node.
> 
>         ecspi@70010000 { /* ECSPI1 */
>                 fsl,spi-num-chipselects = <2>;
>                 cs-gpios = <&gpio3 24 0>, /* GPIO4_24 */
>                            <&gpio3 25 0>; /* GPIO4_25 */
>                 status = "okay";
> 
>                 pmic: mc13892@0 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         compatible = "fsl,mc13892";
>                         spi-max-frequency = <6000000>;
>                         reg = <0>;
>                         mc13xxx-irq-gpios = <&gpio0 8 0>; /* GPIO1_8 */
> 
>                         regulators {
>                         	compatible = "fsl,mc13892-regulator";
> 
>                                 sw1reg: mc13892_sw1 {
>                                         regulator-min-uV = <600000>;
>                                         regulator-max-uV = <1375000>;
>                                         regulator-change-voltage;
>                                         regulator-boot-on;
>                                         regulator-always-on;
>                                 };
> 
>                                 sw2reg: mc13892_sw2 {
>                                         regulator-min-uV = <900000>;
>                                         regulator-max-uV = <1850000>;
>                                         regulator-change-voltage;
>                                         regulator-boot-on;
>                                         regulator-always-on;
>                                 };
> 
>                                 ......
>                         };
> 
>                         leds {
>                                 ......
>                         };
> 
>                         buttons {
>                                 ......
>                         };
>                 };
> 
>                 flash: at45db321d@1 {
>                         ......
>                 };
>         };
> 
> > > hesitate to hack this into mfd_add_devices(), so I would like to add
> > > compatible string "fsl,mc13892-regulators" to node 'regulators' and
> > > find the node using of_find_compatible_node(dev->parent, NULL,
> > > "fsl,mc13892-regulators").
> > 
> > It's not immediately obvious to me that having a binding for the
> > regulators separately makes sense, it's not a usefully distinct device.
> > 
> Fair point.  Actually, I also hate to have the finding of node
> 'regulators' plugged into regulator driver.  What about following
> change to address Grant's concern on global device tree search?
>  
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 8fe132d..29dcf90 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2673,7 +2673,8 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
>         BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
> 
>         /* find device_node and attach it */
> -       rdev->dev.of_node = of_find_node_by_name(NULL, regulator_desc->name);
> +       rdev->dev.of_node = of_find_node_by_name(dev->parent->of_node,
> +                                                regulator_desc->name);

of_find_node_by_name() doesn't work that way.  The first argument is a
starting point, but it doesn't restrict the search to children of a
node.

for_each_child_of_node() is what you want to use when iterating over
the children which unfortunately changes the structure of this
function.

g.
