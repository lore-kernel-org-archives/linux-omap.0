From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: H4 with 2.6.9 from TI dev site not booting
Date: Mon, 2 Oct 2006 10:13:10 +0100
Message-ID: <006201c6e602$fb6fd090$642aa8c0@Buffy>
References: <EA12F909C0431D458B9D18A176BEE4A507E2E3A9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A507E2E3A9@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard,

Do you have a link for 2.6.10

Linux.omap.com only gives the option of 2.6.9 for 2420.

Thanks,

Richard

-----Original Message-----
From: Woodruff, Richard [mailto:r-woodruff2@ti.com] 
Sent: 29 September 2006 16:22
To: Richard Copeman; linux-omap-open-source@linux.omap.com
Subject: RE: H4 with 2.6.9 from TI dev site not booting

Richard,

Using a cmm file alone prior to booting the kernel may not work well,
unless your CMM file is very complete in the way it sets up DDR.  There
are some bits about using lock/unlock mode which can cause issues. I
don't expect you have that.

Generally, I just use a CMM file to burn in u-boot, and I know the
u-boot sets up the memory properly.

A recent H4 board could also cause some trouble unfortunately.  The H4
variants in the past have been populated by something like 6 different
memory components.  Recently, someone had informed me that they switched
the component again as the previous part was end of lifed.  I've don't
have that version of the board so I have not tried it.  I suspect your
CMM file could be even more wrong then it was before on that board.

I'll send you a recent u-boot build and you can try it on your board.
If it doesn't work, then yet another memory part needs to be added to
the probe sequence... Or you might be able to get away with updating
your CMM file.

The 2430 download area had a 2.6.10 which worked for both 2420 and 2430.
That image was much better than the 2.6.9 one.  We have some programs
requiring a couple newer kernel versions which are underway, but those
are at fairly early stages and may not have undergone h4 testing.

Regards,
Richard W.

