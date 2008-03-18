From: David Brownell <david-b@pacbell.net>
Subject: JFFS2 issues on OSK?
Date: Mon, 17 Mar 2008 23:26:25 -0800
Message-ID: <200803180026.25802.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:37594 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751938AbYCRH0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2008 03:26:31 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is strange.  When I try to mount /dev/mtdblock3 as the
root FS I get a variety of errors (minimally "point returned
len too short: 0") ... which do *not* appear later when I just
issue a "mount -t jffs2 /dev/mtdblock3 /mnt"!!

System is an OMAP 5912 OSK board:  arm926ej-s, with a pair of
16 MB Micron NOR flash chips concatenated to act like one
bigger chip.  The relevant parts of the boot log follow.

This particular kernel didn't include JFFS2 summary support,
but similar problems happen with summary enabled.  It was the
same kernel which _wrote_ the filesystem, starting with an
"mtd_debug erase /dev/mtd3 ..." and then mounting it before
writing the files (only about 8 MBytes).

Does anyone know what may be going on here?  This is with
u-Boot 1.3.2 from GIT, and a 2.6.25-rc6 kernel.  (This one
happens to be from the OMAP tree, so cpufreq works, but the
same thing happens with kernel.org code.)

Details below ...

- Dave



omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x20000,blocks=128
erase region 1: offset=0x1000000,size=0x20000,blocks=128
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
MUX: initialized W11_1610_CF_CD1
MUX: initialized P11_1610_CF_CD2
MUX: initialized R11_1610_CF_IOIS16
MUX: initialized V10_1610_CF_IREQ
MUX: initialized W10_1610_CF_RESET
omap_cf: cs2 on irq 222
omap_rtc omap_rtc: rtc core: registered omap_rtc as rtc0
omap_rtc: already running
OMAP Watchdog Timer Rev 0x10: initial timeout 60 sec
Registered led device: d9
Registered led device: d2
Registered led device: d3
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
omap_rtc omap_rtc: setting system clock to 2008-03-17 22:41:27 UTC (1205793687)
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 96K
JFFS2 warning: (180) check_node_data: MTD point returned len too short: 0 instead of 976.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 627.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 18.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 343.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 905.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2902.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2557.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 14.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 398.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 975.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2275.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2661.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2525.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2625.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2833.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2875.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2653.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2282.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2542.
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 1740.
scsi0 : pata_pcmcia
ata1: PATA max PIO0 cmd 0xc2852000 ctl 0xc285200e irq 222
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 19.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 1083.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 1604.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 1767.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2257.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 1836.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2184.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 1787.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2531.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2630.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2655.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2538.
JFFS2 warning: (1) check_node_data: MTD point returned len too short: 0 instead of 2659.
ata1.00: CFA: SAMSUNG CF/ATA, Rev 1.15, max PIO2
ata1.00: 251904 sectors, multi 0: LBA 
ata1.00: configured for PIO0
ata1.00: configured for PIO0
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG CF/ATA   Rev  PQ: 0 ANSI: 5
JFFS2 warning: (180) check_node_data: MTD point returned len too short: 0 instead of 2.


OABI Buildroot Linux 2.6.25-rc6-omap1, cpu armv5tejl

osk login: root
Password: 
Mar 17 15:41:35 login[194]: root login on 'ttyS0'

	When I did this without the CF card inserted, there were
	not as many "len too short" errors ... but they were stil
	present.

	The (brand new) buildroot image doesn't work too well
	either ... not clear yet just why.  Notice that none of
	the /etc/init.d/S* scripts ran, for example; no shell
	seems to work.

