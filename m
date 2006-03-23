From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [RFC] snapshot boot on omap osk 5912
Date: Thu, 23 Mar 2006 17:34:34 +0900 (JST)
Message-ID: <20060323.173434.70222708.kaminaga@sm.sony.co.jp>
References: <20060308.214946.48536311.kaminaga@sm.sony.co.jp>
	<20060320.113406.78713993.kaminaga@sm.sony.co.jp>
	<20060320.154502.74754326.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060320.154502.74754326.kaminaga@sm.sony.co.jp>
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

Hi,

> > > What I did in step 2) in bootloader is
> > > 2-1) modified timer to 192MHz for ARM, and enabled mpu, xor, tim clock.
> > > 2-2) enabled MMU
> > > (for other device, I hoped resume sequence in kernel would handle...)
> > 
> > I answer myself, Mask Interrupt Register was not setup right, and
> > it blocked all interrupts. After I unmasked MIR, it got further.
> > 
> > But next problem was that network is not up.
> 
> I answer myself again :)
> It was because gpio1 irqenable register was not properly set.

Then comes nor flash... I got this message:

mtdblock: erase of region [0x0, 0x20000] on "filesystem" failed
end_request: I/O error, dev mtdblock3, sector 256


Can anybody tell me the init steps I have to take?
(from the *very* beginning, like turn on clock, register settings, ...)

The usual message I get during normal kernel boot is:

omap_nor_cs3: Found 1 x16 devices at 0x0 in 16-bit bank
omap_nor_cs3: Found 1 x16 devices at 0x1000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omap_nor_cs3":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"


Thanks in advance.

(Hiroki Kaminaga)
t
--
