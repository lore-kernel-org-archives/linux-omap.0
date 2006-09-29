From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: H4 with 2.6.9 from TI dev site not booting
Date: Fri, 29 Sep 2006 15:05:15 +0100
Message-ID: <00b701c6e3d0$4a1439a0$642aa8c0@Buffy>
References: <EA12F909C0431D458B9D18A176BEE4A507E2E1A5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A507E2E1A5@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All, Richard,

Thanks for the pointer.
Grepping through the H4 header files I find that R1 needs to be set to 510
before I start the kernel. That brings me to the next failure :-(

I'm not that familiar with the kernel start sequence so I'm looking for some
guidance here. I have a stack trace up to the point where I hit a kernel
panic:

-000|panic(fmt = 0xC01E8468)
-001|do_exit(code = 11)
-002|die(str = 0xC01E6E9C, regs = 0x0B, err = -1071050528)
-003|__do_kernel_fault(mm = 0xC02910E0, addr = 3223420624, fsr = 11, regs =
0xC02180C0)
-004|do_page_fault(addr = 0, fsr = 5, regs = 0xC0217E78)
-005|do_DataAbort(addr = 0, fsr = 5, regs = 0xC0217E78)
-006|__dabt_svc(asm)
 -->|exception
-007|kmem_cache_alloc(?, ?)
-008|send_signal(sig = 7, info = 0x1, t = 0xC02180C0, signals = 0xC0218338)
-009|specific_send_sig_info(sig = 7, info = 0x1, t = 0xC02180C0)
-010|force_sig_info(sig = 7, info = 0x1, t = 0xC02180C0)
-011|do_DataAbort(addr = 3624919056, fsr = 2056, regs = 0xC0217F64)
-012|__dabt_svc(asm)
 -->|exception
-013|omap24xx_init_irq()
-014|init_IRQ()
-015|start_kernel()
-016|__mmap_switched(asm)
 ---|end of frame
    |

I'm looking for some pointers as to where I should start searching for the
problem here. My guess is that's it's somewhere inside the Kernel page fault
handler but I don't know enough to get beyond that.

TIA,

Richard.


-----Original Message-----
From: Woodruff, Richard [mailto:r-woodruff2@ti.com] 
Sent: 29 September 2006 14:35
To: Richard Copeman; linux-omap-open-source@linux.omap.com
Subject: RE: H4 with 2.6.9 from TI dev site not booting

It is likely your u-boot or kernel might be mis-matched with respect to
the mach-type.

This is just a simple error hang loop.  If it can't figure out processor
variant or mach-type it jumps to a hang. It is likely either a mismatch
or memory corruption.

Regards,
Richard W.
 

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com 
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> Behalf Of Richard Copeman
> Sent: Friday, September 29, 2006 7:52 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: H4 with 2.6.9 from TI dev site not booting
> 
> Hi,
> 
>  
> 
> I wonder if anyone has any experience with LINUX 2.6.9 built 
> with gcc 3.4.1
> for ARM running on TI OMAP2420 H4 board.
> 
>  
> 
> I download the kernel via JTAG to 0x80000000 and start it 
> running. It runs
> for 35 instructions and then ends up in a tight loop at 
> 0x80008118 which
> contains a nop followed by a branch to 0x80008118.
> 
>  
> 
> Can someone point me in the right direction please?
> 
>  
> 
> TIA,
> 
>  
> 
> Richard.
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
