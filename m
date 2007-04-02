From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: TSC2101/2102
Date: Mon, 2 Apr 2007 09:43:58 -0400
Message-ID: <a0580c510704020643k6c29da26h548385a1dd1b348f@mail.gmail.com>
References: <010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
	<006e01c76a91$8ee234e0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070320132757.GB19913@atomide.com>
	<20070320155455.c1a3219b.jarkko.nikula@nokia.com>
	<20070320153812.GI19913@atomide.com>
	<a0580c510703211224y60c9283bv822276225c3e2c08@mail.gmail.com>
	<20070322084830.1a91c99c.jarkko.nikula@nokia.com>
	<20070330184933.GB18375@atomide.com>
	<a0580c510703310552h2d455e30qb145270bec2be37f@mail.gmail.com>
	<20070331170100.GA2565@bitbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070331170100.GA2565@bitbox>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@solidboot.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Imre Deak,




On 3/31/07, Imre Deak <imre.deak@solidboot.com> wrote:
> On Sat, Mar 31, 2007 at 08:52:17AM -0400, Eduardo Valentin wrote:
> > Hello Tony,
> >
> >
> >    This is an updated patch to fix lcd for H2 board. This one is
> > applied against
> > current linux omap (commit ).
> >
> >    The patch is a merge of what was discussed here and what is already
> >    pushed.
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> >
> > BR,
> >
> > Eduardo Valentin
> >
> > [...]
> >
> > Index: linux-omap-2.6/arch/arm/mach-omap1/board-h2.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/mach-omap1/board-h2.c        2007-03-30 14:26:13.000000000 -0400
> > +++ linux-omap-2.6/arch/arm/mach-omap1/board-h2.c     2007-03-30 14:36:53.000000000 -0400
> > @@ -305,6 +305,19 @@ struct {
> >  #define TSC2101_MUX_MCLK_ON  R10_1610_MCLK_ON
> >  #define TSC2101_MUX_MCLK_OFF R10_1610_MCLK_OFF
> >
> > +static void h2_lcd_dev_init(struct spi_device *tsc2101)
> > +{
> > +     /* The LCD is connected to the GPIO pins of the TSC2101, so
> > +      * we have to tie them here. We can also register the LCD driver
> > +      * first only here, where we know that the TSC driver is ready.
> > +      */
> > +
> > +     device_initialize(&h2_lcd_device.dev);
> > +
> > +     dev_set_drvdata(&h2_lcd_device.dev, tsc2101);
>
> Is this really necessary? Why isn't it ok to pass it through the
> platform_data?

   I tested also with
h2_lcd_device.dev.platform_data = tsc2101;

   But the lcd is not initialized using this line. During the board
boot, it prints:
lcd_h2 lcd_h2: no platform data

  I know that it is weird, but that's why I used dev_set_drvdata().


BR,

Eduardo Valentin

>
> --Imre
>
>


-- 
Eduardo Bezerra Valentin
