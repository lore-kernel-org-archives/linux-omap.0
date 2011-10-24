From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Mon, 24 Oct 2011 22:47:17 +0800
Message-ID: <20111024144716.GG1755@S2100-06.ap.freescale.net>
References: <20111019144215.GA32007@S2100-06.ap.freescale.net>
	<4E9FAF42.5060200@ti.com>
	<20111020061408.GE32007@S2100-06.ap.freescale.net>
	<4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<20111024092411.GE8708@ponder.secretlab.ca>
	<20111024130429.GD1755@S2100-06.ap.freescale.net>
	<20111024130636.GB26033@opensource.wolfsonmicro.com>
	<20111024134025.GE1755@S2100-06.ap.freescale.net>
	<20111024134930.GD26033@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111024134930.GD26033@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 24, 2011 at 03:49:30PM +0200, Mark Brown wrote:
> On Mon, Oct 24, 2011 at 09:40:26PM +0800, Shawn Guo wrote:
> 
> > +++ b/drivers/regulator/core.c
> > @@ -2673,7 +2673,8 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
> >         BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
> > 
> >         /* find device_node and attach it */
> > -       rdev->dev.of_node = of_find_node_by_name(NULL, regulator_desc->name);
> > +       rdev->dev.of_node = of_find_node_by_name(dev->parent->of_node,
> > +                                                regulator_desc->name);
> > 
> 
> Is that going to do the right thing if you've got a MFD which does
> register each regulator as a separate device?

Based on my understanding, 1:1 is just a special case of N:1.  I
failed to see any problem having it work with registering each
regulator as a separate device.

> Might be best to just
> search within dev and get drivers to pass the "real" device in when
> registering the regulator rather than the virtual device.
> 
It should also work, but it will also change the API slightly for
non-dt users.  I'm not sure it's something we want.

-- 
Regards,
Shawn
