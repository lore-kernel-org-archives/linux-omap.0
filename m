From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Soft lockup when disconnecting musb isochronous device.
Date: Tue, 30 Sep 2008 21:37:54 +0200
Message-ID: <723A4899-A764-4476-BA28-118D86985449@student.utwente.nl>
References: <e5e6ade50809260951g50c3d55cn71ce7e7a04803184@mail.gmail.com> <19F8576C6E063C45BE387C64729E739403DC1A61CA@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--316861159"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:37045 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbYI3TiN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 15:38:13 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739403DC1A61CA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--316861159
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 30 sep 2008, om 08:03 heeft Gupta, Ajay Kumar het volgende  
geschreven:

>> I've been trying to get the UVC camera driver working in linux-omap  
>> on
>> the Beagleboard, which uses musb.  With the latest linux-omap git,
>> capture doesn't work.  Applying Ajay Gupta's MUSB patches posted here
>> on 9/8 allows capture to work until the device is closed.
>> With or without Ajay's patches, when the device is closed, the
>> following lockup occurs.  Let me know if there is anything I can do  
>> to
>> help debug this.
>
> Have you applied below patch posted on 25/08/2008?
> [PATCH v3] OMAP: MUSB: Corrects urb unlink function path
>
> This patch is accepted and is pending to be merged with latest OMAP  
> GIT.

That patch sadly doesn't fix this:

tune to: :482000:I999B8C999D999M999T999G999Y999:T:27500:
Unable to handle kernel NULL pointer dereference at virtual address  
00000000
pgd = c12f4000
[00000000] *pgd=86d52031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in: mt2060 dvb_usb_dib0700 dib7000p dib7000m sn9c102  
dvb_usb videodev v4l1_compat dvb_core dib3000mc dibx000_common dib0070  
ipv6
CPU: 0    Not tainted  (2.6.27-rc7-omap1 #1)
PC is at dma_cache_maint+0x40/0xa4
LR is at usb_hcd_submit_urb+0x164/0x870
pc : [<c00386cc>]    lr : [<c01eae34>]    psr: 20000013
sp : c6f9bca0  ip : c6f9bcb0  fp : c6f9bcac
r10: c64a0828  r9 : 00000020  r8 : 00000000
r7 : 00000000  r6 : c78ec800  r5 : c64a0820  r4 : ffc46000
r3 : 00000000  r2 : 00000002  r1 : ffc4fa38  r0 : ffc46000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 812f4018  DAC: 00000015
Process w_scan (pid: 1755, stack limit = 0xc6f9a2e8)
Stack: (0xc6f9bca0 to 0xc6f9c000)
bca0: c6f9bd64 c6f9bcb0 c01eae34 c0038698 c00822fc c0080b60 00000044  
c6d53e40
bcc0: c6f9bd04 00000000 c0442ce4 00000000 00000000 00000001 00000000  
c6f9a000


it happens when w_scan tries to tune into a specific frequency on a  
USB DVB-T stick. Any ideas about that one?

I have applied these patches:

[PATCH v3] OMAP:MUSB: Corrects urb unlink function path
usb: musb: fix something
MUSB high-bandwidth support patch
MUSB ISO dma fix.

regards,

Koen



regards,

Koen

--Apple-Mail-5--316861159
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI4oAUMkyGM64RGpERAl5OAJ4h7FPfRcV/MMKytZt+DRs2+gCreACggN+J
iJbeYUDXotbEDtzj22Ray5Q=
=4N6n
-----END PGP SIGNATURE-----

--Apple-Mail-5--316861159--
