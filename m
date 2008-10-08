From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: DVB-T problems with MUSB
Date: Wed, 8 Oct 2008 10:32:50 +0200
Message-ID: <CDDBA81A-30AE-451C-85E3-037C16D3C1DD@student.utwente.nl>
References: <70E3439A-A4CE-442B-928A-EEBAB253F279@student.utwente.nl> <20081007231032.GB669@inside.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-334434599"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:53648 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbYJHIdg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Oct 2008 04:33:36 -0400
Received: from [172.20.1.5] (vpn006021.vpn.utwente.nl [130.89.6.21])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m988WqI2019297
          for <linux-omap@vger.kernel.org>; Wed, 8 Oct 2008 10:32:52 +0200
In-Reply-To: <20081007231032.GB669@inside.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-334434599
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 8 okt 2008, om 01:10 heeft Kimmo Jukarainen het volgende geschreven:

> On Tue, Oct 07, 2008 at 09:03:42PM +0200, Koen Kooi wrote:
>> Is this a problem with MUSB, omap dma or the dvb stack?
>
> I'd say dvb stack. This small patch fixed my dvb-t stick with
> a omap2 board:
>
> http://www.linuxtv.org/pipermail/linux-dvb/2008-January/023040.html

Thanks! Sadly I still get this after applying that patch:

w_scan output:

826000: signal ok (I999B8C999D999M999T999G999Y999)
834000:
842000:
850000:
858000:
tune to: :482000:I999B8C999D999M999T999G999Y999:T:27500:

kernel output:

