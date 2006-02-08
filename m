From: Tony Lindgren <tony@atomide.com>
Subject: Re: serial on omap in current git.
Date: Tue, 7 Feb 2006 16:14:08 -0800
Message-ID: <20060208001408.GM27148@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A504365CEA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A504365CEA@dlee02.ent.ti.com>
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

* Woodruff, Richard <r-woodruff2@ti.com> [060207 16:00]:
> Tony,
> 
> Not that it fixes the issue you saw but it may half explain others. With
> the tx threshold interrupt.
> 
> 	The:
> 		serial_outp(up, UART_FCR, fcr) in
> serial8250_set_termios() won't set the UART_FCR_T_TRIG_10 as expected as
> the UART_EFR.UART_EFR_ECB bit is not set.  Bits 5:4 of the FCR are not
> settable with out the EFR bit4 set.
> 
> The current code seems to only think it needs to set the ECB at sleep
> time, else it just writes a 0 back into the EFR.

Thanks. Do you have a patch around for that?

Tony
