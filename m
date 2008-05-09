From: "arun c" <arunedarath@mistralsolutions.com>
Subject: 2430SDP booting problem with the latest git
Date: Fri, 9 May 2008 18:43:40 +0530
Message-ID: <c656a4d20805090613l1ecf4201m4385bb4ee75e9d90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4337_10288806.1210338820117"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.152]:35958 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757969AbYEINNk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 09:13:40 -0400
Received: by po-out-1718.google.com with SMTP id y22so556507pof.1
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2008 06:13:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_4337_10288806.1210338820117
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

While booting the 2430sdp with the latest git kernel nothing is
coming on lcd, omapfb driver fails to initialize the lcd due
to twl4030 accessing errors.

I have tested the hardware with the 2.6.14 kernel from ti
site, its working fine.

boot log is pasted below below(also attached).

##################################################################

Uncompressing Linux.............................................................Linux
version 2.6.26-rc1-omap1-04724-gcb170dc (arunc@atlas) (gcc version
4.2.0 8CPU: ARMv6-compatible processor [4107b365] revision 5
(ARMv6TEJ), cr=00c5387f
Machine: OMAP2430 sdp2430 board
Memory policy: ECC disabled, Data cache writeback
OMAP2430<6>ES0<6>
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: mem=64M console=ttyS0,115200n8 noinitrd
root=/dev/nfs rw npClocking rate (Crystal/DPLL/MPU): 13.0/532/266 MHz
clock.c: Enable for gpmc_fck without enable code
GPMC revision 3.0
IRQ: Found an INTC at 0xd80fe000 (revision 3.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP243x GPIO hardware version 2.4
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 61580KB available (2872K code, 285K data, 124K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 192 bytes
NET: Registered protocol family 16
NAND: Found NAND on CS 0
OMAP DMA hardware revision 4.0
Initializing OMAP McBSP system
omap_dsp_init() done
USB: No board-specific platform config found
i2c_omap i2c_omap.1: bus 1 rev3.7 at 400 kHz
i2c_omap i2c_omap.2: bus 2 rev3.7 at 2600 kHz
TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]
Unable to register interrupt subsystem[-121][728]
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
msgmni has been set to 120 for ipc namespace c030c208
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel sdp2430
omapfb: DISPC version 3.0 initialized
omap_rng omap_rng: OMAP Random Number Generator ver. 50
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
brd: module loaded
loop: module loaded
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c4850300 IRQ 309 [nowait]
eth0: Ethernet addr: 00:80:10:01:02:03
i2c /dev entries driver
TWL4030 GPIO Demux: IRQ Range 384 to 402, Initialization Failed
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
OMAP2 OneNAND driver initializing
input: omap_twl4030keypad as /class/input/input0
omap_twl4030keypad omap_twl4030keypad: Could not write TWL4030: 0 -
ret -121[ff]OMAP Watchdog Timer Rev 0x22: initial timeout 60 sec
mmci-omap: probe of mmci-omap.1 failed with error -22
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for OMAP2 initializing
PRCM revision 1.0
eth0: link up
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.13.153
IP-Config: Complete:
     device=eth0, addr=192.168.13.153, mask=255.255.255.0, gw=192.168.13.188,
     host=192.168.13.153, domain=, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=192.168.10.135, rootpath=
Looking up port of RPC 100003/2 on 192.168.10.135
###########################################

Regards,
Arun C

------=_Part_4337_10288806.1210338820117
Content-Type: application/octet-stream; name=bootlog
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fg0q7zhs0
Content-Disposition: attachment; filename=bootlog

VW5jb21wcmVzc2luZyBMaW51eC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi5MaW51eCB2ZXJzaW9uIDIuNi4yNi1yYzEtb21hcDEtMDQ3
MjQtZ2NiMTcwZGMgKGFydW5jQGF0bGFzKSAoZ2NjIHZlcnNpb24gNC4yLjAgOENQVTogQVJNdjYt
Y29tcGF0aWJsZSBwcm9jZXNzb3IgWzQxMDdiMzY1XSByZXZpc2lvbiA1IChBUk12NlRFSiksIGNy
PTAwYzUzODdmCk1hY2hpbmU6IE9NQVAyNDMwIHNkcDI0MzAgYm9hcmQKTWVtb3J5IHBvbGljeTog
RUNDIGRpc2FibGVkLCBEYXRhIGNhY2hlIHdyaXRlYmFjawpPTUFQMjQzMDw2PkVTMDw2PgpTUkFN
OiBNYXBwZWQgcGEgMHg0MDIwMDAwMCB0byB2YSAweGQ3MDAwMDAwIHNpemU6IDB4MTAwMDAwCkNQ
VTA6IEQgVklQVCB3cml0ZS1iYWNrIGNhY2hlCkNQVTA6IEkgY2FjaGU6IDMyNzY4IGJ5dGVzLCBh
c3NvY2lhdGl2aXR5IDQsIDMyIGJ5dGUgbGluZXMsIDI1NiBzZXRzCkNQVTA6IEQgY2FjaGU6IDMy
NzY4IGJ5dGVzLCBhc3NvY2lhdGl2aXR5IDQsIDMyIGJ5dGUgbGluZXMsIDI1NiBzZXRzCkJ1aWx0
IDEgem9uZWxpc3RzIGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwg
cGFnZXM6IDE2MjU2Cktlcm5lbCBjb21tYW5kIGxpbmU6IG1lbT02NE0gY29uc29sZT10dHlTMCwx
MTUyMDBuOCBub2luaXRyZCByb290PS9kZXYvbmZzIHJ3IG5wQ2xvY2tpbmcgcmF0ZSAoQ3J5c3Rh
bC9EUExML01QVSk6IDEzLjAvNTMyLzI2NiBNSHoKY2xvY2suYzogRW5hYmxlIGZvciBncG1jX2Zj
ayB3aXRob3V0IGVuYWJsZSBjb2RlCkdQTUMgcmV2aXNpb24gMy4wCklSUTogRm91bmQgYW4gSU5U
QyBhdCAweGQ4MGZlMDAwIChyZXZpc2lvbiAzLjApIHdpdGggOTYgaW50ZXJydXB0cwpUb3RhbCBv
ZiA5NiBpbnRlcnJ1cHRzIG9uIDEgYWN0aXZlIGNvbnRyb2xsZXIKT01BUDI0M3ggR1BJTyBoYXJk
d2FyZSB2ZXJzaW9uIDIuNApQSUQgaGFzaCB0YWJsZSBlbnRyaWVzOiAyNTYgKG9yZGVyOiA4LCAx
MDI0IGJ5dGVzKQpDb25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDMwCkRlbnRyeSBjYWNo
ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9yZGVyOiAzLCAzMjc2OCBieXRlcykKSW5vZGUt
Y2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogMiwgMTYzODQgYnl0ZXMpCk1l
bW9yeTogNjRNQiA9IDY0TUIgdG90YWwKTWVtb3J5OiA2MTU4MEtCIGF2YWlsYWJsZSAoMjg3Mksg
Y29kZSwgMjg1SyBkYXRhLCAxMjRLIGluaXQpCk1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmll
czogNTEyCkNQVTogVGVzdGluZyB3cml0ZSBidWZmZXIgY29oZXJlbmN5OiBvawpuZXRfbmFtZXNw
YWNlOiAxOTIgYnl0ZXMKTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgpOQU5EOiBG
b3VuZCBOQU5EIG9uIENTIDAKT01BUCBETUEgaGFyZHdhcmUgcmV2aXNpb24gNC4wCkluaXRpYWxp
emluZyBPTUFQIE1jQlNQIHN5c3RlbQpvbWFwX2RzcF9pbml0KCkgZG9uZQpVU0I6IE5vIGJvYXJk
LXNwZWNpZmljIHBsYXRmb3JtIGNvbmZpZyBmb3VuZAppMmNfb21hcCBpMmNfb21hcC4xOiBidXMg
MSByZXYzLjcgYXQgNDAwIGtIegppMmNfb21hcCBpMmNfb21hcC4yOiBidXMgMiByZXYzLjcgYXQg
MjYwMCBrSHoKVFdMNDAzMDogVFJZIGF0dGFjaCBTbGF2ZSBUV0w0MDMwLUlEMCBvbiBBZGFwdGVy
IE9NQVAgSTJDIGFkYXB0ZXIgWzFdClRXTDQwMzA6IFRSWSBhdHRhY2ggU2xhdmUgVFdMNDAzMC1J
RDEgb24gQWRhcHRlciBPTUFQIEkyQyBhZGFwdGVyIFsxXQpUV0w0MDMwOiBUUlkgYXR0YWNoIFNs
YXZlIFRXTDQwMzAtSUQyIG9uIEFkYXB0ZXIgT01BUCBJMkMgYWRhcHRlciBbMV0KVFdMNDAzMDog
VFJZIGF0dGFjaCBTbGF2ZSBUV0w0MDMwLUlEMyBvbiBBZGFwdGVyIE9NQVAgSTJDIGFkYXB0ZXIg
WzFdClVuYWJsZSB0byByZWdpc3RlciBpbnRlcnJ1cHQgc3Vic3lzdGVtWy0xMjFdWzcyOF0KTkVU
OiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyCklQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUg
ZW50cmllczogMTAyNCAob3JkZXI6IDAsIDQwOTYgYnl0ZXMpClRDUCBlc3RhYmxpc2hlZCBoYXNo
IHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAyLCAxNjM4NCBieXRlcykKVENQIGJpbmQgaGFz
aCB0YWJsZSBlbnRyaWVzOiAyMDQ4IChvcmRlcjogMSwgODE5MiBieXRlcykKVENQOiBIYXNoIHRh
YmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCAyMDQ4IGJpbmQgMjA0OCkKVENQIHJlbm8gcmVn
aXN0ZXJlZApORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEKTmV0V2luZGVyIEZsb2F0
aW5nIFBvaW50IEVtdWxhdG9yIFYwLjk3IChkb3VibGUgcHJlY2lzaW9uKQpWRlM6IERpc2sgcXVv
dGFzIGRxdW90XzYuNS4xCkRxdW90LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3Jk
ZXIgMCwgNDA5NiBieXRlcykKSkZGUzIgdmVyc2lvbiAyLjIuIChOQU5EKSAuLiAyMDAxLTIwMDYg
UmVkIEhhdCwgSW5jLgptc2dtbmkgaGFzIGJlZW4gc2V0IHRvIDEyMCBmb3IgaXBjIG5hbWVzcGFj
ZSBjMDMwYzIwOAppbyBzY2hlZHVsZXIgbm9vcCByZWdpc3RlcmVkCmlvIHNjaGVkdWxlciBhbnRp
Y2lwYXRvcnkgcmVnaXN0ZXJlZCAoZGVmYXVsdCkKaW8gc2NoZWR1bGVyIGRlYWRsaW5lIHJlZ2lz
dGVyZWQKaW8gc2NoZWR1bGVyIGNmcSByZWdpc3RlcmVkCm9tYXBmYjogY29uZmlndXJlZCBmb3Ig
cGFuZWwgc2RwMjQzMApvbWFwZmI6IERJU1BDIHZlcnNpb24gMy4wIGluaXRpYWxpemVkCm9tYXBf
cm5nIG9tYXBfcm5nOiBPTUFQIFJhbmRvbSBOdW1iZXIgR2VuZXJhdG9yIHZlci4gNTAKU2VyaWFs
OiA4MjUwLzE2NTUwIGRyaXZlciAkUmV2aXNpb246IDEuOTAgJCA0IHBvcnRzLCBJUlEgc2hhcmlu
ZyBlbmFibGVkCnNlcmlhbDgyNTAuMDogdHR5UzAgYXQgTU1JTyAweDQ4MDZhMDAwIChpcnEgPSA3
MikgaXMgYSBTVDE2NjU0CmNvbnNvbGUgW3R0eVMwXSBlbmFibGVkCnNlcmlhbDgyNTAuMDogdHR5
UzEgYXQgTU1JTyAweDQ4MDZjMDAwIChpcnEgPSA3MykgaXMgYSBTVDE2NjU0CnNlcmlhbDgyNTAu
MDogdHR5UzIgYXQgTU1JTyAweDQ4MDZlMDAwIChpcnEgPSA3NCkgaXMgYSBTVDE2NjU0CmJyZDog
bW9kdWxlIGxvYWRlZApsb29wOiBtb2R1bGUgbG9hZGVkCnNtYzkxeC5jOiB2MS4xLCBzZXAgMjIg
MjAwNCBieSBOaWNvbGFzIFBpdHJlIDxuaWNvQGNhbS5vcmc+CmV0aDA6IFNNQzkxQzk0IChyZXYg
OSkgYXQgYzQ4NTAzMDAgSVJRIDMwOSBbbm93YWl0XQpldGgwOiBFdGhlcm5ldCBhZGRyOiAwMDo4
MDoxMDowMTowMjowMwppMmMgL2RldiBlbnRyaWVzIGRyaXZlcgpUV0w0MDMwIEdQSU8gRGVtdXg6
IElSUSBSYW5nZSAzODQgdG8gNDAyLCBJbml0aWFsaXphdGlvbiBGYWlsZWQKb21hcGZsYXNoLjA6
IEZvdW5kIDEgeDE2IGRldmljZXMgYXQgMHgwIGluIDE2LWJpdCBiYW5rCm9tYXBmbGFzaC4wOiBG
b3VuZCAxIHgxNiBkZXZpY2VzIGF0IDB4MjAwMDAwMCBpbiAxNi1iaXQgYmFuawogSW50ZWwvU2hh
cnAgRXh0ZW5kZWQgUXVlcnkgVGFibGUgYXQgMHgwMTBBCiBJbnRlbC9TaGFycCBFeHRlbmRlZCBR
dWVyeSBUYWJsZSBhdCAweDAxMEEKIEludGVsL1NoYXJwIEV4dGVuZGVkIFF1ZXJ5IFRhYmxlIGF0
IDB4MDEwQQogSW50ZWwvU2hhcnAgRXh0ZW5kZWQgUXVlcnkgVGFibGUgYXQgMHgwMTBBCiBJbnRl
bC9TaGFycCBFeHRlbmRlZCBRdWVyeSBUYWJsZSBhdCAweDAxMEEKIEludGVsL1NoYXJwIEV4dGVu
ZGVkIFF1ZXJ5IFRhYmxlIGF0IDB4MDEwQQpVc2luZyBidWZmZXIgd3JpdGUgbWV0aG9kClVzaW5n
IGF1dG8tdW5sb2NrIG9uIHBvd2VyLXVwL3Jlc3VtZQpjZmlfY21kc2V0XzAwMDE6IEVyYXNlIHN1
c3BlbmQgb24gd3JpdGUgZW5hYmxlZApPTUFQMiBPbmVOQU5EIGRyaXZlciBpbml0aWFsaXppbmcK
aW5wdXQ6IG9tYXBfdHdsNDAzMGtleXBhZCBhcyAvY2xhc3MvaW5wdXQvaW5wdXQwCm9tYXBfdHds
NDAzMGtleXBhZCBvbWFwX3R3bDQwMzBrZXlwYWQ6IENvdWxkIG5vdCB3cml0ZSBUV0w0MDMwOiAw
IC0gcmV0IC0xMjFbZmZdT01BUCBXYXRjaGRvZyBUaW1lciBSZXYgMHgyMjogaW5pdGlhbCB0aW1l
b3V0IDYwIHNlYwptbWNpLW9tYXA6IHByb2JlIG9mIG1tY2ktb21hcC4xIGZhaWxlZCB3aXRoIGVy
cm9yIC0yMgpUQ1AgY3ViaWMgcmVnaXN0ZXJlZApORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFt
aWx5IDE3Ck5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTUKUlBDOiBSZWdpc3RlcmVk
IHVkcCB0cmFuc3BvcnQgbW9kdWxlLgpSUEM6IFJlZ2lzdGVyZWQgdGNwIHRyYW5zcG9ydCBtb2R1
bGUuClBvd2VyIE1hbmFnZW1lbnQgZm9yIE9NQVAyIGluaXRpYWxpemluZwpQUkNNIHJldmlzaW9u
IDEuMApldGgwOiBsaW5rIHVwClNlbmRpbmcgREhDUCByZXF1ZXN0cyAuLCBPSwpJUC1Db25maWc6
IEdvdCBESENQIGFuc3dlciBmcm9tIDAuMC4wLjAsIG15IGFkZHJlc3MgaXMgMTkyLjE2OC4xMy4x
NTMKSVAtQ29uZmlnOiBDb21wbGV0ZToKICAgICBkZXZpY2U9ZXRoMCwgYWRkcj0xOTIuMTY4LjEz
LjE1MywgbWFzaz0yNTUuMjU1LjI1NS4wLCBndz0xOTIuMTY4LjEzLjE4OCwKICAgICBob3N0PTE5
Mi4xNjguMTMuMTUzLCBkb21haW49LCBuaXMtZG9tYWluPShub25lKSwKICAgICBib290c2VydmVy
PTAuMC4wLjAsIHJvb3RzZXJ2ZXI9MTkyLjE2OC4xMC4xMzUsIHJvb3RwYXRoPQpMb29raW5nIHVw
IHBvcnQgb2YgUlBDIDEwMDAwMy8yIG9uIDE5Mi4xNjguMTAuMTM1Cg==
------=_Part_4337_10288806.1210338820117--
