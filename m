From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Tue, 27 Oct 2015 11:37:03 +0200
Message-ID: <562F45BF.8020205@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <20151026212346.GJ13239@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151026212346.GJ13239@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Brian,

On 26/10/15 23:23, Brian Norris wrote:
> Hi Roger,
> 
> I'm not too familiar with OMAP platforms, and I might have missed out on
> prior discussions/context, so please forgive if I'm asking silly or old
> questions here.

No worries at all.

> 
> On Fri, Sep 18, 2015 at 05:53:22PM +0300, Roger Quadros wrote:
>> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
>> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
>> This causes performance increase when using prefetch-irq mode.
>> 30% increase in read, 17% increase in write in prefetch-irq mode.
> 
> Have you pinpointed the exact causes for the performance increase, or
> can you give an educated guess? AIUI, you're reducing the number of
> interrupts needed for NAND prefetch mode, but you're also removing a bit
> of abstraction and implementing hooks that look awfully like the
> existing abstractions:
> 
> +       int (*nand_irq_enable)(enum gpmc_nand_irq irq);
> +       int (*nand_irq_disable)(enum gpmc_nand_irq irq);
> +       void (*nand_irq_clear)(enum gpmc_nand_irq irq);
> +       u32 (*nand_irq_status)(void);
> 
> That's not really a problem if there's a good reason for them (brcmnand
> implements similar hooks because of quirks in the implementation of
> interrupts across various BRCM SoCs, and it's not worth writing irqchip
> drivers for those cases). I'm mainly curious for an explanation.

I have both implementations with me. My guess is that the 20% performance
gain is due to absence of irqchip/irqdomain translation code.
I haven't investigated further though.

Another concern I have is that I'm not using any locking around
gpmc_nand_irq_enable/disable(). Could this pose problems in multiple NAND
use cases? My understanding is that it should not as the controller access
is serialized between multiple NAND chips.

However I do need to add some locking as the GPMC_IRQENABLE register is shared
between NAND and GPMC driver.

NOTE: We are not using prefetch-irq mode for any of the OMAP boards because
of lesser performance than prefetch-polled mode. So if the less performance
for an unused mode is a lesser concern compared to cleaner code then
I can resend this with the irqdomain implementation.

Below are performance logs of irqdomain vs hooks.

--
cheers,
-roger

test logs.

for-v4.4/gpmc-v2 - irqdomain with prefetch-irq. No ready pin.
================

[   67.696631] 
[   67.698201] =================================================
[   67.704254] mtd_speedtest: MTD device: 8
[   67.708373] mtd_speedtest: MTD device size 8388608, eraseblock size 131072, page size 2048, count of eraseblocks 64, pages per eraseblock 64, OOB size 64
[   67.723701] mtd_test: scanning for bad eraseblocks
[   67.735468] mtd_test: scanned 64 eraseblocks, 0 are bad
[   67.772861] mtd_speedtest: testing eraseblock write speed
[   70.372903] mtd_speedtest: eraseblock write speed is 3156 KiB/s
[   70.379104] mtd_speedtest: testing eraseblock read speed
[   72.594169] mtd_speedtest: eraseblock read speed is 3708 KiB/s
[   72.656375] mtd_speedtest: testing page write speed
[   75.213646] mtd_speedtest: page write speed is 3208 KiB/s
[   75.219311] mtd_speedtest: testing page read speed
[   77.343639] mtd_speedtest: page read speed is 3865 KiB/s
[   77.405236] mtd_speedtest: testing 2 page write speed
[   80.039702] mtd_speedtest: 2 page write speed is 3114 KiB/s
[   80.045561] mtd_speedtest: testing 2 page read speed
[   82.175098] mtd_speedtest: 2 page read speed is 3856 KiB/s
[   82.180849] mtd_speedtest: Testing erase speed
[   82.241548] mtd_speedtest: erase speed is 146285 KiB/s
[   82.246920] mtd_speedtest: Testing 2x multi-block erase speed
[   82.284789] mtd_speedtest: 2x multi-block erase speed is 264258 KiB/s
[   82.291551] mtd_speedtest: Testing 4x multi-block erase speed
[   82.329358] mtd_speedtest: 4x multi-block erase speed is 264258 KiB/s
[   82.336116] mtd_speedtest: Testing 8x multi-block erase speed
[   82.373903] mtd_speedtest: 8x multi-block erase speed is 264258 KiB/s
[   82.380648] mtd_speedtest: Testing 16x multi-block erase speed
[   82.418503] mtd_speedtest: 16x multi-block erase speed is 264258 KiB/s
[   82.425356] mtd_speedtest: Testing 32x multi-block erase speed
[   82.463227] mtd_speedtest: 32x multi-block erase speed is 264258 KiB/s
[   82.470066] mtd_speedtest: Testing 64x multi-block erase speed
[   82.507908] mtd_speedtest: 64x multi-block erase speed is 264258 KiB/s
[   82.514758] mtd_speedtest: finished
[   82.518417] =================================================

