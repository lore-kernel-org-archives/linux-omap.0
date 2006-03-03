From: Tony Lindgren <tony@atomide.com>
Subject: Re: [help] busy loop at omap_serial_reset()
Date: Fri, 3 Mar 2006 11:00:33 -0800
Message-ID: <20060303190033.GF4398@atomide.com>
References: <20060301.175750.92583404.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060301.175750.92583404.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroki Kaminaga <kaminaga@sm.sony.co.jp> [060301 01:00]:
> Hi,
> 
> I'm facing a problem as below:
> 
> I'm trying to boot from uncompressed linux kernel.
> Kernel image is allocated by boot loader.
> When control is moved to kernel (pc is set to .stext of kernel head.S),
> it starts fine, until it enters omap_serial_init() -> omap_serial_reset().
> Here, value 0x1 is written to UART_OMAP_SYSC, and busy loops until the written
> value is read. The target board hangs here, since the written value could 
> not be read (or reads the default 0x0 value).
> 
> Is there something that have to be set/done by boot loader before entering
> kernel for serial config?

If you have the lowlevel debug on in the kernel, you need to leave the
serial port enabled and configured for the kernel from the bootloader.
Maybe you don't have the serial clock on? Or maybe your loop also tries
to read for another uninitialized serial port?

Regards,

Tony
