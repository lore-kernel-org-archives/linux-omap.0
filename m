From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot
 failure)
Date: Fri, 14 Jan 2011 12:18:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com>
References: <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com> <20110106203238.GH1198@n2100.arm.linux.org.uk> <20110106204053.GA7771@atomide.com> <20110107161230.GR1198@n2100.arm.linux.org.uk> <20110110185209.GC4957@atomide.com>
 <20110111231611.GX4957@atomide.com> <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com> <20110113091546.GA24429@n2100.arm.linux.org.uk> <20110113155152.GG4957@atomide.com> <20110113164957.GA28040@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36940 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933167Ab1ANTSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 14:18:52 -0500
In-Reply-To: <20110113164957.GA28040@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

On Thu, 13 Jan 2011, Russell King - ARM Linux wrote:

> On Thu, Jan 13, 2011 at 07:51:53AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110113 01:15]:
> > > Given the very sorry state of OMAP in mainline at present, I'm surprised
> > > that this kind of stuff is still going on...
> > 
> > At least I boot test the patches I send..
> 
> Which is why OMAP3 and OMAP4 can't be built in mainline because they
> spit out lots of compile errors in the OMAP code...  As they won't
> even compile they couldn't have been boot tested.

Current mainline != the patches that Tony sent to Linus[1].

The patches that Tony sent to Linus, which Linus merged, build fine
with omap2plus_defconfig[2].


- Paul


1. Lindgren, Tony.  _[GIT PULL] omap changes for v2.6.38_.
   Posted to the linux-kernel mailing list on 6 January 2011.
   http://www.gossamer-threads.com/lists/linux/kernel/1324357 (among 
   others)

2. Compilation log of the patches that Tony submitted for the 2.6.38 merge 
   window (included below)

---

$ git log mainline/master --pretty=oneline | fgrep omap-for-linus |head -1
01539ba2a706ab7d35fc0667dff919ade7f87d63 Merge branch 'omap-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
$ git show 01539ba2a706ab7d35fc0667dff919ade7f87d63 |head -5
commit 01539ba2a706ab7d35fc0667dff919ade7f87d63
Merge: 9e9bc97 dc69d1a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jan 6 19:13:58 2011 -0800
$ git checkout dc69d1a
HEAD is now at dc69d1a... omap2: Make OMAP2PLUS select OMAP_DM_TIMER
$ make mrproper
$ make omap2plus_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
$ make -j2
scripts/kconfig/conf --silentoldconfig Kconfig
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  HOSTCC  scripts/genksyms/genksyms.o
  Generating include/generated/mach-types.h
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/lex.o
  GEN     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  HOSTCC  scripts/genksyms/parse.o
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/genksyms/genksyms
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      init/main.o
  HOSTCC  usr/gen_init_cpio
  GEN     usr/initramfs_data.cpio
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/arm/nwfpe/fpa11.o
  CC      arch/arm/nwfpe/fpa11_cpdo.o
  CC      arch/arm/nwfpe/fpa11_cpdt.o
  CC      arch/arm/nwfpe/fpa11_cprt.o
  CC      arch/arm/nwfpe/fpmodule.o
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/do_mounts.o
  CC      arch/arm/nwfpe/fpopcode.o
  CC      arch/arm/nwfpe/softfloat.o
  CC      init/do_mounts_rd.o
  CC      arch/arm/nwfpe/single_cpdo.o
  CC      init/do_mounts_initrd.o
  CC      arch/arm/nwfpe/double_cpdo.o
  AS      arch/arm/nwfpe/entry.o
  LD      arch/arm/nwfpe/nwfpe.o
  LD      arch/arm/nwfpe/built-in.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  CC      init/version.o
  LD      init/mounts.o
  CC      arch/arm/vfp/vfpmodule.o
  LD      init/built-in.o
  CC      arch/arm/kernel/elf.o
  AS      arch/arm/vfp/entry.o
  AS      arch/arm/vfp/vfphw.o
  CC      arch/arm/vfp/vfpsingle.o
  AS      arch/arm/kernel/entry-armv.o
  AS      arch/arm/kernel/entry-common.o
  CC      arch/arm/kernel/irq.o
  CC      arch/arm/vfp/vfpdouble.o
  CC      arch/arm/kernel/process.o
  LD      arch/arm/vfp/vfp.o
  LD      arch/arm/vfp/built-in.o
  CC      arch/arm/mm/dma-mapping.o
  CC      arch/arm/kernel/ptrace.o
  CC      arch/arm/mm/extable.o
  CC      arch/arm/mm/fault.o
  CC      arch/arm/kernel/return_address.o
arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
  CC      arch/arm/kernel/setup.o
  CC      arch/arm/mm/init.o
  CC      arch/arm/mm/iomap.o
  CC      arch/arm/kernel/signal.o
  CC      arch/arm/mm/fault-armv.o
  CC      arch/arm/kernel/sys_arm.o
  CC      arch/arm/mm/flush.o
  CC      arch/arm/kernel/stacktrace.o
  CC      arch/arm/mm/ioremap.o
  CC      arch/arm/kernel/time.o
  CC      arch/arm/mm/mmap.o
  CC      arch/arm/kernel/traps.o
  CC      arch/arm/mm/pgd.o
  CC      arch/arm/mm/mmu.o
  CC      arch/arm/kernel/leds.o
  CC      arch/arm/kernel/armksyms.o
  CC      arch/arm/mm/vmregion.o
  CC      arch/arm/mm/proc-syms.o
  CC      arch/arm/kernel/module.o
  CC      arch/arm/mm/alignment.o
  CC      arch/arm/kernel/smp.o
  AS      arch/arm/mm/abort-ev6.o
  AS      arch/arm/mm/abort-ev7.o
  AS      arch/arm/mm/pabort-v6.o
  AS      arch/arm/mm/pabort-v7.o
  AS      arch/arm/mm/cache-v6.o
  AS      arch/arm/mm/cache-v7.o
  CC      arch/arm/mm/copypage-v6.o
  CC      arch/arm/mm/context.o
  CC      a2/powerdomains44xx_data.o
  CC      arch/arm/mach-omap2/clockdomain.o
  CC      arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.o
  CC      arch/arm/mach-omap2/clockdomains44xx_data.o
  CC      arch/arm/mach-omap2/clock.o
  CC      arch/arm/mach-omap2/clock_common_data.o
  CC      arch/arm/mach-omap2/clkt_dpll.o
  CC      kernel/exec_domain.o
  CC      arch/arm/mach-omap2/clkt_clksel.o
  CC      arch/arm/mach-omap2/clock2xxx.o
  CC      arch/arm/mach-omap2/clkt2xxx_sys.o
  CC      arch/arm/mach-omap2/clkt2xxx_dpllcore.o
  CC      kernel/panic.o
  CC      arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.o
  CC      arch/arm/mach-omap2/clkt2xxx_apll.o
  CC      arch/arm/mach-omap2/clkt2xxx_osc.o
  CC      kernel/printk.o
  CC      arch/arm/mach-omap2/clock2420_data.o
  CC      arch/arm/mach-omap2/clock2430.o
  CC      arch/arm/mach-omch/arm/mach-omap2/usb-musb.o
  CC      arch/arm/mach-omap2/usb-tusb6010.o
  CC      kernel/nsproxy.o
  CC      arch/arm/mach-omap2/usb-ehci.o
  CC      kernel/srcu.o
  CC      arch/arm/mach-omap2/gpmc-onenand.o
  CC      kernel/semaphore.o
  CC      arch/arm/mach-omap2/gpmc-nand.o
  CC      arch/arm/mach-omap2/gpmc-smc91x.o
  CC      kernel/notifier.o
  CC      arch/arm/mach-omap2/gpmc-smsc911x.o
  CC      kernel/ksysfs.o
  LD      arch/arm/mach-omap2/built-in.o
  CC      kernel/pm_qos_params.o
  CC      mm/bootmem.o
  CC      kernel/sched_clock.o
  CC      mm/filemap.o
  CC      kernel/cred.o
  CC      kernel/async.o
  CC      kernel/range.o
  CC      kernel/jump_label.o
  CC      mm/mempool.o
  CC      kernel/groups.o
  CC      mm/oom_kill.o
  CC      kernel/freezer.o
  CC      kernel/profile.o
  CC      mm/fadvise.o
  CC      mm/maccess.o
  CC      kernel/stacktrace.o
  CC      mm/page_alloc.o
  CC      kernel/irq/irqdesc.o
  CC      kernel/irq/handle.o
  CC      kernel/irq/manage.o
  CC      kernel/irq/spurious.o
  CC      kernel/irq/resend.o
  CC      mm/page-writeback.o
  CC      kernel/irq/chip.o
  CC      kernel/irq/dummychip.o
  CC      kernel/irq/devres.o
  CC      kernel/irq/autoprobe.o
  CC      mm/readahead.o
  CC      kernel/irq/proc.o
  CC      kernel/irq/pm.o
  LD      kernel/irq/built-in.o
  CC      kernel/power/main.o
  CC      mm/swap.o
  CC      kernel/power/console.o
  CC      kernel/power/process.o
  CC      mm/truncate.o
  CC      kernel/power/suspend.o
  CC      mm/vmscan.o
  CC      kernel/power/nvs.o
  CC      kernel/power/poweroff.o
  LD      kernel/power/built-in.o
  CC      kernel/time/timekeeping.o
  CC      kernel/time/ntp.o
  CC      kernel/time/clocksource.o
  CC      mm/shmem.o
  CC      kernel/time/jiffies.o
  CC      kernel/time/timer_list.o
  CC      kernel/time/timecompare.o
  CC      kernel/time/timeconv.o
  CC      kernel/time/clockevents.o
  CC      mm/prio_tree.o
  CC      mm/util.o
  CC      kernel/time/tick-common.o
  CC      kernel/time/tick-broadcast.o
  CC      mm/mmzone.o
  CC      kernel/time/tick-oneshot.o
  CC      mm/vmstat.o
  CC      kernel/time/tick-sched.o
  CC      kernel/time/timer_stats.o
  CC      mm/backing-dev.o
  LD      kernel/time/built-in.o
  CC      kernel/trace/trace_clock.o
  CC      kernel/trace/ring_buffer.o
  CC      mm/page_isolation.o
  CC      mm/mm_init.o
  CC      mm/mmu_context.o
  CC      mm/percpu.o
  CC      kernel/trace/trace.o
  CC      mm/fremap.o
  CC      mm/highmem.o
  CC      mm/madvise.o
  CC      mm/memory.o
  CC      kernel/trace/trace_output.o
  CC      kernel/trace/trace_stat.o
  CC      mm/mincore.o
  CC      kernel/trace/trace_printk.o
  CC      mm/mlock.o
  CC      kernel/trace/trace_sched_switch.o
  CC      mm/mmap.o
  CC      kernel/trace/trace_nop.o
  CC      kernel/trace/blktrace.o
  CC      mm/mprotect.o
  CC      kernel/trace/trace_events.o
  CC      mm/mremap.o
  CC      mm/msync.o
  CC      kernel/trace/trace_export.o
  CC      mm/rmap.o
  CC      kernel/trace/trace_event_perf.o
  CC      kernel/trace/trace_events_filter.o
  CC      mm/vmalloc.o
  CC      kernel/trace/trace_kprobe.o
  CC      mm/pagewalk.o
  CC      mm/init-mm.o
  CC      mm/memblock.o
  CC      kernel/trace/power-traces.o
  CC      mm/page_io.o
  CC      mm/swap_state.o
  LD      kernel/trace/built-in.o
  CC      kernel/mutex-debug.o
  CC      mm/swapfile.o
  CC      kernel/lockdep.o
  CC      mm/thrash.o
  CC      mm/dmapool.o
  CC      mm/slab.o
  CC      kernel/lockdep_proc.o
  CC      kernel/futex.o
  CC      kernel/rtmutex.o
  LD      mm/built-in.o
  CC      fs/open.o
  CC      kernel/smp.o
  CC      kernel/spinlock.o
  CC      kernel/uid16.o
  CC      fs/read_write.o
  CC      kernel/module.o
  CC      fs/file_table.o
  CC      fs/super.o
  CC      kernel/kallsyms.o
  CC      fs/char_dev.o
  CC      kernel/acct.o
  CC      fs/stat.o
  CC      kernel/kexec.o
  CC      fs/exec.o
  GZIP    kernel/config_data.gz
  CC      kernel/stop_machine.o
  CC      kernel/kprobes.o
  CC      fs/pipe.o
  CC      kernel/rcutree.o
  CC      fs/namei.o
  CC      kernel/utsname_sysctl.o
  CC      kernel/tracepoint.o
  CC      kernel/elfcore.o
  CC      kernel/sched_cpupri.o
  CC      kernel/irq_work.o
  CC      fs/fcntl.o
  CC      kernel/perf_event.o
  CC      fs/ioctl.o
  CC      fs/readdir.o
  CC      fs/select.o
  CC      fs/fifo.o
  CC      kernel/hw_breakpoint.o
  CC      fs/dcache.o
  CC      kernel/time.o
  IKCFG   kernel/config_data.h
  CC      kernel/configs.o
  CC      fs/inode.o
  LD      kernel/built-in.o
  CC      ipc/util.o
  CC      ipc/msgutil.o
  CC      fs/attr.o
  CC      ipc/msg.o
  CC      fs/bad_inode.o
  CC      ipc/sem.o
  CC      fs/file.o
  CC      fs/filesystems.o
  CC      ipc/shm.o
  CC      fs/namespace.o
  CC      ipc/ipcns_notifier.o
  CC      ipc/syscall.o
  CC      ipc/ipc_sysctl.o
  CC      ipc/mqueue.o
  CC      fs/seq_file.o
  CC      ipc/mq_sysctl.o
  CC      fs/xattr.o
  LD      ipc/built-in.o
  CC      fs/libfs.o
  CC      fs/fs-writeback.o
  CC      security/keys/gc.o
  CC      security/keys/key.o
  CC      security/keys/keyring.o
  CC      fs/pnode.o
  CC      fs/drop_caches.o
  CC      fs/splice.o
  CC      security/keys/keyctl.o
  CC      security/keys/permission.o
  CC      fs/sync.o
  CC      security/keys/process_keys.o
  CC      fs/utimes.o
  CC      security/keys/request_key.o
  CC      fs/stack.o
  CC      security/keys/request_key_auth.o
  CC      fs/fs_struct.o
  CC      security/keys/user_defined.o
  CC      fs/statfs.o
  rs/mtd/onenand/built-in.o
  LD      drivers/mtd/tests/built-in.o
  CC      drivers/mtd/ubi/vtbl.o
  CC      drivers/mtd/ubi/vmt.o
  CC      fs/ubifs/sb.o
  CC      drivers/mtd/ubi/upd.o
  CC      drivers/mtd/ubi/build.o
  CC      fs/ubifs/io.o
  CC      drivers/mtd/ubi/cdev.o
  CC      fs/ubifs/tnc.o
  CC      drivers/mtd/ubi/kapi.o
  CC      drivers/mtd/ubi/eba.o
  CC      fs/ubifs/master.o
  CC      fs/ubifs/scan.o
  CC      drivers/mtd/ubi/io.o
  CC      fs/ubifs/replay.o
  CC      drivers/mtd/ubi/wl.o
  CC      fs/ubifs/log.o
  CC      drivers/mtd/ubi/scan.o
  CC      fs/ubifs/commit.o
  CC      fs/ubifs/gc.o
  CC      drivers/mtd/ubi/misc.o
  LD      drivers/mtd/ubi/ubi.o
  LD      drivers/mtd/ubi/built-in.o
  LD      drivers/mtd/mtd.o
  LD      drivers/mtd/built-in.o
  CC      drivers/net/mii.o
  CC      fs/ubifs/orphan.o
  CC      fs/ubifs/budget.o
  LD      drivers/net/arm/built-in.o
  CC      drivers/net/phy/phy.o
  CC      fs/ubifs/find.o
  CC      drivers/net/phy/phy_device.o
  CC      fs/ubifs/tnc_commit.o
  CC      fs/ubifs/compress.o
  CC      drivers/net/phy/mdio_bus.o
  CC      fs/ubifs/lpt.o
  CC      drivers/net/phy/smsc.o
  LD      drivers/net/phy/libphy.o
  LD      drivers/net/phy/built-in.o
  CC      drivers/net/usb/asix.o
  CC      fs/ubifs/lprops.o
  CC      fs/ubifs/recovery.o
  CC      drivers/net/usb/cdc_ether.o
  CC      drivers/net/usb/net1080.o
  CC      fs/ubifs/ioctl.o
  CC      fs/ubifs/lpt_commit.o
  CC      drivers/net/usb/cdc_subset.o
  CC      drivers/net/usb/zaurus.o
  CC      fs/ubifs/tnc_misc.o
  CC      drivers/net/usb/usbnet.o
  LD      fs/ubifs/ubifs.o
  LD      fs/ubifs/built-in.o
  CC      fs/eventpoll.o
  CC      fs/anon_inodes.o
  LD      drivers/net/usb/built-in.o
  CC      fs/signalfd.o
  LD      drivers/net/wireless/built-in.o
  LD      drivers/net/wireless/libertas/built-in.o
  CC [M]  drivers/net/wireless/libertas/cfg.o
  CC      fs/timerfd.o
  CC      fs/eventfd.o
  CC [M]  drivers/net/wireless/libertas/cmd.o
  CC      fs/aio.o
  CC      fs/locks.o
  CC [M]  drivers/net/wireless/libertas/cmdresp.o
  CC [M]  drivers/net/wireless/libertas/debugfs.o
  CC      fs/binfmt_misc.o
  CC [M]  drivers/net/wireless/libertas/ethtool.o
  CC      fs/binfmt_script.o
  CC      fs/binfmt_elf.o
  CC [M]  drivers/net/wireless/libertas/main.o
  CC      fs/posix_acl.o
  CC [M]  drivers/net/wireless/libertas/rx.o
  CC      fs/xattr_acl.o
  CC      fs/dcookies.o
  CC [M]  drivers/net/wireless/libertas/tx.o
  LD      fs/built-in.o
  CC [M]  drivers/net/wireless/libertas/if_sdio.o
  LD      drivers/platform/built-in.o
  CC      drivers/power/power_supply_core.o
  CC      drivers/power/power_supply_sysfs.o
  LD      drivers/power/power_supply.o
  LD      drivers/power/built-in.o
  CC [M]  drivers/net/wireless/libertas/if_usb.o
  LD      sound/built-in.o
  CC [M]  sound/sound_core.o
  LD      sound/arm/built-in.o
  LD      sound/atmel/built-in.o
  LD      sound/core/oss/built-in.o
  CC [M]  sound/core/oss/mixer_oss.o
  LD [M]  drivers/net/wireless/libertas/libertas.o
  LD [M]  drivers/net/wireless/libertas/usb8xxx.o
  LD [M]  drivers/net/wireless/libertas/libertas_sdio.o
  CC      drivers/net/ks8851.o
  CC [M]  sound/core/oss/pcm_oss.o
  CC      drivers/net/ks8851_mll.o
  CC      drivers/net/Space.o
  CC      drivers/net/loopback.o
  CC [M]  sound/core/oss/pcm_plugin.o
  CC      drivers/net/smc91x.o
  CC [M]  sound/core/oss/io.o
  CC [M]  sound/core/oss/copy.o
  CC [M]  sound/core/oss/linear.o
  CC      drivers/net/smsc911x.o
  CC [M]  sound/core/oss/mulaw.o
  CC [M]  sound/core/oss/route.o
  CC [M]  sound/core/oss/rate.o
  LD [M]  sound/core/oss/snd-mixer-oss.o
  LD [M]  sound/core/oss/snd-pcm-oss.o
  CC [M]  sound/core/hwdep.o
  LD      drivers/net/built-in.o
  CC      drivers/regulator/core.o
  CC [M]  sound/core/memalloc.o
  CC [M]  sound/core/pcm.o
  CC      drivers/regulator/dummy.o
  CC      drivers/regulator/fixed.o
  CC [M]  sound/core/pcm_native.o
  CC      drivers/regulator/twl-regulator.o
  CC      drivers/regulator/tps65023-regulator.o
  CC      drivers/regulator/tps6507x-regulator.ooc/blackfin/built-in.o
  LD      sound/soc/codecs/built-in.o
  CC [M]  sound/soc/codecs/twl4030.o
  LD [M]  sound/soc/codecs/snd-soc-twl4030.o
  LD      sound/soc/davinci/built-in.o
  LD      sound/soc/ep93xx/built-in.o
  LD      sound/soc/fsl/built-in.o
  LD      sound/soc/imx/built-in.o
  LD      sound/soc/jz4740/built-in.o
  LD      sound/soc/kirkwood/built-in.o
  LD      sound/soc/nuc900/built-in.o
  LD      sound/soc/omap/built-in.o
  CC [M]  sound/soc/omap/omap-mcbsp.o
  CC      drivers/serial/8250_early.o
  CC      drivers/serial/omap-serial.o
  CC [M]  sound/soc/omap/omap-pcm.o
  CC [M]  sound/soc/omap/omap3pandora.o
  LD      drivers/serial/built-in.o
  CC      drivers/spi/spi.o
  CC      drivers/spi/omap2_mcspi.o
  LD [M]  sound/soc/omap/snd-soc-omap.o
  LD [M]  sound/soc/omap/snd-soc-omap-mcbsp.o
  LD [M]  sound/soc/omap/snd-soc-omap3pandora.o
  LD      sound/soc/pxa/built-in.o
  LD      sound/soc/s3c24xx/built-in.o
  LD      sound/soc/s6000/built-in.o
  LD      sound/soc/sh/built-in.o
  LD      sound/soc/txx9/built-in.o
  LD [M]  sound/soc/snd-soc-core.o
  LD      sound/sparc/built-in.o
  LD      sound/spi/built-in.o
  LD      sound/synth/built-in.o
  LD      sound/usb/built-in.o
  CC [M]  sound/usb/card.o
  LD    drivers/video/logo/logo_superh_vga16.c
  LOGO    drivers/video/logo/logo_blackfin_clut224.c
  LOGO    drivers/video/logo/logo_dec_clut224.c
  LOGO    drivers/video/logo/logo_m32r_clut224.c
  LOGO    drivers/video/logo/logo_mac_clut224.c
  LOGO    drivers/video/logo/logo_parisc_clut224.c
  LOGO    drivers/video/logo/logo_sgi_clut224.c
  LOGO    drivers/video/logo/logo_spe_clut224.c
  LOGO    drivers/video/logo/logo_sun_clut224.c
  LOGO    drivers/video/logo/logo_superh_clut224.c
  CC      drivers/video/logo/logo_linux_mono.o
  CC      drivers/video/logo/logo_linux_vga16.o
  CC      drivers/video/logo/logo_linux_cock.o
  CC      net/ipv4/ip_input.o
  CC      lib/bitrev.o
  CC      lib/crc-ccitt.o
  CC      net/ipv4/ip_fragment.o
  CC      lib/crc16.o
  CC      lib/crc-t10dif.o
  CC      lib/crc-itu-t.o
  HOSTCC  lib/gen_crc32table
  CC      lib/crc7.o
  CC      net/ipv4/ip_forward.o
  CC      lib/libcrc32c.o
  CC      lib/lzo/lzo1x_compress.o
  CC      lib/lzo/lzo1x_decompress.o
  CC      net/ipv4/ip_options.o
  LD      lib/lzo/lzo_compress.o
  LD      lib/lzo/lzo_decompress.o
  LD      lib/lzo/built-in.o
  CC      lib/zlib_deflate/deflate.o
  CC      lib/zlib_deflate/deftree.o
  CC      net/ipv4/ip_output.o
  CC      lib/zlib_deflate/deflate_syms.o
  LD      lib/zlib_deflate/zlib_deflate.o
  LD      lib/zlib_deflate/built-in.o
  CC      lib/zlib_inflate/inffast.o
  CC      lib/zlib_inflate/inflate.o
  CC      lib/zlib_inflate/infutil.o
  CC      lib/zlib_inflate/inftrees.o
  CC      lib/zlib_inflate/inflate_syms.o
  LD      lib/zlib_inflate/zlib_inflate.o
  LD      lib/zlib_inflate/built-in.o
  CC      lib/percpu_counter.o
  CC      net/ipv4/ip_sockglue.o
  CC      lib/nlattr.o
  CC      lib/atomic64.o
  CC      lib/argv_split.o
  CC      net/ipv4/inet_hashtables.o
  CC      lib/cmdline.o
  CC      lib/cpumask.o
  CC      lib/ctype.o
  CC      lib/dec_and_lock.o
  CC      lib/decompress.o
  CC      lib/decompress_inflate.o
  CC      net/ipv4/inet_timewait_sock.o
  CC      lib/dump_stack.o
  CC      lib/extable.o
  CC      lib/flex_array.o
  CC      lib/idr.o
  CC      net/ipv4/inet_connection_sock.o
  CC      lib/int_sqrt.o
  CC      lib/ioremap.o
  CC      lib/irq_regs.o
  CC      lib/is_single_threaded.o
  CC      net/ipv4/tcp.o
  CC      lib/klist.o
  CC      lib/kobject.o
  CC      lib/kobject_uevent.o
  CC      lib/kref.o
  CC      net/ipv4/tcp_input.o
  CC      lib/plist.o
  CC      lib/prio_heap.o
  CC      lib/prio_tree.o
  CC      lib/proportions.o
  CC      lib/radix-tree.o
  CC      lib/ratelimit.o
  CC      lib/rbtree.o
  CC      lib/reciprocal_div.o
  CC      lib/rwsem-spinlock.o
  CC      lib/sha1.o
  CC      lib/show_mem.o
  CC      lib/string.o
  CC      net/ipv4/tcp_output.o
  CC      lib/vsprintf.o
  GEN     lib/crc32table.h
  AR      lib/lib.a
  CC      lib/crc32.o
  CC      net/ipv4/tcp_timer.o
  LD      lib/built-in.o
  CC      net/ipv4/tcp_ipv4.o
  CC      net/ipv4/tcp_minisocks.o
  CC      net/ipv4/tcp_cong.o
  CC      net/ipv4/datagram.o
  CC      net/key/af_key.o
  CC      net/ipv4/raw.o
  CC      net/ipv4/udp.o
  LD      net/key/built-in.o
  CC      net/ipv4/udplite.o
  CC      net/ipv4/arp.o
  CC      net/ipv4/icmp.o
  CC      net/ipv4/devinet.o
  CC      net/ipv4/af_inet.o
  LD      net/mac80211/built-in.o
  CC [M]  net/mac80211/main.o
  CC      net/ipv4/igmp.o
  CC [M]  net/mac80211/status.o
  CC [M]  net/mac80211/sta_info.o
  CC [M]  net/mac80211/wep.o
  CC      net/ipv4/fib_frontend.o
  CC [M]  net/mac80211/wpa.o
  CC [M]  net/mac80211/scan.o
  CC      net/ipv4/fib_semantics.o
  CC      net/ipv4/inet_fragment.o
  CC [M]  net/mac80211/offchannel.o
  CC      net/ipv4/sysctl_net_ipv4.o
  CC [M]  net/mac80211/ht.o
  CC      net/ipv4/fib_hash.o
  CC [M]  net/mac80211/agg-tx.o
  CC      net/ipv4/proc.o
  CC      net/ipv4/xfrm4_mode_beet.o
  CC [M]  net/mac80211/agg-rx.o
  CC      net/ipv4/xfrm4_mode_transport.o
  CC [M]  net/mac80211/ibss.o
  CC      net/ipv4/xfrm4_mode_tunnel.o
  CC [M]  net/mac80211/mlme.o
  CC      net/ipv4/ipconfig.o
  CC [M]  net/mac80211/work.o
  CC      net/ipv4/netfilter.o
  CC [M]  net/mac80211/iface.o
  LD      net/ipv4/netfilter/built-in.o
  CC      net/ipv4/inet_diag.o
  CC [M]  net/mac80211/rate.o
  CC      net/ipv4/tcp_diag.o
  CC      net/ipv4/tcp_cubic.o
  CC [M]  net/mac80211/michael.o
  CC [M]  net/mac80211/tkip.o
  CC      net/ipv4/xfrm4_policy.o
  CC [M]  net/mac80211/aes_ccm.o
  CC      net/ipv4/xfrm4_state.o
  CC [M]  net/mac80211/aes_cmac.o
  CC      net/ipv4/xfrm4_input.o
  CC [M]  net/mac80211/cfg.o
  CC      net/ipv4/xfrm4_output.o
  CC [M]  net/mac80211/rx.o
  LD      net/ipv4/built-in.o
  CC [M]  net/mac80211/spectmgmt.o
  CC [M]  net/mac80211/tx.o
  CC      net/netfilter/core.o
  CC      net/netfilter/nf_log.o
  CC [M]  net/mac80211/key.o
  CC      net/netfilter/nf_queue.o
  CC [M]  net/mac80211/util.o
  CC      net/netfilter/nf_sockopt.o
  CC [M]  net/mac80211/wme.o
  LD      net/netfilter/netfilter.o
  LD      net/netfilter/built-in.o
  CC [M]  net/mac80211/event.o
  CC [M]  net/mac80211/chan.o
  CC [M]  net/mac80211/pm.o
  CC [M]  net/mac80211/rc80211_pid_algo.o
  CC [M]  net/mac80211/rc80211_minstrel.o
  CC [M]  net/mac80211/rc80211_minstrel_ht.o
  CC      net/netlink/af_netlink.o
  LD [M]  net/mac80211/mac80211.o
  CC      net/packet/af_packet.o
  CC      net/netlink/genetlink.o
  LD      net/packet/built-in.o
  CC      net/sched/sch_generic.o
  CC      net/sched/sch_mq.o
  LD      net/netlink/built-in.o
  CC      net/sunrpc/clnt.o
  LD      net/sched/built-in.o
  CC      net/unix/af_unix.o
  CC      net/sunrpc/xprt.o
  CC      net/unix/garbage.o
  CC      net/unix/sysctl_net_unix.o
  CC      net/sunrpc/socklib.o
  LD      net/unix/unix.o
  LD      net/unix/built-in.o
  CC      net/sunrpc/xprtsock.o
  CC      net/sunrpc/sched.o
  CC      net/sunrpc/auth.o
  CC      net/sunrpc/auth_null.o
  CC      net/sunrpc/auth_unix.o
  CC      net/wireless/wext-core.o
  CC      net/sunrpc/auth_generic.o
  CC      net/wireless/wext-proc.o
  CC      net/sunrpc/svc.o
  CC      net/wireless/wext-spy.o
  CC [M]  net/wireless/core.o
  CC      net/sunrpc/svcsock.o
  CC [M]  net/wireless/sysfs.o
  CC [M]  net/wireless/radiotap.o
  CC      net/sunrpc/svcauth.o
  CC [M]  net/wireless/util.o
  CC      net/sunrpc/svcauth_unix.o
  CC [M]  net/wireless/reg.o
  CC      net/sunrpc/addr.o
  CC      net/sunrpc/rpcb_clnt.o
  CC [M]  net/wireless/scan.o
  CC      net/sunrpc/timer.o
  CC [M]  net/wireless/nl80211.o
  CC      net/sunrpc/xdr.o
  CC      net/sunrpc/sunrpc_syms.o
  CC      net/sunrpc/cache.o
  CC      net/sunrpc/rpc_pipe.o
  CC [M]  net/wireless/mlme.o
  CC      net/sunrpc/svc_xprt.o
  CC [M]  net/wireless/ibss.o
  CC [M]  net/wireless/sme.o
  CC      net/sunrpc/stats.o
  CC [M]  net/wireless/chan.o
  CC      net/sunrpc/sysctl.o
  CC [M]  net/wireless/ethtool.o
  CC      net/sunrpc/auth_gss/auth_gss.o
  CC [M]  net/wireless/wext-compat.o
  CC      net/sunrpc/auth_gss/gss_generic_token.o
  CC [M]  net/wireless/wext-sme.o
  CC      net/sunrpc/auth_gss/gss_mech_switch.o
  CC [M]  net/wireless/lib80211.o
  CC      net/sunrpc/auth_gss/svcauth_gss.o
  LD      net/wireless/built-in.o
  LD [M]  net/wireless/cfg80211.o
  CC      net/xfrm/xfrm_policy.o
  CC      net/sunrpc/auth_gss/gss_krb5_mech.o
  CC      net/sunrpc/auth_gss/gss_krb5_seal.o
  CC      net/sunrpc/auth_gss/gss_krb5_unseal.o
  CC      net/sunrpc/auth_gss/gss_krb5_seqnum.o
  CC      net/xfrm/xfrm_state.o
  CC      net/sunrpc/auth_gss/gss_krb5_wrap.o
  CC      net/sunrpc/auth_gss/gss_krb5_crypto.o
  CC      net/sunrpc/auth_gss/gss_krb5_keys.o
  CC      net/xfrm/xfrm_hash.o
  LD      net/sunrpc/auth_gss/auth_rpcgss.o
  LD      net/sunrpc/auth_gss/rpcsec_gss_krb5.o
  LD      net/sunrpc/auth_gss/built-in.o
  LD      net/sunrpc/sunrpc.o
  LD      net/sunrpc/built-in.o
  CC      net/sysctl_net.o
  CC      net/xfrm/xfrm_input.o
  CC      net/xfrm/xfrm_output.o
  CC      net/xfrm/xfrm_algo.o
  CC      net/xfrm/xfrm_sysctl.o
  CC      net/xfrm/xfrm_user.o
  LD      net/xfrm/built-in.o
  LD      net/built-in.o
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      .tmp_vmlinux3
  KSYM    .tmp_kallsyms3.S
  AS      .tmp_kallsyms3.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready
  AS      arch/arm/boot/compressed/head.o
  Building modules, stage 2.
  GZIP    arch/arm/boot/compressed/piggy.gzip
  MODPOST 36 modules
  CC      crypto/aes_generic.mod.o
  CC      crypto/arc4.mod.o
  CC      crypto/ecb.mod.o
  CC      drivers/bluetooth/bcm203x.mod.o
  CC      drivers/bluetooth/bpa10x.mod.o
  CC      drivers/bluetooth/hci_uart.mod.o
  CC      drivers/net/wireless/libertas/libertas.mod.o
  CC      drivers/net/wireless/libertas/libertas_sdio.mod.o
  CC      drivers/net/wireless/libertas/usb8xxx.mod.o
  CC      drivers/scsi/scsi_wait_scan.mod.o
  CC      drivers/usb/gadget/g_zero.mod.o
  CC      net/bluetooth/bluetooth.mod.o
  CC      net/bluetooth/bnep/bnep.mod.o
  CC      net/bluetooth/hidp/hidp.mod.o
  CC      arch/arm/boot/compressed/misc.o
  CC      net/bluetooth/l2cap.mod.o
  CC      net/bluetooth/rfcomm/rfcomm.mod.o
  CC      net/bluetooth/sco.mod.o
  CC      arch/arm/boot/compressed/decompress.o
  CC      net/mac80211/mac80211.mod.o
  CC      net/wireless/cfg80211.mod.o
  CC      net/wireless/lib80211.mod.o
  CC      sound/core/oss/snd-mixer-oss.mod.o
  CC      sound/core/oss/snd-pcm-oss.mod.o
  CC      sound/core/snd-hwdep.mod.o
  SHIPPED arch/arm/boot/compressed/lib1funcs.S
  AS      arch/arm/boot/compressed/piggy.gzip.o
  AS      arch/arm/boot/compressed/lib1funcs.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
  CC      sound/core/snd-page-alloc.mod.o
  CC      sound/core/snd-pcm.mod.o
  CC      sound/core/snd-rawmidi.mod.o
  CC      sound/core/snd-timer.mod.o
  CC      sound/core/snd.mod.o
  CC      sound/soc/codecs/snd-soc-twl4030.mod.o
  CC      sound/soc/omap/snd-soc-omap-mcbsp.mod.o
  CC      sound/soc/omap/snd-soc-omap.mod.o
  CC      sound/soc/omap/snd-soc-omap3pandora.mod.o
  CC      sound/soc/snd-soc-core.mod.o
  CC      sound/soundcore.mod.o
  CC      sound/usb/snd-usb-audio.mod.o
  CC      sound/usb/snd-usbmidi-lib.mod.o
  LD [M]  crypto/aes_generic.ko
  LD [M]  crypto/arc4.ko
  LD [M]  crypto/ecb.ko
  LD [M]  drivers/bluetooth/bcm203x.ko
  LD [M]  drivers/bluetooth/bpa10x.ko
  LD [M]  drivers/bluetooth/hci_uart.ko
  LD [M]  drivers/net/wireless/libertas/libertas.ko
  LD [M]  drivers/net/wireless/libertas/libertas_sdio.ko
  LD [M]  drivers/net/wireless/libertas/usb8xxx.ko
  LD [M]  drivers/scsi/scsi_wait_scan.ko
  LD [M]  drivers/usb/gadget/g_zero.ko
  LD [M]  net/bluetooth/bluetooth.ko
  LD [M]  net/bluetooth/bnep/bnep.ko
  LD [M]  net/bluetooth/hidp/hidp.ko
  LD [M]  net/bluetooth/l2cap.ko
  LD [M]  net/bluetooth/rfcomm/rfcomm.ko
  LD [M]  net/bluetooth/sco.ko
  LD [M]  net/mac80211/mac80211.ko
  LD [M]  net/wireless/cfg80211.ko
  LD [M]  net/wireless/lib80211.ko
  LD [M]  sound/core/oss/snd-mixer-oss.ko
  LD [M]  sound/core/oss/snd-pcm-oss.ko
  LD [M]  sound/core/snd-hwdep.ko
  LD [M]  sound/core/snd-page-alloc.ko
  LD [M]  sound/core/snd-pcm.ko
  LD [M]  sound/core/snd-rawmidi.ko
  LD [M]  sound/core/snd-timer.ko
  LD [M]  sound/core/snd.ko
  LD [M]  sound/soc/codecs/snd-soc-twl4030.ko
  LD [M]  sound/soc/omap/snd-soc-omap-mcbsp.ko
  LD [M]  sound/soc/omap/snd-soc-omap.ko
  LD [M]  sound/soc/omap/snd-soc-omap3pandora.ko
  LD [M]  sound/soc/snd-soc-core.ko
  LD [M]  sound/soundcore.ko
  LD [M]  sound/usb/snd-usb-audio.ko
  LD [M]  sound/usb/snd-usbmidi-lib.ko
$ 













