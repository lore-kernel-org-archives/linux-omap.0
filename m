From: Tony Lindgren <tony@atomide.com>
Subject: Re: serial on omap in current git.
Date: Mon, 13 Feb 2006 10:23:57 -0800
Message-ID: <20060213182357.GA5113@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A5044B24F9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5044B24F9@dlee02.ent.ti.com>
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

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [060212 14:15]:
> Actually it is more like this...
> 
> 
> if (up->port.type != PORT_16750) {
> 	if (fcr & UART_FCR_ENABLE_FIFO) {
> 		/* emulated UARTs (Lucent Venus 167x) need two steps */
> 		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
> 	}
> 	if(uart_config[up->port.type].flags & UART_CAP_EFR){
> 		serial_outp(up, UART_LCR, 0xBF); /*allow access to
> EFR(vs LCR)*/
> 		serial_outp(up, UART_EFR, UART_EFR_ECB);/*allow FCR tx
> fifo write*/
> 		serial_outp(up, UART_LCR, 0x0); /* access back to FCR */
> 		serial_outp(up, UART_FCR, fcr); /* set fcr with possible
> TX fifo setting */
> 		serial_outp(up, UART_LCR, 0xBF);
> 		serial_outp(up, UART_EFR, 0);
> 		serial_outp(up, UART_LCR, cval); /* access back to FCR
> */
> 	} else
> 		serial_outp(up, UART_FCR, fcr);

So the extended capabilities bit is needed to write fcr, or else some
settings don't get set?
 
> In my build your last serial hack is not necessary anymore either.

Looks like patch f5968b37b3ad35b682b574b578843a0361218aff fixed it in
the mainline 8250.c:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f5968b37b3ad35b682b574b578843a0361218aff;hp=620739025b94fe472c845ce013bff62716d3c576
 
> I played around a bit trying to remove several of them.  To use the
> actual TX watermark interrupt set at 32bytes required too ugly of a hack
> to use (not use OMAP_SCR=0).

Can you list the 8250.c issues you've seen?
 
> A minor note is we are still only using 32 bytes of the 64 byte TX fifo
> for transmits in the current code.  I'm not sure if there is an
> application that this matters to.

I guess that could help on bluetooth maybe.

Regards,

Tony
