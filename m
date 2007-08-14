From: David Brownell <david-b@pacbell.net>
Subject: Re: Common code for TSC 2101 and 2102
Date: Mon, 13 Aug 2007 22:34:41 -0700
Message-ID: <200708132234.41538.david-b@pacbell.net>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<200708102004.59747.david-b@pacbell.net>
	<20070813070512.GC13948@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070813070512.GC13948@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Monday 13 August 2007, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [070810 20:05]:
> > On Friday 10 August 2007, Tony Lindgren wrote:
> > > I'll be pushing Andrzej's patch today.
> > 
> > I saw it ... it was after I've finally started to dig
> > out from under my pile of patches going upstream, and
> > even fired up an OMAP build again!  :)
> 
> Cool :)

Following this will be several patches, two related to
this driver:

 - H4 board support, using TSC2101 (not TSC2102)
 - A biggish tsc210x cleanup patch, with some bugfixes

The main thing I'd call a bug in the tsc210x code is the
hwmon support not reporting milliVolts.  Easily enough
solved after passing some more info down the hwmon code
via platform_data:  actual VREF, chip type, precision.

For boards using external VREF, that value should be in
the tsc210x chip platform data.  (And Andrzej, I'm
curious why you settled on VREF=1.25V vs 2.50V ... not
that it's necessarily an issue, just "why".  A comment
in the code might be good.)

Somewhat related, I think the TSC setup code should
likely hold off until it can fetch calibration data
from EEPROM or somesuch ... temperature readings are
not all that useful until that data is available.
Alternatively, do like I did in ads7846:  punt it all
to userspace, just provide the raw milliVolt readings
and expect someone else to compute temperature.

I only did really basic touchscreen testing, to verify
that data came out of /dev/input/event1.  Not to check
that it was "good" data.  I suspect there's some work
yet to be done there.

- Dave
