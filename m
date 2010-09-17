From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: [Query] Garbled characters on gtkterm
Date: Fri, 17 Sep 2010 23:14:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032953A021@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33194 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab0IQRo3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 13:44:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8HHiQO5009955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 12:44:28 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8HHiP8i025734
	for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 23:14:25 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
While trying to boot kernel image on N800 I am seeing
lot of garbled characters along with the trace in gtkterm.

I have configured the terminal as follows:
Port: ttyS0
Speed: 115200
Parity: none
Bits:8
Stopbits: 1
=46low control: none
End of delay(ms): 0

Can someone help me if I am missing anything in my configuration?

-tarun

[LOG SNIPPET]

<<Garbled characters>>
=2E..
  DeteNOLO X-Loader (v1.1.16, Oct 31 2008)
Secondary image size 99036
Booting secondary
Nokia OMAP Loader v1.1.16 (Oct 31 2008) running on Nokia N800 F5 (RX-34=
)
Clocks:
  Core:   658 MHz  L3:     109 MHz  L4:     109 MHz
  MPU:    329 MHz  DSP:    219 MHz  IVA:    109 MHz
I2C v3.4
Menelaus v2.2 found
Vilma v1.5 found
Betty v2.1 found
Reset reason: pwr_key
System DMA v2.0
OneNAND blocks unlocked in 30264 us
  Flash id: ec4811
Partition table successfully read
McSPI v1.4
RFBI version 1.0
  Detecting LCD panel lph8923
    Panel ID: 838f48
    URAL panel detected
  Detected LCD paneH: lc041q3
  S1D1374! HaAlstOrm @eteCted
=46B memory blanking took 242 ms (3089 kB/s)
  Logo drawn in 24 ms (1218 kB/s)
  =DCber-cool backlight fade-in took 101 ms
Initializing USB
  USB host detected
  Entering USB loop
SETUP: RD STD DEVICE    GET_DESCRIPTOR     DEVICE (value 00, index 0000=
, length 64 bytes)
SETUP: WR STD DEVICE    SET_ADDRESS        value 0033 index 0000 length=
 0000
SETUP: RD STD DEVICE    GET_DESCRIPTOR     DEVICE (value 00, index 0000=
, length 18 bytes)
SETUP: RD STD DEVICE    GET_DESCRIPTOR     CONFIGURATION (value 00, ind=
ex 0000, length 9 bytes)
SETUP: RD STD DEVICE    GET_DESCRIPTOR     CONFIGURATION (value 00, ind=
ex 0000, length 94 bytes)
=2E..
<<Garbled characters>>
=2E..
Loading kernel image info... done.
Loading kernel (1427 kB)... done in 73 ms (19527 kB/s)
Total bootup time 2734 ms
Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.36-rc4-00040-g4c1f85c-dirty (x0016154@=
omaplbp) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #7 Fri Sep=
 17 15:57:29 IST 2010

[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (A=
RMv6TEJ), cr=3D00c5387f

[    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction=
 cache

[    0.000000] Machine: Nokia N800

[    0.000000] Ignoring unrecognised tag 0x414f4d50

[    0.000000] bootconsole [earlycon0] enabled

[    0.000000] Memory policy: ECC disabled, Data cache writeback
=2E...
<<Garbled characters>>
=2E...
[    0.000000] pid_max: default: 32768 minimum: 301

[    0.000000] Mount-cache hash table entries: 512

[    0.000000] CPU: Testing write buffer coherency: ok

[    0.000000] regulator: core version 0.5=20
=2E..
<<Garbled characters>>
=2E..
[    1.204437] mmc0: new SD card at address 1234
[    1.210021] mmcblk0: mmc0:1234 SA01G 972 MiB=20
[    1.217468]  mmcblk0: p1
[    1.241241] VFS: Cannot open root device "mmcblk0p2" or unknown-bloc=
k(179,2)
[    1.248352] Please append a correct "root=3D" boot option; here are =
the availAble partitions:

<<Garbled characters>>




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
