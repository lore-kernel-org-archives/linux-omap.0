From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: omap3evm .27rc6 and ethernet
Date: Sun, 14 Sep 2008 21:43:14 +0200
Message-ID: <DEC44939-9014-4CB5-A3A1-C5EE7821AE84@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-448542614"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:38482 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbYINTn2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Sep 2008 15:43:28 -0400
Received: from [172.20.1.5] (vpn006085.vpn.utwente.nl [130.89.6.85])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8EJhH4A023935
          for <linux-omap@vger.kernel.org>; Sun, 14 Sep 2008 21:43:18 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-448542614
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I tried booting .27rc6 (git de1121fdb899f762) on an evm today and got:

irq 336: nobody cared (try booting with the "irqpoll" option)
[<c002aa8c>] (dump_stack+0x0/0x14) from [<c0067184>] (__report_bad_irq 
+0x38/0x88)
[<c006714c>] (__report_bad_irq+0x0/0x88) from [<c00673e4>]  
(note_interrupt+0x210/0x270)
  r5:c034c5e8 r4:00000000
[<c00671d4>] (note_interrupt+0x0/0x270) from [<c0067fdc>]  
(handle_level_irq+0x94/0xf0)
[<c0067f48>] (handle_level_irq+0x0/0xf0) from [<c0035c44>]  
(gpio_irq_handler+0x118/0x154)
  r5:00000150 r4:c034c5e8
[<c0035b2c>] (gpio_irq_handler+0x0/0x154) from [<c0026048>]  
(__exception_text_start+0x48/0x64)
[<c0026000>] (__exception_text_start+0x0/0x64) from [<c0026810>]  
(__irq_svc+0x30/0x80)
Exception stack(0xc781dd68 to 0xc781ddb0)
dd60:                   00000000 00010000 00000000 00000000 c00675a0  
c034c5e8
dd80: 40000013 00000150 00000000 00000008 c79645e0 c781dde4 c781dd68  
c781ddb0
dda0: c00362e4 c0066fc8 60000013 ffffffff
  r7:00000150 r6:40000013 r5:d8200000 r4:ffffffff
[<c0066ddc>] (setup_irq+0x0/0x23c) from [<c00670b0>] (request_irq 
+0x98/0xc0)
[<c0067018>] (request_irq+0x0/0xc0) from [<c017aff4>]  
(smc911x_drv_probe+0x838/0xa28)
[<c017a7bc>] (smc911x_drv_probe+0x0/0xa28) from [<c017210c>]  
(platform_drv_probe+0x20/0x24)
[<c01720ec>] (platform_drv_probe+0x0/0x24) from [<c01713a4>]  
(driver_probe_device+0xd0/0x17c)
[<c01712d4>] (driver_probe_device+0x0/0x17c) from [<c017149c>]  
(__driver_attach+0x4c/0x70)
  r7:c035454c r6:c035454c r5:c034450c r4:c0344460
[<c0171450>] (__driver_attach+0x0/0x70) from [<c0170a1c>]  
(bus_for_each_dev+0x4c/0x84)
  r7:c035454c r6:c0171450 r5:c781deb4 r4:00000000
[<c01709d0>] (bus_for_each_dev+0x0/0x84) from [<c01711ec>]  
(driver_attach+0x20/0x28)
  r7:c787c320 r6:00000000 r5:c035454c r4:00000000
[<c01711cc>] (driver_attach+0x0/0x28) from [<c0170ea8>] (bus_add_driver 
+0xa8/0x214)
[<c0170e00>] (bus_add_driver+0x0/0x214) from [<c0171690>]  
(driver_register+0x98/0x120)
  r8:00000000 r7:00000000 r6:00000000 r5:c035454c r4:c0360ac0
[<c01715f8>] (driver_register+0x0/0x120) from [<c01724a4>]  
(platform_driver_register+0x78/0x94)
[<c017242c>] (platform_driver_register+0x0/0x94) from [<c001a3e0>]  
(smc911x_init+0x14/0x1c)
[<c001a3cc>] (smc911x_init+0x0/0x1c) from [<c0026298>]  
(__exception_text_end+0x50/0x17c)
[<c0026248>] (__exception_text_end+0x0/0x17c) from [<c0008734>]  
(kernel_init+0x70/0xdc)
[<c00086c4>] (kernel_init+0x0/0xdc) from [<c0046ce8>] (do_exit 
+0x0/0x6b8)
  r5:00000000 r4:00000000
handlers:
[<c017b5bc>] (smc911x_interrupt+0x0/0x6d0)
Disabling IRQ #336
eth0: LAN9115 (rev 2) at 0x2c000000 IRQ 336
eth0: Ethernet addr: 00:50:c2:7e:87:fe
eth0: LAN911x Internal PHY

eth0 gives all the signs of working to userspace, but refuses to  
transmit or receive packages. Any hints on this?

The touchscreen seems to show similar symptoms (without the oops), but  
that is most likely PEBKAC.

regards,

Koen

--Apple-Mail-2-448542614
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIzWlVMkyGM64RGpERAtPqAJ9D/43GZ1ODoiueWgXnv5ymeBnwbQCgkkIQ
HCiGxQ8bSPHDIu0pPAsmukM=
=tFbQ
-----END PGP SIGNATURE-----

--Apple-Mail-2-448542614--
