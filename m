From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: twl_mmc1_set_power problem, was: Re: Serial port crashes omap3 on boot with 2.6.28rc4
Date: Fri, 14 Nov 2008 15:20:13 +0100
Message-ID: <CA1477DD-3672-44B1-860D-86A662C7E7E7@student.utwente.nl>
References: <D4C9733E-73D0-403F-893D-910C59EDD20A@student.utwente.nl> <D8E4F982-85F9-4DAB-8BC4-69135109EBC9@student.utwente.nl> <571101AA-6E65-4BA6-8DF6-B445515010A1@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16--742889963"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:49010 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYKNOU3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 09:20:29 -0500
In-Reply-To: <571101AA-6E65-4BA6-8DF6-B445515010A1@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: ext David Brownell <david-b@pacbell.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16--742889963
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 nov 2008, om 13:15 heeft Koen Kooi het volgende geschreven:

>
> Op 14 nov 2008, om 11:56 heeft Koen Kooi het volgende geschreven:
>
>>
>> Op 14 nov 2008, om 11:17 heeft Koen Kooi het volgende geschreven:
>>
>>> Hi,
>>>
>>> I updated to the current head  
>>> (5ecf98b76fa95078277c9037bb01640fd3de5e2c) and get this on boot  
>>> (with debug_ll) on omap3evm:
>>>
>>> <7>omap-dss DISPLAY: panel 'panel-dvi' registered
>>> <6>Serial: 8250/16550 driver4 ports, IRQ sharing enabled
>>> <6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
>>> <....,...:4...4../0400..1=......F1.5S.<....,...:4.3^F!^C../ 
>>> 0.0^F00..1=7K....F1.5S.<.....%;..&=%.".$.<."F:..5. .!*$.<...0^G.. 
>>> 5. .!*$.<...%^B-J/.0.."..%C0^G...5(V6..!^C0.^D000)^V.6...%C0^G%C%. 
>>> %^C!"2^G.."...$...&R...%C0^G...8).%
>>> ..'%:%.#. ...,.<.!.74^C3..:..#.#V%...1.V..<.).5...v8. {...$.r. 
>>> 3...6......
>>>
>>> Any ideas?
>>
>> I get this on rc3 now as well, it seems that the evm dss2 patch has  
>> some side effects, console is restored when userspace launches getty
>
> I can boot rc4 + dss2 + dss2-evm into userspace if the omap_rev()  
> TWL writes don't get triggered in board-omap3evm.c. Once those get  
> run I get more garbage and a crash, without them a little garbage  
> that getty fixes up.

After disabled the 8250 driver:

<1>Unable to handle kernel NULL pointer dereference at virtual address  
00000029
<1>pgd = c0004000
<1>[00000029] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.28-rc4-omap1 #8)
PC is at twl_mmc1_set_power+0x20/0xf8
LR is at omap_mmc_set_ios+0x78/0x25c
pc : [<c003c060>]    lr : [<c0262698>]    psr: 20000013
sp : c7b1ff08  ip : c7b1ff28  fp : c7b1ff24
r10: 00000000  r9 : 00000000  r8 : c02597dc
r7 : 00000013  r6 : c0497220  r5 : 00000001  r4 : c705a000
r3 : 00000000  r2 : 00000001  r1 : 00000000  r0 : c7b14008
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 80004018  DAC: 00000017
Process kmmcd (pid: 208, stack limit = 0xc7b1e2e8)
Stack: (0xc7b1ff08 to 0xc7b20000)
ff00:                   c705a000 c705a000 c705a200 c705a168 c7b1ff44  
c7b1ff28
ff20: c0262698 c003c04c c705a168 c705a000 c705a188 c7b1e000 c7b1ff5c  
c7b1ff48
ff40: c0258d84 c026262c 60000013 c705a000 c7b1ff7c c7b1ff60 c02598d4  
c0258d24
ff60: c0050a84 c008eb0c c705a18c c7b5a9e0 c7b1ffa4 c7b1ff80 c0069ef4  
c02597e8
ff80: c7b1ffb8 c7be5020 c7b1e000 c7b5a9e0 00000000 00000000 c7b1ffdc  
c7b1ffa8
ffa0: c006ac5c c0069e38 c006deb0 00000000 c7be5020 c006e238 c7b1ffb8  
c7b1ffb8
ffc0: c7b5a9e0 c006ab6c 00000000 00000000 c7b1fff4 c7b1ffe0 c006dec8  
c006ab78
ffe0: 00000000 00000000 00000000 c7b1fff8 c005b7f8 c006de80 c7b200e0  
00000000
Backtrace:
[<c003c040>] (twl_mmc1_set_power+0x0/0xf8) from [<c0262698>]  
(omap_mmc_set_ios+0x78/0x25c)
  r7:c705a168 r6:c705a200 r5:c705a000 r4:c705a000
[<c0262620>] (omap_mmc_set_ios+0x0/0x25c) from [<c0258d84>]  
(mmc_power_up+0x6c/0xb0)
  r7:c7b1e000 r6:c705a188 r5:c705a000 r4:c705a168
[<c0258d18>] (mmc_power_up+0x0/0xb0) from [<c02598d4>] (mmc_rescan 
+0xf8/0x244)
  r5:c705a000 r4:60000013
[<c02597dc>] (mmc_rescan+0x0/0x244) from [<c0069ef4>] (run_workqueue 
+0xc8/0x184)
r5:c7b5a9e0 r4:c705a18c
[<c0069e2c>] (run_workqueue+0x0/0x184) from [<c006ac5c>] (worker_thread 
+0xf0/0x104)
  r9:00000000 r8:00000000 r7:c7b5a9e0 r6:c7b1e000 r5:c7be5020
r4:c7b1ffb8
[<c006ab6c>] (worker_thread+0x0/0x104) from [<c006dec8>] (kthread 
+0x54/0x80)
  r7:00000000 r6:00000000 r5:c006ab6c r4:c7b5a9e0
[<c006de74>] (kthread+0x0/0x80) from [<c005b7f8>] (do_exit+0x0/0x7f4)
  r5:00000000 r4:00000000
Code: e1a07003 e59f60d4 0a000021 e5963000 (e5d33029)
<4>---[ end trace 9b8d94bd02e002d5 ]---

So the serial garbage was hiding a problem with the mmc driver since  
the last output I get is:

<6>VFP support v0.3: implementor 41 architecture 3 part 30 variant c  
rev 1
<6>twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01  
00:00:00 UTC (946684800)
<6>Waiting for root device /dev/mmcblk0p2...

I've lost track on which TWL patches were applied, so a quick hint on  
what to try next would be appreciated :)

regards,

Koen	


--Apple-Mail-16--742889963
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJHYkfMkyGM64RGpERAtK5AKCQH33PvswuDTFjYJeelNxjT3SeSgCfUTiY
TcvZHdA4hSUP/tZMHDEuPE8=
=AruT
-----END PGP SIGNATURE-----

--Apple-Mail-16--742889963--
