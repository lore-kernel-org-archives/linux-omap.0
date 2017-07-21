From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/11] ARM: OMAP2+: Remove unused legacy code for PRM
Date: Thu, 20 Jul 2017 22:55:10 -0700
Message-ID: <20170721055510.GO10026@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-9-tony@atomide.com>
 <20170630104256.GG3730@atomide.com>
 <20170720144506.rjar4dxih6ixavcp@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170720144506.rjar4dxih6ixavcp@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170720 07:45]:
> Hi,
> 
> On Fri, Jun 30, 2017 at 03:42:56AM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [170531 15:55]:
> > > We are now booting all mach-omap2 in device tree only mode.
> > > Any code that is only called in legacy boot mode where
> > > of_have_populated_dt() is not set is safe to remove now.
> > ...
> > 
> > > diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> > > --- a/arch/arm/mach-omap2/prm44xx.c
> > > +++ b/arch/arm/mach-omap2/prm44xx.c
> > ...
> > 
> > > -static int omap44xx_prm_late_init(void)
> > > -{
> > > -	int irq_num;
> > > -
> > > -	if (!(prm_features & PRM_HAS_IO_WAKEUP))
> > > -		return 0;
> > > -
> > > -	/* OMAP4+ is DT only now */
> > > -	if (!of_have_populated_dt())
> > > -		return 0;
> > 
> > Turns out I misread the above and this code is still needed for omap4 PRM
> > interrupts, so applying a partial revert below to fix it.
> 
> I just spent a couple of hours to tracing this and now saw, that you
> already did so. Why was this not part of the pull request? :(

Sorry I did not notice until I had sent out a pull request. I did
send a pull request for this and few other fixes on the 6th that is
still pending.

> > I probably missed this earlier as the comments used to say
> > "OMAP4+ is DT only now" for !of_have_populated_dt() to exit early and
> > missed the negative test. Let's not add those lines back as they are
> > confusing and no longer needed as we only boot in device tree mode.
> 
> haha, I came up with *exactly* the same patch and then noticed
> this mail when I checked for a Message-ID as reference :)

Sorry to hear about the duplicate work.

> > Without things things can mysterious fail for i2c, for example LM75
> > I2C temperature sensor can stop working as the PRM interrupts won't work.
> 
> Here is the demystification:
> 
> Without this fix omap4_pmx_core and omap4_pmx_wakeup will not
> register themself as interrupt controller, due to missing parent
> interrupt. This means, that any device referencing an interrupt
> in one of those controllers will fail their probe routine with
> -EPROBE_DEFER waiting for the interrupt controller to appear.
> At least for i2c this happens directly in the core, even before
> calling the driver's probe routine making this look quite
> mysterious.
> 
> TLDR: Fix "wakeup-source;" using devices on omap4.

Yup.

Regards,

Tony
