From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Add definition for GPIO direction
Date: Wed, 6 Nov 2019 16:24:41 +0200
Message-ID: <20191106142441.GC32742@smile.fi.intel.com>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
 <20191106120846.5bunrqj3uz4khih5@earth.universe>
 <ddcd02cc6c709837a28cae2cbfa672c506927659.camel@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ddcd02cc6c709837a28cae2cbfa672c506927659.camel@fi.rohmeurope.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "sre@kernel.org" <sre@kernel.org>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "marek.behun@nic.cz" <marek.behun@nic.cz>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.co>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 06, 2019 at 12:25:18PM +0000, Vaittinen, Matti wrote:
> 
> On Wed, 2019-11-06 at 13:08 +0100, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Wed, Nov 06, 2019 at 10:51:06AM +0200, Matti Vaittinen wrote:
> > > The patch series adds definitions for GPIO line directions.
> > > 
> > > For occasional GPIO contributor like me it is always a pain to
> > > remember
> > > whether 1 or 0 was used for GPIO direction INPUT/OUTPUT.
> > 
> > Maybe also update the GPIO drivers in pinctrl?
> > 
> > $ git grep -l gpio_get_direction drivers/pinctrl
> > drivers/pinctrl/bcm/pinctrl-bcm2835.c
> > drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> > drivers/pinctrl/intel/pinctrl-baytrail.c
> > drivers/pinctrl/intel/pinctrl-cherryview.c
> > drivers/pinctrl/intel/pinctrl-intel.c
> > drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > drivers/pinctrl/mediatek/pinctrl-paris.c
> > drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> > drivers/pinctrl/pinctrl-amd.c
> > drivers/pinctrl/pinctrl-at91.c
> > drivers/pinctrl/pinctrl-axp209.c
> > drivers/pinctrl/pinctrl-ingenic.c
> > drivers/pinctrl/pinctrl-ocelot.c
> > drivers/pinctrl/pinctrl-oxnas.c
> > drivers/pinctrl/pinctrl-pic32.c
> > drivers/pinctrl/pinctrl-pistachio.c
> > drivers/pinctrl/pinctrl-rk805.c
> > drivers/pinctrl/pinctrl-rockchip.c
> > drivers/pinctrl/pinctrl-rza1.c
> > drivers/pinctrl/pinctrl-st.c
> > drivers/pinctrl/pinctrl-stmfx.c
> > drivers/pinctrl/pinctrl-sx150x.c
> > drivers/pinctrl/qcom/pinctrl-msm.c
> > drivers/pinctrl/stm32/pinctrl-stm32.c
> > drivers/pinctrl/vt8500/pinctrl-wmt.c
> 
> Ouch. I didn't check from pinctrl but I see those should be converted
> as well. I'm a bit short on time right now so if anyone else is
> interested I won't mind :)
> 
> Luckily the value for IN and OUT is not changed - only the defines were
> added - so all of the drivers do not need to be done at once.

Agree.

> If no one
> else will take the pinctrl part then I can probably do pinctrl patches
> for v5.6 cycle.

For pin control Intel, since we send PR to Linus and it won't be different to
him, we would like to see patch per driver.

-- 
With Best Regards,
Andy Shevchenko