root@rockdesk:~# cat /proc/interrupts 
           CPU0       CPU1       
324:     798720          0      CBAR  15 Level     gpmc
397:     798720          0      gpmc   0 Edge      gpmc-nand-fifo
398:      24576          0      gpmc   1 Edge      gpmc-nand-count


root@rockdesk:~# ./nandthroughput.sh 
Test file blobs/50M.bin found
mounting NAND partition 9
== attaching ubi to mtd9
[  133.102184] ubi0: attaching mtd9
[  133.801162] ubi0: scanning is finished
[  133.818853] ubi0: attached mtd9 (name "NAND.file-system", size 246 MiB)
[  133.825805] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
[  133.833036] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
[  133.840065] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
[  133.847198] ubi0: good PEBs: 1968, bad PEBs: 0, corrupted PEBs: 0
[  133.853598] ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
[  133.861178] ubi0: max/mean erase counter: 2/1, WL threshold: 4096, image sequence number: 673614122
[  133.870682] ubi0: available PEBs: 0, total reserved PEBs: 1968, PEBs reserved for bad PEB handling: 40
[  133.880817] ubi0: background thread "ubi_bgt0d" started, PID 2304
UBI device number 0, total 1968 LEBs (253919232 bytes, 242.2 MiB), available 0 LEBs (0 bytes), LEB size 129024 bytes (126.0 KiB)
== mounting volume
[  133.921377] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 2306
[  133.987100] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "rootfs"
[  133.994882] UBIFS (ubi0:0): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[  134.005314] UBIFS (ubi0:0): FS size: 246564864 bytes (235 MiB, 1911 LEBs), journal size 12386304 bytes (11 MiB, 96 LEBs)
[  134.016737] UBIFS (ubi0:0): reserved for root: 4952683 bytes (4836 KiB)
[  134.023691] UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID CE1A60B9-55D7-42D8-BC23-13997CF7F130, small LPT model
write test
[  134.159501] nandthroughput. (2301): drop_caches: 3
5+0 records in
5+0 records out
52428800 bytes (52 MB) copied, 12.0334 s, 4.4 MB/s
read test
[  146.782569] nandthroughput. (2301): drop_caches: 3
5+0 records in
5+0 records out
52428800 bytes (52 MB) copied, 7.61057 s, 6.9 MB/s
b34b1f703d54d577fe78564226d5a6d6 /tmp/nandtest
b34b1f703d54d577fe78564226d5a6d6  /tmp/nandtestread
== unmounting volume
[  155.122917] UBIFS (ubi0:0): un-mount UBI device 0
[  155.128142] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" stops
== detaching ubi
[  155.175075] ubi0: detaching mtd9
[  155.184543] ubi0: mtd9 is detached
done


for-v4.4/gpmc-v4-prefetch-irq-noready - prefetch-irq with no irqdomain, no ready pin.
=====================================

