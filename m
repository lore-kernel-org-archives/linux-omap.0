From: tony@atomide.com
Subject: Re: OMAP emulation
Date: Wed, 22 Mar 2006 07:17:06 -0800
Message-ID: <20060322151704.GB5748@atomide.com>
References: <fb249edb0603170933m391da937w@mail.gmail.com>
	<20060320141948.GB4980@atomide.com>
	<fb249edb0603220157p710b6091t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0603220157p710b6091t@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060322 01:57]:
> On 20/03/06, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Sounds like you have already verified the memory timings. Does it work
> > properly with caches disabled?
> Unfortunately nope, for me at least. Except the slowdown, it changes
> the places where the bug appears (i.e. where the programs break) but
> it is because when I disable the caches in the config, it enables two
> new instructions in head.S. Now, if I replace these two instructions
> with any random instructions the result is the same.

Hmmm. And your root file system obviously is not corrupted and works
fine on other omaps?
 
> The QEMU effort is not wasted I think :)  My new idea is to simulate
> the Linux booting from the reset of the device, when it loads PalmOS
> (which is the OS that comes with the device in a ROM) through the
> Linux bootloader which then gradually unloads PalmOS and only then
> jumps to the kernel. This will maybe allow me to find out what
> registers is PalmOS messing with and reset those in the bootloader to
> their default values because there is plenty of registers that Linux
> doesn't touch when it's booting ( -- for example yesterday we found
> out that on Zire 71 (a different PDA based on OMAP 310) the mpu
> watchdog timer is always enabled in PalmOS and that was (correctly)
> triggering mysterious resets of the device everytime Linux took over
> the control -- until yesterday).

Yeah, it's really nice to have an omap emulator :)

Tony
