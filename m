From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: expand the description of the
 debug facility
Date: Wed, 7 Oct 2015 09:53:38 +0200
Message-ID: <20151007075338.GH3982@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5614CDAE.6070604@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Hello Roger,

On Wed, Oct 07, 2015 at 10:45:50AM +0300, Roger Quadros wrote:
> On 06/10/15 23:07, Uwe Kleine-K=F6nig wrote:
> > Most register values for the chip select setup depend on the frequency
> > of the fck clock.
> > So add a hint that the values setup by the bootloader might differ from
> > the right setup for Linux if the bootloader uses a different frequency.
> > =

> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/memory/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> > =

> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > index c6a644b22af4..1414dd53be57 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -64,6 +64,9 @@ config OMAP_GPMC_DEBUG
> >  	  Enables verbose debugging mostly to decode the bootloader provided
> >  	  timings. Enable this during development to configure devices
> >  	  connected to the GPMC bus.
> > +	  Note that you cannot just tweak your device tree until the registers
> > +	  setup by linux match what the bootloader did because that one might
> > +	  use a different fck frequency influencing most register settings.
> =

> Looks like we can't know for sure the GPMC fclk used at the bootloader
> else we could have just printed the GPMC fclk pre and post gpmc settings.
> =

> How about this instead?
> =

> NOTE: Apart from matching the register setup with the bootloader you also=
 need to
> match the GPMC FCLK frequency used by the bootloader else the GPMC timings
> won't be identical with the bootloader timings.
Yeah, sounds better, thanks.

> Also you might need to build this patch on top of
> http://article.gmane.org/gmane.linux.kernel/2054796
I talked to Tony about this patch yesterday on irc, but I didn't find it
in the archives yet when I sent my mail.

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
