From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: TSC2101/2102
Date: Mon, 2 Apr 2007 16:41:45 -0400
Message-ID: <a0580c510704021341y476604b7l129b11f6a8ce4f57@mail.gmail.com>
References: <006e01c76a91$8ee234e0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070320155455.c1a3219b.jarkko.nikula@nokia.com>
	<20070320153812.GI19913@atomide.com>
	<a0580c510703211224y60c9283bv822276225c3e2c08@mail.gmail.com>
	<20070322084830.1a91c99c.jarkko.nikula@nokia.com>
	<20070330184933.GB18375@atomide.com>
	<a0580c510703310552h2d455e30qb145270bec2be37f@mail.gmail.com>
	<20070331170100.GA2565@bitbox>
	<a0580c510704020643k6c29da26h548385a1dd1b348f@mail.gmail.com>
	<20070402202325.GA23808@bitbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070402202325.GA23808@bitbox>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@solidboot.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello Imre

On 4/2/07, Imre Deak <imre.deak@solidboot.com> wrote:
> On Mon, Apr 02, 2007 at 09:43:58AM -0400, Eduardo Valentin wrote:
> > Hi Imre Deak,
> >
> >
> >
> >
> > On 3/31/07, Imre Deak <imre.deak@solidboot.com> wrote:
> > >On Sat, Mar 31, 2007 at 08:52:17AM -0400, Eduardo Valentin wrote:
> > >> Hello Tony,
> > >>
> > >>
> > >>    This is an updated patch to fix lcd for H2 board. This one is
> > >> applied against
> > >> current linux omap (commit ).
> > >>
> > >>    The patch is a merge of what was discussed here and what is already
> > >>    pushed.
> > >>
> > >> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> > >>
> > >> BR,
> > >>
> > >> Eduardo Valentin
> > >>
> > >> [...]
> > >>
> > >> Index: linux-omap-2.6/arch/arm/mach-omap1/board-h2.c
> > >> ===================================================================
> > >> --- linux-omap-2.6.orig/arch/arm/mach-omap1/board-h2.c        2007-03-30
> > >14:26:13.000000000 -0400
> > >> +++ linux-omap-2.6/arch/arm/mach-omap1/board-h2.c     2007-03-30
> > >14:36:53.000000000 -0400
> > >> @@ -305,6 +305,19 @@ struct {
> > >>  #define TSC2101_MUX_MCLK_ON  R10_1610_MCLK_ON
> > >>  #define TSC2101_MUX_MCLK_OFF R10_1610_MCLK_OFF
> > >>
> > >> +static void h2_lcd_dev_init(struct spi_device *tsc2101)
> > >> +{
> > >> +     /* The LCD is connected to the GPIO pins of the TSC2101, so
> > >> +      * we have to tie them here. We can also register the LCD driver
> > >> +      * first only here, where we know that the TSC driver is ready.
> > >> +      */
> > >> +
> > >> +     device_initialize(&h2_lcd_device.dev);
> > >> +
> > >> +     dev_set_drvdata(&h2_lcd_device.dev, tsc2101);
> > >
> > >Is this really necessary? Why isn't it ok to pass it through the
> > >platform_data?
> >
> >   I tested also with
> > h2_lcd_device.dev.platform_data = tsc2101;
> >
> >   But the lcd is not initialized using this line. During the board
> > boot, it prints:
> > lcd_h2 lcd_h2: no platform data
>
> Odd. Calling platform_device_add is one bug at least so that should be
> fixed as follows:
>
> +static void h2_lcd_dev_init(struct spi_device *tsc2101)
> +{
> +       /* The LCD is connected to the GPIO pins of the TSC2101, so
> +        * we have to tie them here. We can also register the LCD driver
> +        * first only here, where we know that the TSC driver is ready.
> +        */
> +       h2_lcd_device.dev.platform_data = tsc2101;
> +
> +       platform_device_register(&h2_lcd_device);
> +}
>
> >
> >  I know that it is weird, but that's why I used dev_set_drvdata().
>
> I think it's not a good thing to do, since the related field is for driver
> private data.

Yes, I agree with you. It is odd ! :) But with this sequence:

	h2_lcd_device.dev.platform_data = tsc2101;
	platform_device_register(&h2_lcd_device);

The lcd does not initialize properly. During the boot process, it prints:

lcd_h2 lcd_h2: no platform data
tsc2101 spi2.1: initialized

and the lcd device is not powered on.

This is what I'm currently getting here on my H2. Maybe someone would
test this patch also :)

Cheers,


Eduardo Valentin

>
> --Imre
>
>


-- 
Eduardo Bezerra Valentin
