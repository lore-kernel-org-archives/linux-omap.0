From: David Brownell <david-b@pacbell.net>
Subject: Re: Common code for TSC 2101 and 2102
Date: Fri, 13 Jul 2007 13:04:23 -0700
Message-ID: <200707131304.24074.david-b@pacbell.net>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<5d5443650707130010i3327f533o9c480f249ea6d796@mail.gmail.com>
	<fb249edb0707131229t3a8f87c8l1cb584db74ab8076@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0707131229t3a8f87c8l1cb584db74ab8076@mail.gmail.com>
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
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Friday 13 July 2007, andrzej zaborowski wrote:

> > do not add new typedefs
> > #1796: FILE: include/linux/spi/tsc210x.h:54:
> > +typedef void (*tsc210x_touch_t)(void *context, int touching);
> >
> > do not add new typedefs
> > #1797: FILE: include/linux/spi/tsc210x.h:55:
> > +typedef void (*tsc210x_coords_t)(void *context, int x, int y, int z1, int z2);
> >
> > do not add new typedefs
> > #1798: FILE: include/linux/spi/tsc210x.h:56:
> > +typedef void (*tsc210x_ports_t)(void *context, int bat[], int aux[]);
> >
> > do not add new typedefs
> > #1799: FILE: include/linux/spi/tsc210x.h:57:
> > +typedef void (*tsc210x_temp_t)(void *context, int temp);
> 
> I wonder what is used instead.

I think the "no new typedefs" rule gets relaxed for function
call prototypes.  But to answer your question:  it's usually
more clear to just put the function prototype into the relevant
type declarator than to define a new type.

- Dave
