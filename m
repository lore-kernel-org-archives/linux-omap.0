From: Tony Lindgren <tony@atomide.com>
Subject: Re: palmte lcd warnings
Date: Mon, 3 Apr 2006 12:24:18 -0700
Message-ID: <20060403192415.GL13009@atomide.com>
References: <20060328202906.93477.qmail@web32909.mail.mud.yahoo.com>
	<fb249edb0603281516j555bcdf4o30205700fddf0167@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0603281516j555bcdf4o30205700fddf0167@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060328 15:16]:
> On 28/03/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> > Build warning from lcd panel source - latest omap-git tree.
> >
> > ...
> > -c -o drivers/video/omap/lcd_palmte.o drivers/video/omap/lcd_palmte.c
> > drivers/video/omap/lcd_palmte.c:86: warning: initialization from
> > incompatible pointer type
> > drivers/video/omap/lcd_palmte.c:87: warning: initialization from
> > incompatible pointer type
> > drivers/video/omap/lcd_palmte.c:88: warning: initialization from
> > incompatible pointer type
> > drivers/video/omap/lcd_palmte.c:89: warning: initialization from
> > incompatible pointer type
> > drivers/video/omap/lcd_palmte.c:90: warning: initialization from
> > incompatible pointer type
> > ....
> >
> > ---Komal Shah
> > http://komalshah.blogspot.com/
> >
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam protection around
> > http://mail.yahoo.com
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> 
> Please find the fix attached. Tested to build and to work.
> Regards,

Pushing this today.

Tony
