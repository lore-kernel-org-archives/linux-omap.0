From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: [RFC] snapshot boot on omap osk 5912
Date: Wed, 08 Mar 2006 21:49:46 +0900 (JST)
Message-ID: <20060308.214946.48536311.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

On target osk5912, software-suspend (suspend-to-disk) is now working,
and resume-from-disk takes about 10sec. This is on linux-2.6.11 + omap
patch + software-suspend arm porting.

My next try is to shrink resume-from-disk operation duration time.
My method is as below:

(in boot loader (u-boot) side, after bootloader starts target)
1) extract resumed image in disk (for osk, it's in flash) to memory
2) do necessary initialization
3) jump to kernel, not to entry point but to point just after image is
   allocated in kernel resume sequence.

I implemented these steps in bootloader command.

After program counter jumps to kernel, resume goes, restores regs to
that of suspended point, restores coprocessor regs, serial8250 gets
resumed (and printk emits char to console), osk lcd lights again, but
in omapfb resume procedure, wait_for_completion->schedule is called
and goes to cpu_idle<-->omap_pm_idle busy loop.

Obiously, I missed some initialization staff.
What I did in step 2) in bootloader is
2-1) modified timer to 192MHz for ARM, and enabled mpu, xor, tim
     clock.
2-2) enabled MMU
(for other device, I hoped resume sequence in kernel would handle...)

I'd like to have some advice on: things I need to initialize, good way
to do that (like use kernel func abit), and other pit falls I might
face.

Also, is anyone interested in fast bootup?
This could do significant shrink in bootup time when it works :-)

Thanks in advance.


HK.
--
