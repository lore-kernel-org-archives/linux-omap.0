From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Subject: Re: [PATCH 1/4] SPI: tsc2xxx core
Date: Tue, 14 Aug 2007 17:02:11 -0400
Message-ID: <46C21853.9050101@indt.org.br>
References: <20070814191229.27333.62004.stgit@localhost.localdomain>
	<200708141312.48347.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200708141312.48347.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext David Brownell wrote:
> On Tuesday 14 August 2007, Ragner Magalhaes wrote:
>> This is the start to build tsc2xxx core with all sharable routines
>> between tsc2101, tsc2102, tsc2301 ... and more later tsc2100, tsc2111, etc.
> 
> I'm getting confused here.  What's the plan?  Is this an entirely
> different approach from the tsc210x stuff ... and if so, why?
I think we could to have a tsc2xxx core with all main sharable routines
by tsc2xxx family ... and Chip-specific calling this core routines ...

And "[PATCH 1/4] SPI: tsc2xxx core" could to be the start ...

> 
> 
> I took a look at the tsc2101 bits, and I'm puzzled by why the
> original "int tsc2101_read_sync()" became "u16 tsc2101_read_sync()".
> 
> First, why return "int" instead of "negative erno or value"?  Not
> that errors will be common, but returning "u16" means they can't
> ever be reported or handled...
Ok, I do not saw at the kernel's code some thing as

w = tsc2101_read_sync(spi, 1, 0);
if (w < 0) {
	dev_err(&spi->dev, "Error or invalid anything \n");
	goto err;
}

I saw ...
w = tsc2101_read_sync(spi, 1, 0);
if (!(w & (1 << 14))) {
	dev_err(&spi->dev, "Error or invalid anything \n");
	goto err;
}

I think my solution is not a mistake  about this ...

> 
> Second, since that just wraps tsc2xxx_read_sync(), why even bother
> wrapping it?  Better to call that directly ... more efficient and
> easier to understand/follow.
Ok, thanks ...
> 
> ... and for that matter, the single-register read/write commands
> seem like they'd best use spi_write_then_read(), since DMA to
> stacks is unsafe and nonportable.
> 
> 
> I certainly like the idea of having *one* core for all these TSC
> chips ... with reusable bits on top.  And I know that audio will
> be one of the nastier bits, so being able to reuse e.g. the H2
> (and H3?) audio support right away seems like a win.  Do your
> patches also give us shared tsc2101/2102 touchscreen and hwmon
> support?

> 
> I just don't see how these parts are expected to fit together yet.
> The patch from Andrzej seemed a bit more clear, although it did
> not cover as much ground at the beginning.  I suspect you have
> a plan, but it's just not yet apparent to me...
> 
> - Dave
Ok, David
Thanks for yours comments ...
I go to continue working about this ... to find a better solution ..

> 
> 


-- 
Ragner Magalhaes
