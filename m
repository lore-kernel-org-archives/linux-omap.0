From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
Date: Wed, 1 Feb 2017 14:28:32 -0800
Message-ID: <20170201222832.GA25554@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com>
 <20170128193558.GC38136@dtor-ws>
 <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com>
 <20170129180108.GA10743@dtor-ws>
 <A169CC1E-9EC9-43CA-887B-1382F1903CE1@goldelico.com>
 <B64DBFB0-62E8-4B4C-957F-C90C33BEF693@goldelico.com>
 <cc403765-9b88-1424-a77f-36e775fbd5a0@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cc403765-9b88-1424-a77f-36e775fbd5a0-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michel Verlaan <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 01, 2017 at 06:14:39PM -0300, Javier Martinez Canillas wrote:
> Hello Nikolaus,
> 
> On 02/01/2017 05:20 PM, H. Nikolaus Schaller wrote:
> > Hi Dmitry, Javier,
> > 
> >> Am 29.01.2017 um 19:25 schrieb H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
> >>
> >> Hi Dmitry,
> >>
> >>> Am 29.01.2017 um 19:01 schrieb Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>>
> >>> On Sun, Jan 29, 2017 at 09:39:39AM +0100, H. Nikolaus Schaller wrote:
> >>>> Hi Dmitry,
> >>>>
> >>>>> Am 28.01.2017 um 20:35 schrieb Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>>>>
> >>>>> On Wed, Dec 28, 2016 at 03:53:21PM +0100, H. Nikolaus Schaller wrote:
> >>>>>> Fix module table so that the driver is loaded if compiled
> >>>>>> as module and requested by DT.
> >>>>>>
> >>>>>
> >>>>> I believe I already replied to a similar patch: we alreadyhave necessary
> >>>>> aliases in this driver, we need to fix module loading to use it.
> >>>>
> >>>> Yes, you did comment on [PATCH v6 7/8] (19 Nov 2016):
> >>>>
> >>>>>> We really need to fix it between spi/i23c core and module utils instead
> >>>>>> of keeping adding duplicate IDs all over drivers. We already have OF
> >>>>>> module device table containing the same data, we should be able to use
> >>>>>> it.
> >>>>
> >>>> And Javier Martinez Canillas replied (23 Nov 2016):
> >>>>
> >>>>> Agreed, unfortunately until the I2C and SPI core are changed to properly
> >>>>> report OF modaliases, we will have to keep adding these duplicated IDs.
> >>>>>
> >>>>> And changing the I2C and SPI core isn't trivial since it could break a
> >>>>> lot of drivers that rely on a platform modalias being reported (i.e: no
> >>>>> OF device IDs present in the drivers even when are registered via DT).
> >>>>
> >>>> Therefore I didn't see a need to change it.
> >>>
> >>> I agree that changing I2C and SPI core is not trivial, however this is
> >>> no reason for piling up workarounds in all drivers. Are you seriously
> >>> advocating going though *every* driver and copying OF data into I2C/SPI
> >>> instead of doing the right thing and fixing the root of the issue?
> >>
> >> If you prefer to have this done (and I agree it would be a tiny improvement),
> >> please do it for us all. But please after merging this workaround.
> > 
> > Have we been lucky to find someone who is able and willing to work on this?
> >
> 
> As said, changing the core is trivial. A RFC patch is [0].
> 
> The problem is how to make sure that this change won't cause regressions
> in existing drivers.

If the concern with drivers having I2C or SPI device table, but not OF
device table, then I think cocinnelle could be used to scan and find
them.

> 
> There was particularly tricky for the spi-nor driver, it doesn't help that
> a lot of DT are using undocumented compatible strings (sometimes with no
> vendor prefix). You can see the discussion here [1].
> 
> In the same thread Mark Brown said that it wasn't that bad to have the
> information in the OF device ID table duplicated in a SPI device table.
> 
> Certainly isn't the best approach but IMHO is better than the module not
> loading.

You can always build the module into kernel or load it by hand if it is
that important. Module autoloading does not work anyway if you have
several compatible strings, like

	compatible = "vendor,new-device", "vendor,generic-device";

Thanks.

-- 
Dmitry
