From: Tony Lindgren <tony@atomide.com>
Subject: Re: serial on omap in current git.
Date: Mon, 20 Feb 2006 16:03:39 -0800
Message-ID: <20060221000338.GI30248@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A5044B2C35@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5044B2C35@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [060213 10:51]:
> > So the extended capabilities bit is needed to write fcr, or else some
> > settings don't get set?
> 
> That is what the OMAP-UART data sheet says.  The write water mark bits
> 4:5 are not accessible unless ECB is set.
> 
> The data sheet says it is TI16C750 compatible but it seems to share more
> with what the code calls a TI16C752.  The 750 has a DLAB to set 64bit
> fifo and I don't believe that is the case for ours.
> 
> The code id's it as a 16654 which isn't quite correct.
> 
> > Can you list the 8250.c issues you've seen?
> 
> The TX watermark, the IRQ_HANDLED not working, then the recent error
> which you worked around.
>  
> > > A minor note is we are still only using 32 bytes of the 64 byte TX
> fifo
> > > for transmits in the current code.  I'm not sure if there is an
> > > application that this matters to.
> > 
> > I guess that could help on bluetooth maybe.
> 
> Sure.  For fast Bluetooth I would think both DMA and flow control should
> also be enabled.  I doubt both would just work given it identified
> wrongly and the details around these areas are exactly what are
> differently between the 554/750/752 as far as I can tell.

I've pushed this, let's see how it works and then send it to RMK.

Tony
