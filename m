From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Tue, 25 Oct 2011 14:52:17 +0800
Message-ID: <20111025065216.GD2119@S2100-06.ap.freescale.net>
References: <4EA13053.7080306@ti.com>
	<20111021115809.GB337@S2100-06.ap.freescale.net>
	<4EA4FF6B.2080906@ti.com>
	<20111024081706.GC8708@ponder.secretlab.ca>
	<20111024090228.GA1755@S2100-06.ap.freescale.net>
	<4EA52851.8000203@ti.com>
	<20111024091158.GB1755@S2100-06.ap.freescale.net>
	<4EA52C56.3080908@ti.com>
	<20111024134727.GF1755@S2100-06.ap.freescale.net>
	<4EA65073.7050205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4EA65073.7050205@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2011 at 11:30:19AM +0530, Rajendra Nayak wrote:
> On Monday 24 October 2011 07:17 PM, Shawn Guo wrote:
> >On Mon, Oct 24, 2011 at 02:43:58PM +0530, Rajendra Nayak wrote:
> >>Case 2:
> >>One device for all regulators:
> >>
> >>DT nodes look something like this
> >>
> >>regulators {
> >>	reg1: reg@1 {
> >>			...
> >>			...
> >>	};
> >>
> >>	reg2: reg@2 {
> >>			...
> >>			...
> >>	};
> >>};
> >>
> >>The regulator driver probes only one device and the dev->of_node
> >>points to the "regulators" node above.
> >
> >The mc13892 example I put in the reply to Grant demonstrates that
> >for some case, dev->of_node is NULL (devices are created by mfd core).
> 
> In that case should you not be first converting the mfd driver to
> register regulator devices using DT?

The mc13892 mfd driver calls mfd_add_devices() to add device for
mc13892 regulator driver.  Are you suggesting that I should hack
mfd_add_devices() to have device_node of 'regulators' attached?
The mfd is not a bus like i2c and spi, so I'm not sure this is the
right thing to do.

> Thats what we did for OMAP, and hence we always have the of_node
> populated when the regulator devices are probed.
> See this patch from Benoit on how thats done for twl devices..
> http://marc.info/?l=linux-omap&m=131489864814428&w=2
> 
OMAP is "Case 1", and we are talking about "Case 2".

-- 
Regards,
Shawn
