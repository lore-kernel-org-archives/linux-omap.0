From: Brian Swetland <swetland@google.com>
Subject: Re: boot issues on omap730/p2
Date: Mon, 21 Nov 2005 15:19:31 -0800
Message-ID: <20051121231931.GA18276@localhost.localdomain>
References: <20051121221036.GA18825@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051121221036.GA18825@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


As I continue to hunt this down, I discover that the kernel can
translate /dev/mtdblock3 to 31:3 using /sys/block/... (provided
the mtdblock driver exists).  Tracing through severel layers
of *_mount() stuff, I discover that in do_kern_mount(), the
call to type->get_sb() is returning ENOENT.

Just mentioning this here in case there's a "doh! you should do x!"
response before I proceed to dig yet deeper into the bowels of
the kernel root filesystem mounting fun...

Brian

[Brian Swetland <swetland@google.com>]
> 
> I'm running into problems with the recent kernels trying to get the
> system to boot on my p2 board.  Sadly, devfs is no more, and I'm trying
> to get the kernel to still consider mounting my romfs boot filesystem
> in flash, yet:
> 
> VFS: No root yet, retrying to mount root on 31:3 (unknown-block(31,3))
> VFS: Cannot open root device "31:3" or unknown-block(31,3)
> Please append a correct "root=" boot option
> 
> I used to be able to specify root=/dev/mtdblock/3 and everything was
> well.  Now I'm reduced to root=31:3 but that does not bring happiness.
> 
> Creating 4 MTD partitions on "omapflash.0":
> 0x00000000-0x00020000 : "bootloader"
> mtd: Giving out device 0 to bootloader
> 0x00020000-0x00040000 : "params"
> mtd: Giving out device 1 to params
> 0x00040000-0x00240000 : "kernel"
> mtd: Giving out device 2 to kernel
> 0x00240000-0x02000000 : "rootfs"
> mtd: Giving out device 3 to rootfs
> 
> The romfs filesystem is definitely there at 0x240000 and a much earlier
> kernel happily boots it.
