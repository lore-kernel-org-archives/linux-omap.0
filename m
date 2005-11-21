From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Re: Git tree update, patches sent upstream
Date: Mon, 21 Nov 2005 09:09:35 -0800
Message-ID: <20051121170935.GC15917@atomide.com>
References: <43745428.1428f2bd.23ee.0647@mx.gmail.com>
	<200511110910.07129.david-b@pacbell.net>
	<20051111171650.GA10822@atomide.com>
	<4380BCBF.3010603@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4380BCBF.3010603@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [051120 10:13]:
> Tony Lindgren wrote:
> >* David Brownell <david-b@pacbell.net> [051111 09:10]:
> >
> >>>error: `platform_bus_type' undeclared here (not in a function)
> >>
> >>#include <linux/platform_device.h> is now needed.
> >
> >
> >It's best just replace <linux/device.h> with <linux/platform_device.h>,
> >as it already includes <linux/device.h>.
> 
> Remove error
> 
> drivers/video/omap/omapfb_main.c:1395: error: `platform_bus_type'
> undeclared here (not in a function)
> sound/arm/omap-aic23.c:879: error: `platform_bus_type' undeclared here
> (not in a function)
> 
> Remove warning
> 
> sound/arm/omap-aic23.c:882: warning: initialization from incompatible
> pointer type
> sound/arm/omap-aic23.c:883: warning: initialization from incompatible
> pointer type

Thanks, pushing today.

Tony
