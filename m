From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Wed, 22 Jul 2015 00:13:34 -0500
Message-ID: <20150722051334.GA2165@deathstar>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
 <20150721093441.GA23241@amd>
 <20150722001741.GA7950@deathstar>
 <20150722020306.GA8379@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150722020306.GA8379@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 22, 2015 at 04:03:07AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jul 21, 2015 at 07:17:41PM -0500, Michael Welling wrote:
> > On Tue, Jul 21, 2015 at 11:34:41AM +0200, Pavel Machek wrote:
> > 
> > This code has my head spinning.
> > 
> > I found that the errors do not occur when the driver is built into the kernel.
> > 
> > I also found that with the patch below the errors go away.
> > 
> > Not sure if it is acceptible but see if it fixes things on your side.
> > 
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index cf8b91b..3164d13 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1801,11 +1801,11 @@ int spi_setup(struct spi_device *spi)
> >  	if (!spi->max_speed_hz)
> >  		spi->max_speed_hz = spi->master->max_speed_hz;
> >  
> > -	spi_set_cs(spi, false);
> > -
> >  	if (spi->master->setup)
> >  		status = spi->master->setup(spi);
> >  
> > +	spi_set_cs(spi, false);
> > +
> >  	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
> >  			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
> >  			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
> 
> mh. maybe a runtime PM issue?

mh?

> 
>  * external abort on non-linefetch: address cannot be accessed,
>    since the module's clocks are disabled
>  * built-in works, module not: built-in is probably a little bit
>    faster (module must not be loaded from filesystem), so that
>    the device has not yet been suspended
>  * Before 4.2, omap2_mcspi_set_cs() was called in the setup
>    routine, which acquired runtime PM
>  * In 4.2, omap2_mcspi_set_cs() seems to be called without a
>    prior pm_runtime_get_sync()
>  * With your workaround, the device has not yet returned to
>    suspend after the runtime PM acquisition in setup()
> 
> So I suggest trying the following (compile tested only) patch:
>

It seems you are right.

With this patch the SPI drivers no longer cause data aborts.

I will wait for feedback from Pavel and Pali but it looks like
we have a winner.

> -- Sebastian
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 5867384..f7d9ffd 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
>  
>  static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
>  {
> +       struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
>         u32 l;
>  
>         /* The controller handles the inverted chip selects
> @@ -255,6 +256,8 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
>                 enable = !enable;
>  
>         if (spi->controller_state) {
> +               pm_runtime_get_sync(mcspi->dev);
> +

Should the return code should be checked here as with the other
instances of pm_runtime_get_sync?

>                 l = mcspi_cached_chconf0(spi);
>  
>                 if (enable)
> @@ -263,6 +266,9 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
>                         l |= OMAP2_MCSPI_CHCONF_FORCE;
>  
>                 mcspi_write_chconf0(spi, l);
> +
> +               pm_runtime_mark_last_busy(mcspi->dev);
> +               pm_runtime_put_autosuspend(mcspi->dev);
>         }
>  }
>  
