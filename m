From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 3/8] drivers:input:tsc2007: add iio interface to read
 external ADC input and temperature
Date: Tue, 27 Dec 2016 13:54:16 -0800
Message-ID: <20161227215416.GB28140@dtor-ws>
References: <cover.1479823354.git.hns@goldelico.com>
 <cover.1479823354.git.hns@goldelico.com>
 <99f236df48b03b3188e12f94a20097f8440db7a5.1479823354.git.hns@goldelico.com>
 <E42B1EF7-222E-46D6-878B-30C789CFBBC5@jic23.retrosnub.co.uk>
 <811B6F6A-2E3D-45B4-A984-74ABE0E37192@goldelico.com>
 <8d3fc752-e69c-f568-4f71-4f1768a3fffe@kernel.org>
 <AC7B3C1C-C05B-45B5-8426-5225F151DC26@goldelico.com>
 <E4E31180-A686-4631-9713-519987C55F06@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E4E31180-A686-4631-9713-519987C55F06-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 12, 2016 at 10:21:25PM +0100, H. Nikolaus Schaller wrote:
> Hi,
> 
> 
> > Am 27.11.2016 um 16:47 schrieb H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
> > 
> > Hi Jonathan,
> > 
> >> Am 27.11.2016 um 12:02 schrieb Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> >> 
> >> On 24/11/16 18:05, H. Nikolaus Schaller wrote:
> >>> 
> >>>> Am 24.11.2016 um 18:38 schrieb Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>:
> >>>> 
> >>>> 
> >>>> 
> >>>> On 22 November 2016 14:02:30 GMT+00:00, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> 
> > 
> >> - hence cc'd Yann and the Kbuild list
> >> to see if they can offer some advices.
> 
> no response / advice so far.

Since you are saying that IIO stuff is optional, add it to Kconfig
explicitly:

config "TOUCHSCREEN_TSC2007_IIO"
	bool "IIO interface for external ADC input and temperature"
	depends on TOUCHSCREEN_TSC2007
	depends on IIO=y || IIO=TOUCHSCREEN_TSC2007
	help
	  ...

and use this symbols in makefile:

and in Makefile:

obj-$(CONFIG_TOUCHSCREEN_TSC2007) += tsc2007.o
tsc2007-y := tsc2007-core.o ...
tsc2007-$(CONFIG_TOUCHSCREEN_TSC2007_IIO) += tsc2007_iio.o

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
