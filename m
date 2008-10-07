From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: DVB-T problems with MUSB
Date: Tue, 7 Oct 2008 21:03:42 +0200
Message-ID: <70E3439A-A4CE-442B-928A-EEBAB253F279@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-285886871"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:7314 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbYJGTEK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Oct 2008 15:04:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-285886871
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

Ajays latest patches make MUSB behave a lot better on beagleboard, but  
my DVB stick still errors when beginning to stream data (scanning  
frequencies works):

pgd = ced6c000
[00000000] *pgd=8e2b7031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in: mt2060 dvb_usb_dib0700 dib7000p ipv6 dib7000m  
dvb_usb dvb_core dib3000mc dibx000_common dib0070
CPU: 0    Not tainted  (2.6.27-rc7-omap1 #1)
PC is at dma_cache_maint+0x40/0xa4
LR is at usb_hcd_submit_urb+0x164/0x870
pc : [<c00386cc>]    lr : [<c01eae34>]    psr: 20000013
sp : cee5dca0  ip : cee5dcb0  fp : cee5dcac
r10: ce02fca8  r9 : 00000020  r8 : 00000000
r7 : 00000000  r6 : cf953800  r5 : ce02fca0  r4 : ffc47000
r3 : 00000000  r2 : 00000002  r1 : ffc50a38  r0 : ffc47000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 8ed6c018  DAC: 00000015
Process w_scan (pid: 1824, stack limit = 0xcee5c2e8)
Stack: (0xcee5dca0 to 0xcee5e000)
dca0: cee5dd64 cee5dcb0 c01eae34 c0038698 ffffffff d8200000 d09ae000  
0000005e
dcc0: 60001782 cee5dcd0 c0033830 c003300c 0a000023 f03fe03a 00000006  
00000004
dce0: 00000007 0000001d d09ae000 0000005e c0007420 00000003 00000002  
60001782
dd00: cee5dd78 cee5dd1c c003b1d4 c003b1a0 20000013 ffffffff 00000001  
00000000
dd20: cf815eb8 c0634560 d09ae000 c0007420 cee5dd74 c00931cc 00000000  
cf86a400
dd40: 00000002 00000020 00000000 00000010 d098606c cf9d77a4 cee5dd84  
cee5dd68
dd60: c01eb8bc c01eacdc cf9d7a54 cf9d7a54 00000001 00000000 cee5dda4  
cee5dd88
dd80: bf01faa4 c01eb694 cf9d772c d0872000 00000001 00000001 cee5ddc4  
cee5dda8
dda0: bf01f120 bf01fa8c d0872000 cf9d77f8 00000000 cf9d79d0 cee5ddd4  
cee5ddc8
ddc0: bf01f1c8 bf01f05c cee5ddf4 cee5ddd8 bf00d448 bf01f1c0 00000000  
d0986000
dde0: 00000000 d0986000 cee5de3c cee5ddf8 bf00b694 bf00d34c 22222222  
22222222
de00: 22222222 22222222 cee7f5e0 403c6f2b d0986000 d0986008 d0986000  
cee5de78
de20: d0986010 00000010 d098606c cf9d77e0 cee5de6c cee5de40 bf00ba04  
bf00b44c
de40: cee5de78 bebf6ae4 cee5de78 0000403c 403c6f2b 00000001 cee6f0e0  
00000000
de60: cee5df24 cee5de70 bf00a204 bf00b838 cee7f5e0 cee7f5e0 00000000  
00000000
de80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000  
00000000
dea0: 00000000 00000000 00000000 00000000 00000005 c009d184 00000003  
cee5dec8
dec0: 000192ec 00000002 00000026 0000a000 00000000 00000017 cf80cca0  
cf566db8
dee0: 00000017 cee5dfb0 0000bd3c 00000101 00000001 00000000 cee5dfac  
403c6f2b
df00: bebf6ae4 00000004 cee7f5e0 c0033e04 cee5c000 339e1c80 cee5df3c  
cee5df28
df20: bf00ae60 bf00a128 bf00b82c 00000000 cee5df54 cee5df40 c00aa988  
bf00ae50
df40: cee7f5e0 bebf6ae4 cee5df7c cee5df58 c00aac08 c00aa92c cee5df94  
cee5df68
df60: 00000004 bebf6ae4 403c6f2b cee7f5e0 cee5dfa4 cee5df80 c00aac58  
c00aa9a4
df80: 00000005 00000000 bebf743c 00000000 000192fc 00000036 00000000  
cee5dfa8
dfa0: c0033c80 c00aac24 bebf743c 00000000 00000004 403c6f2b bebf6ae4  
00000005
dfc0: bebf743c 00000000 000192fc 00000036 00000001 bebf7b1c 339e1c80  
00000003
dfe0: 00019188 bebf6ad8 0000a2a4 400e199c a0000010 00000004 00000000  
00000000
Backtrace:
[<c003868c>] (dma_cache_maint+0x0/0xa4) from [<c01eae34>]  
(usb_hcd_submit_urb+0x164/0x870)
[<c01eacd0>] (usb_hcd_submit_urb+0x0/0x870) from [<c01eb8bc>]  
(usb_submit_urb+0x234/0x250)
[<c01eb688>] (usb_submit_urb+0x0/0x250) from [<bf01faa4>]  
(usb_urb_submit+0x24/0x78 [dvb_usb])
  r7:00000000 r6:00000001 r5:cf9d7a54 r4:cf9d7a54
[<bf01fa80>] (usb_urb_submit+0x0/0x78 [dvb_usb]) from [<bf01f120>]  
(dvb_usb_ctrl_feed+0xd0/0x14c [dvb_usb])
  r7:00000001 r6:00000001 r5:d0872000 r4:cf9d772c
[<bf01f050>] (dvb_usb_ctrl_feed+0x0/0x14c [dvb_usb]) from [<bf01f1c8>]  
(dvb_usb_start_feed+0x14/0x18 [dvb_usb])
  r7:cf9d79d0 r6:00000000 r5:cf9d77f8 r4:d0872000
[<bf01f1b4>] (dvb_usb_start_feed+0x0/0x18 [dvb_usb]) from [<bf00d448>]  
(dmx_section_feed_start_filtering+0x108/0x150 [dvb_core])
[<bf00d340>] (dmx_section_feed_start_filtering+0x0/0x150 [dvb_core])  
from [<bf00b694>] (dvb_dmxdev_filter_start+0x254/0x3ec [dvb_core])
  r7:d0986000 r6:00000000 r5:d0986000 r4:00000000
[<bf00b440>] (dvb_dmxdev_filter_start+0x0/0x3ec [dvb_core]) from  
[<bf00ba04>] (dvb_demux_do_ioctl+0x1d8/0x38c [dvb_core])
[<bf00b82c>] (dvb_demux_do_ioctl+0x0/0x38c [dvb_core]) from  
[<bf00a204>] (dvb_usercopy+0xe8/0x170 [dvb_core])
[<bf00a11c>] (dvb_usercopy+0x0/0x170 [dvb_core]) from [<bf00ae60>]  
(dvb_demux_ioctl+0x1c/0x28 [dvb_core])
[<bf00ae44>] (dvb_demux_ioctl+0x0/0x28 [dvb_core]) from [<c00aa988>]  
(vfs_ioctl+0x68/0x78)
[<c00aa920>] (vfs_ioctl+0x0/0x78) from [<c00aac08>] (do_vfs_ioctl 
+0x270/0x280)
  r5:bebf6ae4 r4:cee7f5e0
[<c00aa998>] (do_vfs_ioctl+0x0/0x280) from [<c00aac58>] (sys_ioctl 
+0x40/0x64)
  r7:cee7f5e0 r6:403c6f2b r5:bebf6ae4 r4:00000004
[<c00aac18>] (sys_ioctl+0x0/0x64) from [<c0033c80>] (ret_fast_syscall 
+0x0/0x2c)
  r7:00000036 r6:000192fc r5:00000000 r4:bebf743c
Code: 9a000001 e15c0003 3a000001 e3a03000 (e5833000)
---[ end trace 64b6e462f7b06513 ]---

Is this a problem with MUSB, omap dma or the dvb stack?

regards,

Koen

--Apple-Mail-2-285886871
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI67KQMkyGM64RGpERAogoAJ9HWJYRVsO1T2b3BUxQGaA9gp+dgACbBq1o
/Ffq+g1jfNFrvnpIwe2CVM0=
=PEek
-----END PGP SIGNATURE-----

--Apple-Mail-2-285886871--
