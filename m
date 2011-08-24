From: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Subject: RE: [PATCH v2] OMAP3EVM: ehci: Fix EHCI support
Date: Wed, 24 Aug 2011 14:42:07 +0200
Message-ID: <1314189727.2320.16.camel@bryan-HUTIA>
References: <1314174902-12797-1-git-send-email-bdefaria@adeneo-embedded.com>
	<19F8576C6E063C45BE387C64729E739404EC007BC0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739404EC007BC0@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Ajay,

TPS65950 GPIO2 is to choose through u131 if we drive the lines to the
evm mother board or to the expansion connector p18. Should not it be
default to the mother board?
The EHCI port on the mother board works with this patch.

Bryan

> Hi,
> > Set the VAUX2 regulator supply to 1.8V for the HSUSB host interface.
> > Gpio 2 of the TPS65950 has to be set to zero in order to enable the
> > HSUBS2 clock.
> 
> TPS65950 GPIO2 is not to enable HSUSB2 clock but to enable chip u131
> On omap3evm (rev-G) which latches USB, camera and audio lines.
> 
> > 
> > Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> > omap2/board-omap3evm.c
> > index c452b3f..13a2b71 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -377,6 +377,10 @@ static int omap3evm_twl_gpio_setup(struct device
> > *dev,
> >  	if (r)
> >  		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
> > 
> > +	/* gpio + 2 == HSUSB2 Clock Enable */
> > +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> > +		gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW,
> > "EN_HSUSB2_CLK");
> > +
> 
> Did you test EHCI port with this change ?
> 
> Ajay
> >  	/* gpio + 7 == DVI Enable */
> >  	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
> [...]
> rm-kernel
