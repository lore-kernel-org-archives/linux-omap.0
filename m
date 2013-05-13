From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] spi/omap2: Let device core handle pinctrl
Date: Mon, 13 May 2013 06:25:12 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EBEA4CC@DBDE04.ent.ti.com>
References: <1367868998-12667-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EBE473A@DBDE04.ent.ti.com>
	<20130507085535.GN7478@sirena.org.uk>
	<1BAFE6F6C881BF42822005164F1491C33EBE4E07@DBDE04.ent.ti.com>
	<20130510095629.GM3200@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130510095629.GM3200-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 10, 2013 at 15:26:29, Mark Brown wrote:
> On Tue, May 07, 2013 at 10:47:31AM +0000, Hebbar, Gururaja wrote:
> > On Tue, May 07, 2013 at 14:25:35, Mark Brown wrote:
> 
> > > There's also been some discussion about factoring out the suspend/resume
> > > code since it's going to get equally repetitive.
> 
> > Really. Any link/referenceso that I can follow.
> > But I think each module will have its own work to do. May be I can confirm once 
> > I look at the factoring-out discussion.
> 
> It was part of the threads where the idea of adding the helper for the
> boilerplate stuff to the core was discussed initially IIRC.

Ok. Thanks. I will check for it.

> 
> > > > I will be submitting a patch to enhance the existing pinctrl support for 
> > > > spi omap2 shortly which does above work.
> 
> > > How soon is shortly?
> 
> > Since I am adding this Pinctrl PM mode support to many other drivers (i2c, 
> > cpsw, da8xx-fb, hsmmc, ti-pwm, usb ...), I would say Shortly = 1 week - 10 days.
> 
> Well, I guess I'll keep the patch for now and drop it when you send out
> the PM code.

Fair enough.

> 


Regards, 
Gururaja

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
