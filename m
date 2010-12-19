From: Charles Manning <manningc2@actrix.gen.nz>
Subject: UBIFS not mounting on linux-omap 2.6.36
Date: Mon, 20 Dec 2010 11:18:01 +1300
Message-ID: <201012201118.01766.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:53112 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757238Ab0LSWSF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Dec 2010 17:18:05 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Hi All

I am trying to nail down an omap3 ubifs  performance regression, but cannot 
get Steve Sakoman's 2.6.35 or 2.6.36 kernels
http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux-omap-2.6.git
 to mount ubifs although the same procedure works with older kernels and works 
with the linux-omap 2.6.37 master.

Any hints?

Thanks

Charles


The NAND had been initilised with:

ubiformat /dev/mtd4 -s 512

ubimkvol /dev/ubi0 -m -N foo

Herewith log

root@omap3-multi:~# ubiattach /dev/ubi_ctrl -m4 -d4
UBI: attaching mtd4 to ubi4
UBI: physical eraseblock size:   131072 bytes (128 KiB)
UBI: logical eraseblock size:    129024 bytes
UBI: smallest flash I/O unit:    2048
UBI: sub-page size:              512
UBI: VID header offset:          512 (aligned 512)
UBI: data offset:                2048
UBI: max. sequence number:       2
UBI: attached mtd4 to ubi4
UBI: MTD device name:            "rootfs"
UBI: MTD device size:            249 MiB
UBI: number of good PEBs:        1996
UBI: number of bad PEBs:         0
UBI: max. allowed volumes:       128
UBI: wear-leveling threshold:    4096
UBI: number of internal volumes: 1
UBI: number of user volumes:     1
UBI: available PEBs:             0
UBI: total number of reserved PEBs: 1996
UBI: number of PEBs reserved for bad PEB handling: 19
UBI: max/mean erase counter: 8195/11
UBI: image sequence number:  1842873171
UBI: background thread "ubi_bgt4d" started, PID 407
UBI device number 4, total 1996 LEBs (257531904 bytes, 245.6 MiB), available 0 
LEBs (0 bytes), LEB size 129024 bytes (126.0 KiB)
root@omap3-multi:~# dmesg
...
UBI: attaching mtd4 to ubi4
UBI: physical eraseblock size:   131072 bytes (128 KiB)
UBI: logical eraseblock size:    129024 bytes
UBI: smallest flash I/O unit:    2048
UBI: sub-page size:              512
UBI: VID header offset:          512 (aligned 512)
UBI: data offset:                2048
UBI: max. sequence number:       2
UBI: attached mtd4 to ubi4
UBI: MTD device name:            "rootfs"
UBI: MTD device size:            249 MiB
UBI: number of good PEBs:        1996
UBI: number of bad PEBs:         0
UBI: max. allowed volumes:       128
UBI: wear-leveling threshold:    4096
UBI: number of internal volumes: 1
UBI: number of user volumes:     1
UBI: available PEBs:             0
UBI: total number of reserved PEBs: 1996
UBI: number of PEBs reserved for bad PEB handling: 19
UBI: max/mean erase counter: 8195/11
UBI: image sequence number:  1842873171
UBI: background thread "ubi_bgt4d" started, PID 407

root@omap3-multi:~# ubinfo -a              
UBI version:                    1
Count of UBI devices:           1
UBI control device major/minor: 10:62
Present UBI devices:            ubi4

ubi4
Volumes count:                           1
Logical eraseblock size:                 129024 bytes, 126.0 KiB
Total amount of logical eraseblocks:     1996 (257531904 bytes, 245.6 MiB)
Amount of available logical eraseblocks: 0 (0 bytes)
Maximum count of volumes                 128
Count of bad physical eraseblocks:       0
Count of reserved physical eraseblocks:  19
Current maximum erase counter value:     8195
Minimum input/output unit size:          2048 bytes
Character device major/minor:            250:0
Present volumes:                         0

Volume ID:   0 (on ubi4)
Type:        dynamic
Alignment:   1
Size:        1973 LEBs (254564352 bytes, 242.8 MiB)
State:       OK
Name:        foo
Character device major/minor: 250:1
root@omap3-multi:~# mount -t ubifs ubi4:foo ss/
mount: ubi4:foo already mounted or ss/ busy
root@omap3-multi:~# dmesg
...
UBIFS DBG (pid 429): ubifs_get_sb: name ubi4:foo, flags 0x0
UBIFS DBG (pid 429): ubifs_get_sb: opened ubi4_0
...

