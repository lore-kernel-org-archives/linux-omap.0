From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] arm:omap2:board-generic: Add DT support for AM33xx
 devices
Date: Thu, 19 Jan 2012 08:10:43 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317AAA52@DBDE01.ent.ti.com>
References: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
 <20120118205828.GM4223@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120118205828.GM4223-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 19, 2012 at 02:28:28, Grant Likely wrote:
> On Wed, Jan 18, 2012 at 12:43:58PM +0530, Vaibhav Hiremath wrote:
> > Although we consider am33xx device under omap34xx family of devices,
> > there is indeed difference between them, for example,
> > 
> >       - Initial required mapping (->map_io)
> >       - Early init (->init_early)
> > 	Here, the whole sequence/data is different than omap3,
> > 	For example, clock/hwmod/power/voltage data.
> >       - clock event/source timer (name and instances)
> > 
> > So, this patch adds seperate machine descriptor for AM33XX family
> > of devices in board-generic.c file.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
> > CC: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> > Tested it on AM335x-EVM, AM37xEVM and AM3517EVM.
> > 
> >  arch/arm/mach-omap2/board-generic.c |   19 +++++++++++++++++++
> >  1 files changed, 19 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> > index f7b4b24..2faecc8 100644
> > --- a/arch/arm/mach-omap2/board-generic.c
> > +++ b/arch/arm/mach-omap2/board-generic.c
> > @@ -106,6 +106,25 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
> >  MACHINE_END
> >  #endif
> > 
> > +#if defined(CONFIG_SOC_OMAPAM33XX)
> > +static const char *am33xx_boards_compat[] __initdata = {
> > +	"ti,am33xx",
> 
> Don't forget to add the new compatible values to
> Documentation/device-tree/bindings.
> 
Thanks for pointing me to this. I will send separate patch updating 
Documentation/devicetree/bindings file for this.

> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
> > +	.atag_offset	= 0x100,
> 
> Unneeded for DT booting.
> 
> Otherwise, you can add:
> 
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 

Thanks for review and ack.

Thanks,
Vaibhav

> > +	.reserve	= omap_reserve,
> > +	.map_io		= am33xx_map_io,
> > +	.init_early	= am33xx_init_early,
> > +	.init_irq	= omap_init_irq,
> > +	.handle_irq	= omap3_intc_handle_irq,
> > +	.init_machine	= omap_generic_init,
> > +	.timer		= &omap3_am33xx_timer,
> > +	.dt_compat	= am33xx_boards_compat,
> > +MACHINE_END
> > +#endif
> > +
> >  #if defined(CONFIG_ARCH_OMAP4)
> >  static const char *omap4_boards_compat[] __initdata = {
> >  	"ti,omap4",
> > --
> > 1.7.0.4
> > 
> 
