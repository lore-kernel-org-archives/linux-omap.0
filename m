From: tony@atomide.com
Subject: Re: Git tree updated to 2.6.19-rc2
Date: Fri, 27 Oct 2006 15:53:01 +0300
Message-ID: <20061027125259.GC25245@atomide.com>
References: <20061023203925.GC11967@atomide.com>
	<200610261322.26968.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610261322.26968.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061026 23:22]:
> I measured it at "rc3", myself ... :)
> 
> Here's an update to the musb/tusb code fixing, among other things,
> compile glitches that have recently joined us.  Like removing pt_regs
> in all the IRQ paths, and a rename to <linux/usb/otg.h> ...
> 
> It's possible that (finally) removing the MIN_DMA_REQUEST thing would
> make trouble; best way to test that is probably with g_file_storage.
> If that fails, the obvious (temporary) workaround is disabling DMA.
> 
> - Dave
> 
> 
> Various bugfixes:
>     - gadget side does dma_sync_single_for_*() if the buffer
>       was mapped by the gadget driver (none do that just yet)
>     - host side rx, always force dma request off "just in case",
>       instead of just for Mentor's DMA (i.e. not just OMAP2430)
>     - complain louder about the board needing different driver config
>     - iounmap() registers on rmmod
>     - fault handling fixes in tusb_start()
>     - (from TI) save dma mask so modprobe after use_dma=n can use dma
>     - (from TI) gadget side zero-length IN likes TXPKTRDY before status stage
> 
> Other updates:
>     - catch up to pt_regs finally leaving the irq path, other build fixes
>     - remove pointless headers like <linux/pci.h>
>     - RemoveMoreCamelCaseNastiness
>     - resolve some config-specific compiler warning/error messages
>     - dump tusb irq status register too
>     - remove that MIN_DMA thing; dma logic must now handle zlps
>       in all cases, not just to terminate a transfer
>     - comment fixes

Pushing today.

Tony