[   28.472795] 
[   28.474361] =================================================
[   28.480376] mtd_speedtest: MTD device: 8
[   28.484546] mtd_speedtest: MTD device size 8388608, eraseblock size 131072, page size 2048, count of eraseblocks 64, pages per eraseblock 64, OOB size 64
[   28.499856] mtd_test: scanning for bad eraseblocks
[   28.512001] mtd_test: scanned 64 eraseblocks, 0 are bad
[   28.549375] mtd_speedtest: testing eraseblock write speed
[   30.886014] mtd_speedtest: eraseblock write speed is 3515 KiB/s
[   30.892246] mtd_speedtest: testing eraseblock read speed
[   32.727323] mtd_speedtest: eraseblock read speed is 4476 KiB/s
[   32.789452] mtd_speedtest: testing page write speed
[   35.124514] mtd_speedtest: page write speed is 3515 KiB/s
[   35.130181] mtd_speedtest: testing page read speed
[   37.006367] mtd_speedtest: page read speed is 4378 KiB/s
[   37.067976] mtd_speedtest: testing 2 page write speed
[   39.386324] mtd_speedtest: 2 page write speed is 3541 KiB/s
[   39.392191] mtd_speedtest: testing 2 page read speed
[   41.289049] mtd_speedtest: 2 page read speed is 4329 KiB/s
[   41.294820] mtd_speedtest: Testing erase speed
[   41.355468] mtd_speedtest: erase speed is 148945 KiB/s
[   41.360856] mtd_speedtest: Testing 2x multi-block erase speed
[   41.398737] mtd_speedtest: 2x multi-block erase speed is 264258 KiB/s
[   41.405506] mtd_speedtest: Testing 4x multi-block erase speed
[   41.443567] mtd_speedtest: 4x multi-block erase speed is 256000 KiB/s
[   41.450319] mtd_speedtest: Testing 8x multi-block erase speed
[   41.488075] mtd_speedtest: 8x multi-block erase speed is 264258 KiB/s
[   41.494843] mtd_speedtest: Testing 16x multi-block erase speed
[   41.532670] mtd_speedtest: 16x multi-block erase speed is 264258 KiB/s
[   41.539512] mtd_speedtest: Testing 32x multi-block erase speed
[   41.577328] mtd_speedtest: 32x multi-block erase speed is 264258 KiB/s
[   41.584183] mtd_speedtest: Testing 64x multi-block erase speed
[   41.621973] mtd_speedtest: 64x multi-block erase speed is 264258 KiB/s
[   41.628817] mtd_speedtest: finished
[   41.632486] =================================================
root@rockdesk:~# 
root@rockdesk:~# cat /proc/interrupts 
           CPU0       CPU1       
324:     798737          0      CBAR  15 Level     omap-gpmc, omap2-nand


./nandthroughput.sh 
Test file blobs/50M.bin found
mounting NAND partition 9
== attaching ubi to mtd9
[  371.605283] ubi0: attaching mtd9
[  372.661433] ubi0: scanning is finished
[  372.682827] ubi0: attached mtd9 (name "NAND.file-system", size 246 MiB)
[  372.689759] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
[  372.696989] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
[  372.704021] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
[  372.711136] ubi0: good PEBs: 1968, bad PEBs: 0, corrupted PEBs: 0
[  372.717530] ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
[  372.725104] ubi0: max/mean erase counter: 2/1, WL threshold: 4096, image sequence number: 673614122
[  372.734594] ubi0: available PEBs: 0, total reserved PEBs: 1968, PEBs reserved for bad PEB handling: 40
[  372.744779] ubi0: background thread "ubi_bgt0d" started, PID 2320
UBI device number 0, total 1968 LEBs (253919232 bytes, 242.2 MiB), available 0 LEBs (0 bytes), LEB size 129024 bytes (126.0 KiB)
== mounting volume
[  372.786473] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 2322
[  372.835870] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "rootfs"
[  372.843648] UBIFS (ubi0:0): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[  372.854082] UBIFS (ubi0:0): FS size: 246564864 bytes (235 MiB, 1911 LEBs), journal size 12386304 bytes (11 MiB, 96 LEBs)
[  372.865505] UBIFS (ubi0:0): reserved for root: 4952683 bytes (4836 KiB)
[  372.872467] UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID CE1A60B9-55D7-42D8-BC23-13997CF7F130, small LPT model
write test
[  373.019723] nandthroughput. (2317): drop_caches: 3
5+0 records in
5+0 records out
52428800 bytes (52 MB) copied, 10.8034 s, 4.9 MB/s
read test
[  384.393642] nandthroughput. (2317): drop_caches: 3
5+0 records in
5+0 records out
52428800 bytes (52 MB) copied, 6.30402 s, 8.3 MB/s
b34b1f703d54d577fe78564226d5a6d6 /tmp/nandtest
b34b1f703d54d577fe78564226d5a6d6  /tmp/nandtestread
== unmounting volume
[  391.420866] UBIFS (ubi0:0): un-mount UBI device 0
[  391.426108] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" stops
== detaching ubi
[  391.456007] ubi0: detaching mtd9
[  391.464569] ubi0: mtd9 is detached
done