Unable to handle kernel NULL pointer dereference at virtual address  
00000000
pgd = cee44000
[00000000] *pgd=8f9dc031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in: mt2060 dvb_usb_dib0700 dib7000p dib7000m dvb_usb  
dvb_core dib3000mc dibx000_common dib0070 ipv6
CPU: 0    Not tainted  (2.6.27-rc7-omap1 #1)
PC is at dma_cache_maint+0x40/0xa4
LR is at usb_hcd_submit_urb+0x164/0x870
pc : [<c00386cc>]    lr : [<c01eae34>]    psr: 20000013
sp : cedbbca0  ip : cedbbcb0  fp : cedbbcac
r10: ce24a968  r9 : 00000020  r8 : 00000000
r7 : 00000000  r6 : cf953800  r5 : ce24a960  r4 : ffc47000
r3 : 00000000  r2 : 00000002  r1 : ffc50a38  r0 : ffc47000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 8ee44018  DAC: 00000015
Process w_scan (pid: 1693, stack limit = 0xcedba2e8)
Stack: (0xcedbbca0 to 0xcedbc000)
bca0: cedbbd64 cedbbcb0 c01eae34 c0038698 c00822fc c0080b60 00000044  
ced92220
bcc0: cedbbd04 00000000 c0442ce4 00000000 00000000 00000001 00000000  
cedba000
bce0: c0442524 c0442524 cedbbd14 c0442ce4 000000d2 c0442ce0 00000000  
cef65980
bd00: d098606c 000000ef cedbbd74 cedbbd18 c0082700 c0082248 00000001  
00000000
bd20: cf815eb8 c0651900 d09ae000 c0007420 cedbbd74 c00931cc 00000000  
cec42c00
bd40: 00000002 00000020 00000000 00000010 d098606c ced247a4 cedbbd84  
cedbbd68
bd60: c01eb8bc c01eacdc ced24a54 ced24a54 00000001 00000000 cedbbda4  
cedbbd88
bd80: bf05aaa4 c01eb694 ced2472c d0872000 00000001 00000001 cedbbdc4  
cedbbda8
bda0: bf05a120 bf05aa8c d0872000 ced247f8 00000000 ced249d0 cedbbdd4  
cedbbdc8
bdc0: bf05a1c8 bf05a05c cedbbdf4 cedbbdd8 bf048448 bf05a1c0 00000000  
d0986000
bde0: 00000000 d0986000 cedbbe3c cedbbdf8 bf046694 bf04834c 22222222  
22222222
be00: 22222222 22222222 ce1322a0 403c6f2b d0986000 d0986008 d0986000  
cedbbe78
be20: d0986010 00000010 d098606c ced247e0 cedbbe6c cedbbe40 bf046a04  
bf04644c
be40: cedbbe78 bec27b94 cedbbe78 0000403c 403c6f2b 00000001 cee1d440  
00000000
be60: cedbbf24 cedbbe70 bf045204 bf046838 ce1322a0 ce1322a0 00000000  
00000000
be80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000  
00000000
bea0: 00000000 00000000 00000000 00000000 00000005 c009d184 00000003  
cedbbec8
bec0: 000192ec 00000002 00000026 0000a000 00000000 00000817 cf80ce20  
cf6460d8
bee0: 00000817 cedbbfb0 bec27bf8 00000101 00000001 00000000 cedbbfac  
403c6f2b
bf00: bec27b94 00000004 ce1322a0 c0033e04 cedba000 339e1c80 cedbbf3c  
cedbbf28
bf20: bf045e60 bf045128 bf04682c 00000000 cedbbf54 cedbbf40 c00aa988  
bf045e50
bf40: ce1322a0 bec27b94 cedbbf7c cedbbf58 c00aac08 c00aa92c cedbbf94  
cedbbf68
bf60: 00000004 bec27b94 403c6f2b ce1322a0 cedbbfa4 cedbbf80 c00aac58  
c00aa9a4
bf80: 00000005 00000000 bec284ec 00000000 000192fc 00000036 00000000  
cedbbfa8
bfa0: c0033c80 c00aac24 bec284ec 00000000 00000004 403c6f2b bec27b94  
00000005
bfc0: bec284ec 00000000 000192fc 00000036 00000001 bec28bcc 339e1c80  
00000003
bfe0: 00019188 bec27b88 0000a2a4 400e199c a0000010 00000004 80675021  
80675421
Backtrace:
[<c003868c>] (dma_cache_maint+0x0/0xa4) from [<c01eae34>]  
(usb_hcd_submit_urb+0x164/0x870)
[<c01eacd0>] (usb_hcd_submit_urb+0x0/0x870) from [<c01eb8bc>]  
(usb_submit_urb+0x234/0x250)
[<c01eb688>] (usb_submit_urb+0x0/0x250) from [<bf05aaa4>]  
(usb_urb_submit+0x24/0x78 [dvb_usb])
  r7:00000000 r6:00000001 r5:ced24a54 r4:ced24a54
[<bf05aa80>] (usb_urb_submit+0x0/0x78 [dvb_usb]) from [<bf05a120>]  
(dvb_usb_ctrl_feed+0xd0/0x14c [dvb_usb])
  r7:00000001 r6:00000001 r5:d0872000 r4:ced2472c
[<bf05a050>] (dvb_usb_ctrl_feed+0x0/0x14c [dvb_usb]) from [<bf05a1c8>]  
(dvb_usb_start_feed+0x14/0x18 [dvb_usb])
  r7:ced249d0 r6:00000000 r5:ced247f8 r4:d0872000
[<bf05a1b4>] (dvb_usb_start_feed+0x0/0x18 [dvb_usb]) from [<bf048448>]  
(dmx_section_feed_start_filtering+0x108/0x150 [dvb_core])
[<bf048340>] (dmx_section_feed_start_filtering+0x0/0x150 [dvb_core])  
from [<bf046694>] (dvb_dmxdev_filter_start+0x254/0x3ec [dvb_core])
  r7:d0986000 r6:00000000 r5:d0986000 r4:00000000
[<bf046440>] (dvb_dmxdev_filter_start+0x0/0x3ec [dvb_core]) from  
[<bf046a04>] (dvb_demux_do_ioctl+0x1d8/0x38c [dvb_core])
[<bf04682c>] (dvb_demux_do_ioctl+0x0/0x38c [dvb_core]) from  
[<bf045204>] (dvb_usercopy+0xe8/0x170 [dvb_core])
[<bf04511c>] (dvb_usercopy+0x0/0x170 [dvb_core]) from [<bf045e60>]  
(dvb_demux_ioctl+0x1c/0x28 [dvb_core])
[<bf045e44>] (dvb_demux_ioctl+0x0/0x28 [dvb_core]) from [<c00aa988>]  
(vfs_ioctl+0x68/0x78)
[<c00aa920>] (vfs_ioctl+0x0/0x78) from [<c00aac08>] (do_vfs_ioctl 
+0x270/0x280)
  r5:bec27b94 r4:ce1322a0
[<c00aa998>] (do_vfs_ioctl+0x0/0x280) from [<c00aac58>] (sys_ioctl 
+0x40/0x64)
  r7:ce1322a0 r6:403c6f2b r5:bec27b94 r4:00000004
[<c00aac18>] (sys_ioctl+0x0/0x64) from [<c0033c80>] (ret_fast_syscall 
+0x0/0x2c)
  r7:00000036 r6:000192fc r5:00000000 r4:bec284ec
Code: 9a000001 e15c0003 3a000001 e3a03000 (e5833000)
---[ end trace 215830a8c165e1ce ]---

This is with:

Linux version 2.6.27-rc7-omap1 (koen@dominion) (gcc version 4.2.1) #1  
Wed Oct 8 09:58:50 CEST 2008
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=00c5387f


regards,

Koen 
                

--Apple-Mail-3-334434599
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI7HA0MkyGM64RGpERAs7oAJ9rp6e14EJDgvLqWocS21L9SBZzWACeIupN
RK8JJjYX2XP3SVgHLZoIIiA=
=k8Cv
-----END PGP SIGNATURE-----

--Apple-Mail-3-334434599--