> -----Original Message-----
> From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk] 
> Sent: Friday, September 29, 2006 9:53 AM
> To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> Subject: RE: H4 with 2.6.9 from TI dev site not booting
> 
> Hi Richard,
> 
> The 2.6.9 I downloaded from linux.ti.com as the latest 
> supported version.
> I have 2.6.15 running on my 5912OSK but it didn't have the 
> defconfig for the
> H4 as part of the package that I got.
> There is no reason why I am sticking with 2.6.9 except that 
> it built and
> it's early days yet. I am happy to change if you can point me 
> in the right
> direction...
> 
> I am not using U-boot but downloading vmlinux via JTAG to the 
> target. I have
> the debugger doing most of the board setup to the point where I have
> external memory and the WD is disabled.
> 
> My Device is OMAP X2420CZVL 550667VL YB. How do I tell which 
> memory it has
> on it? AFAIK, it's a fairly recent board; acquired from TI 
> about 8 weeks
> ago.
> 
> I have managed to trap at the panic function and the buf 
> contains the string
> "Attempted to kill the idle task!" I'm guessing this is not a 
> good thing,
> right :-)
> 
> If a later version is more stable or more likely to bring me 
> success I'm
> happy to migrate.
> 
> Thanks.
> 
> Richard.
> 
> -----Original Message-----
> From: Woodruff, Richard [mailto:r-woodruff2@ti.com] 
> Sent: 29 September 2006 15:42
> To: Richard Copeman; linux-omap-open-source@linux.omap.com
> Subject: RE: H4 with 2.6.9 from TI dev site not booting
> 
> Richard,
> 
> I think you may be attacking this from a less than optimal way.  Is
> there any reason you need the 2.6.9 kernel per say?  There 
> was a 2.6.10
> one which should work just fine.
> 
> I would suspect that your board revision along with u-boot 
> version might
> be a lot of your problem.
> 
> If you provide a u-boot dump of the board boot up, then some more
> information can be clarified.
> 
> I can send you a u-boot which should work across boards, assuming your
> board is not too old.
> 
> If you have a 2420-ES1 chip and you have a DDR part, then you 
> will be in
> for a rough ride.  You should use SDRAM in that case.  Many bugs
> hardware and software have been fixed between the very first board and
> the current boards...
> 
> Regards,
> Richard W .
> > -----Original Message-----
> > From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk] 
> > Sent: Friday, September 29, 2006 9:05 AM
> > To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> > Subject: RE: H4 with 2.6.9 from TI dev site not booting
> > 
> > Hi All, Richard,
> > 
> > Thanks for the pointer.
> > Grepping through the H4 header files I find that R1 needs to 
> > be set to 510
> > before I start the kernel. That brings me to the next failure :-(
> > 
> > I'm not that familiar with the kernel start sequence so I'm 
> > looking for some
> > guidance here. I have a stack trace up to the point where I 
> > hit a kernel
> > panic:
> > 
> > -000|panic(fmt = 0xC01E8468)
> > -001|do_exit(code = 11)
> > -002|die(str = 0xC01E6E9C, regs = 0x0B, err = -1071050528)
> > -003|__do_kernel_fault(mm = 0xC02910E0, addr = 3223420624, 
> > fsr = 11, regs =
> > 0xC02180C0)
> > -004|do_page_fault(addr = 0, fsr = 5, regs = 0xC0217E78)
> > -005|do_DataAbort(addr = 0, fsr = 5, regs = 0xC0217E78)
> > -006|__dabt_svc(asm)
> >  -->|exception
> > -007|kmem_cache_alloc(?, ?)
> > -008|send_signal(sig = 7, info = 0x1, t = 0xC02180C0, signals 
> > = 0xC0218338)
> > -009|specific_send_sig_info(sig = 7, info = 0x1, t = 0xC02180C0)
> > -010|force_sig_info(sig = 7, info = 0x1, t = 0xC02180C0)
> > -011|do_DataAbort(addr = 3624919056, fsr = 2056, regs = 0xC0217F64)
> > -012|__dabt_svc(asm)
> >  -->|exception
> > -013|omap24xx_init_irq()
> > -014|init_IRQ()
> > -015|start_kernel()
> > -016|__mmap_switched(asm)
> >  ---|end of frame
> >     |
> > 
> > I'm looking for some pointers as to where I should start 
> > searching for the
> > problem here. My guess is that's it's somewhere inside the 
> > Kernel page fault
> > handler but I don't know enough to get beyond that.
> > 
> > TIA,
> > 
> > Richard.
> > 
> > 
> > -----Original Message-----
> > From: Woodruff, Richard [mailto:r-woodruff2@ti.com] 
> > Sent: 29 September 2006 14:35
> > To: Richard Copeman; linux-omap-open-source@linux.omap.com
> > Subject: RE: H4 with 2.6.9 from TI dev site not booting
> > 
> > It is likely your u-boot or kernel might be mis-matched with 
> > respect to
> > the mach-type.
> > 
> > This is just a simple error hang loop.  If it can't figure 
> > out processor
> > variant or mach-type it jumps to a hang. It is likely either 
> > a mismatch
> > or memory corruption.
> > 
> > Regards,
> > Richard W.
> >  
> > 
> > > -----Original Message-----
> > > From: linux-omap-open-source-bounces@linux.omap.com 
> > > [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> > > Behalf Of Richard Copeman
> > > Sent: Friday, September 29, 2006 7:52 AM
> > > To: linux-omap-open-source@linux.omap.com
> > > Subject: H4 with 2.6.9 from TI dev site not booting
> > > 
> > > Hi,
> > > 
> > >  
> > > 
> > > I wonder if anyone has any experience with LINUX 2.6.9 built 
> > > with gcc 3.4.1
> > > for ARM running on TI OMAP2420 H4 board.
> > > 
> > >  
> > > 
> > > I download the kernel via JTAG to 0x80000000 and start it 
> > > running. It runs
> > > for 35 instructions and then ends up in a tight loop at 
> > > 0x80008118 which
> > > contains a nop followed by a branch to 0x80008118.
> > > 
> > >  
> > > 
> > > Can someone point me in the right direction please?
> > > 
> > >  
> > > 
> > > TIA,
> > > 
> > >  
> > > 
> > > Richard.
> > > 
> > > _______________________________________________
> > > Linux-omap-open-source mailing list
> > > Linux-omap-open-source@linux.omap.com
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > > 
> > 
> > 
> 
> 
