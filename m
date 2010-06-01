From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH 2/5] OMAP3: McBSP: Change the way how
	the FIFO is handled
Date: Tue, 1 Jun 2010 09:59:20 +0300
Message-ID: <201006010959.20610.peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<1275293810-31984-3-git-send-email-peter.ujfalusi@nokia.com>
	<4C03F4B8.9090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4C03F4B8.9090306@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Monday 31 May 2010 20:41:12 ext Nishanth Menon wrote:
> On 05/31/2010 11:16 AM, Peter Ujfalusi wrote:
> > Use the actual FIFO size in words as buffer_size on OMAP2.
> > Change the threshold configuration to use 1 based numbering, when
> > specifying the allowed threshold maximum or the McBSP threshold value.
> > Set the default maximum threshold to (buffer_size - 0x10) intialy.
> > =

> >> From users of McBSP, now it is expected to use this method.
> > =

> > Asking for threshold 1 means that the value written to threshold
> > registers are going to be 0, which means 1 word threshold.
> =

> just a 2cent minor comment: maybe omap_mcbsp_platform_data needs
> structure documentation.. it might be difficult for folks to figure that
> out from commit ID itself..

I can add comments in the mach-omap2/mcbsp.c like this:

> =

> > Signed-off-by: Peter Ujfalusi<peter.ujfalusi@nokia.com>
> > ---
> > =

> >   arch/arm/mach-omap2/mcbsp.c |   10 +++++-----
> >   arch/arm/plat-omap/mcbsp.c  |   10 ++++++----
> >   2 files changed, 11 insertions(+), 9 deletions(-)
> > =

> > diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> > index 016fe60..9139958 100644
> > --- a/arch/arm/mach-omap2/mcbsp.c
> > +++ b/arch/arm/mach-omap2/mcbsp.c
> > @@ -132,7 +132,7 @@ static struct omap_mcbsp_platform_data
> > omap34xx_mcbsp_pdata[] =3D {
> > =

> >   		.rx_irq		=3D INT_24XX_MCBSP1_IRQ_RX,
> >   		.tx_irq		=3D INT_24XX_MCBSP1_IRQ_TX,
> >   		.ops		=3D&omap2_mcbsp_ops,
> > =

> > -		.buffer_size	=3D 0x6F,
> > +		.buffer_size	=3D 0x80,

 +		.buffer_size	=3D 0x80, /* The FIFO has 128 locations */

> > =

> >   	},
> >   	{
> >   	=

> >   		.phys_base	=3D OMAP34XX_MCBSP2_BASE,
> > =

> > @@ -142,7 +142,7 @@ static struct omap_mcbsp_platform_data
> > omap34xx_mcbsp_pdata[] =3D {
> > =

> >   		.rx_irq		=3D INT_24XX_MCBSP2_IRQ_RX,
> >   		.tx_irq		=3D INT_24XX_MCBSP2_IRQ_TX,
> >   		.ops		=3D&omap2_mcbsp_ops,
> > =

> > -		.buffer_size	=3D 0x3FF,
> > +		.buffer_size	=3D 0x500,

 +		.buffer_size	=3D 0x500, /* The FIFO has 1024 + 256 locations */

> > =

> >   	},
> >   	{
> >   	=

> >   		.phys_base	=3D OMAP34XX_MCBSP3_BASE,
> > =

> > @@ -152,7 +152,7 @@ static struct omap_mcbsp_platform_data
> > omap34xx_mcbsp_pdata[] =3D {
> > =

> >   		.rx_irq		=3D INT_24XX_MCBSP3_IRQ_RX,
> >   		.tx_irq		=3D INT_24XX_MCBSP3_IRQ_TX,
> >   		.ops		=3D&omap2_mcbsp_ops,
> > =

> > -		.buffer_size	=3D 0x6F,
> > +		.buffer_size	=3D 0x80,

 +		.buffer_size	=3D 0x80, /* The FIFO has 128 locations */

> > =

> >   	},
> >   	{
> >   	=

> >   		.phys_base	=3D OMAP34XX_MCBSP4_BASE,
> > =

> > @@ -161,7 +161,7 @@ static struct omap_mcbsp_platform_data
> > omap34xx_mcbsp_pdata[] =3D {
> > =

> >   		.rx_irq		=3D INT_24XX_MCBSP4_IRQ_RX,
> >   		.tx_irq		=3D INT_24XX_MCBSP4_IRQ_TX,
> >   		.ops		=3D&omap2_mcbsp_ops,
> > =

> > -		.buffer_size	=3D 0x6F,
> > +		.buffer_size	=3D 0x80,
> > =

> >   	},
> >   	{
> >   	=

> >   		.phys_base	=3D OMAP34XX_MCBSP5_BASE,
> > =

> > @@ -170,7 +170,7 @@ static struct omap_mcbsp_platform_data
> > omap34xx_mcbsp_pdata[] =3D {
> > =

> >   		.rx_irq		=3D INT_24XX_MCBSP5_IRQ_RX,
> >   		.tx_irq		=3D INT_24XX_MCBSP5_IRQ_TX,
> >   		.ops		=3D&omap2_mcbsp_ops,
> > =

> > -		.buffer_size	=3D 0x6F,
> > +		.buffer_size	=3D 0x80,
> > =

> >   	},
> >   =

> >   };
> >   #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
> > =

> > diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> > index 51d8abf..6462968 100644
> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -497,7 +497,8 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u=
16
> > threshold)
> > =

> >   	}
> >   	mcbsp =3D id_to_mcbsp_ptr(id);
> > =

> > -	MCBSP_WRITE(mcbsp, THRSH2, threshold);
> > +	if (threshold&&  threshold<=3D mcbsp->max_tx_thres)
> > +		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
> > =

> >   }
> >   EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
> > =

> > @@ -519,7 +520,8 @@ void omap_mcbsp_set_rx_threshold(unsigned int id, u=
16
> > threshold)
> > =

> >   	}
> >   	mcbsp =3D id_to_mcbsp_ptr(id);
> > =

> > -	MCBSP_WRITE(mcbsp, THRSH1, threshold);
> > +	if (threshold&&  threshold<=3D mcbsp->max_rx_thres)
> > +		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
> > =

> >   }
> >   EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
> > =

> > @@ -1696,8 +1698,8 @@ static inline void __devinit
> > omap34xx_device_init(struct omap_mcbsp *mcbsp)
> > =

> >   {
> >   =

> >   	mcbsp->dma_op_mode =3D MCBSP_DMA_MODE_ELEMENT;
> >   	if (cpu_is_omap34xx()) {
> > =

> > -		mcbsp->max_tx_thres =3D max_thres(mcbsp);
> > -		mcbsp->max_rx_thres =3D max_thres(mcbsp);
> > +		mcbsp->max_tx_thres =3D max_thres(mcbsp) - 0x10;
> > +		mcbsp->max_rx_thres =3D max_thres(mcbsp) - 0x10;
> > =

> >   		/*
> >   		=

> >   		 * REVISIT: Set dmap_op_mode to THRESHOLD as default
> >   		 * for mcbsp2 instances.

Is this sufficient?

-- =

P=E9ter
