From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/4] SPI: tsc2xxx core
Date: Tue, 14 Aug 2007 15:50:28 -0700
Message-ID: <200708141550.28530.david-b@pacbell.net>
References: <20070814191229.27333.62004.stgit@localhost.localdomain>
	<200708141312.48347.david-b@pacbell.net>
	<46C21853.9050101@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46C21853.9050101@indt.org.br>
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
To: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 14 August 2007, Ragner Magalhaes wrote:
> ext David Brownell wrote:
> > On Tuesday 14 August 2007, Ragner Magalhaes wrote:
> >> This is the start to build tsc2xxx core with all sharable routines
> >> between tsc2101, tsc2102, tsc2301 ... and more later tsc2100, tsc2111, etc.
> > 
> > I'm getting confused here.  What's the plan?  Is this an entirely
> > different approach from the tsc210x stuff ... and if so, why?
>
> I think we could to have a tsc2xxx core with all main sharable routines
> by tsc2xxx family ... and Chip-specific calling this core routines ...
> 
> And "[PATCH 1/4] SPI: tsc2xxx core" could to be the start ...

Yes, but we also want other sharable code too.  In most cases it
seems that the touchscreen and sensor code is sharable -- modulo
the "what sensors are valid on this system" issue -- and the audio
code isn't.  Plus tsc2301 has keypad support, etc.


> > I took a look at the tsc2101 bits, and I'm puzzled by why the
> > original "int tsc2101_read_sync()" became "u16 tsc2101_read_sync()".
> > 
> > First, why return "int" instead of "negative erno or value"?  Not
> > that errors will be common, but returning "u16" means they can't
> > ever be reported or handled...
> Ok, I do not saw at the kernel's code some thing as
> 
> w = tsc2101_read_sync(spi, 1, 0);
> if (w < 0) {
> 	dev_err(&spi->dev, "Error or invalid anything \n");
> 	goto err;
> }
> 
> I saw ...
> w = tsc2101_read_sync(spi, 1, 0);
> if (!(w & (1 << 14))) {
> 	dev_err(&spi->dev, "Error or invalid anything \n");
> 	goto err;
> }
> 
> I think my solution is not a mistake  about this ...

But, did yoou see the patch I posted yesterday?  It fixes that.
I had a similar patch for the old tsc2101 code too.
 
 
> > I just don't see how these parts are expected to fit together yet.
> > The patch from Andrzej seemed a bit more clear, although it did
> > not cover as much ground at the beginning.  I suspect you have
> > a plan, but it's just not yet apparent to me...
> > 
> > - Dave
>
> Ok, David
> Thanks for yours comments ...
> I go to continue working about this ... to find a better solution ..
