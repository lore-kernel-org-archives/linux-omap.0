From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
Date: Sun, 29 Jan 2017 10:01:08 -0800
Message-ID: <20170129180108.GA10743@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com>
 <20170128193558.GC38136@dtor-ws>
 <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F39E49DD-45AF-4491-A26E-F3A9D86F30F6-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr Cvek <petr>
List-Id: linux-omap@vger.kernel.org

On Sun, Jan 29, 2017 at 09:39:39AM +0100, H. Nikolaus Schaller wrote:
> Hi Dmitry,
> 
> > Am 28.01.2017 um 20:35 schrieb Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > 
> > On Wed, Dec 28, 2016 at 03:53:21PM +0100, H. Nikolaus Schaller wrote:
> >> Fix module table so that the driver is loaded if compiled
> >> as module and requested by DT.
> >> 
> > 
> > I believe I already replied to a similar patch: we alreadyhave necessary
> > aliases in this driver, we need to fix module loading to use it.
> 
> Yes, you did comment on [PATCH v6 7/8] (19 Nov 2016):
> 
> >> We really need to fix it between spi/i23c core and module utils instead
> >> of keeping adding duplicate IDs all over drivers. We already have OF
> >> module device table containing the same data, we should be able to use
> >> it.
> 
> And Javier Martinez Canillas replied (23 Nov 2016):
> 
> > Agreed, unfortunately until the I2C and SPI core are changed to properly
> > report OF modaliases, we will have to keep adding these duplicated IDs.
> > 
> > And changing the I2C and SPI core isn't trivial since it could break a
> > lot of drivers that rely on a platform modalias being reported (i.e: no
> > OF device IDs present in the drivers even when are registered via DT).
> 
> Therefore I didn't see a need to change it.

I agree that changing I2C and SPI core is not trivial, however this is
no reason for piling up workarounds in all drivers. Are you seriously
advocating going though *every* driver and copying OF data into I2C/SPI
instead of doing the right thing and fixing the root of the issue?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
