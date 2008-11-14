From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Serial port crashes omap3 on boot with 2.6.28rc4
Date: Fri, 14 Nov 2008 13:15:05 +0100
Message-ID: <571101AA-6E65-4BA6-8DF6-B445515010A1@student.utwente.nl>
References: <D4C9733E-73D0-403F-893D-910C59EDD20A@student.utwente.nl> <D8E4F982-85F9-4DAB-8BC4-69135109EBC9@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-14--750397894"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:57615 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYKNMPM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 07:15:12 -0500
Received: from [172.20.1.5] (vpn006013.vpn.utwente.nl [130.89.6.13])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id mAECF7KK001984
          for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 13:15:07 +0100
In-Reply-To: <D8E4F982-85F9-4DAB-8BC4-69135109EBC9@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-14--750397894
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 nov 2008, om 11:56 heeft Koen Kooi het volgende geschreven:

>
> Op 14 nov 2008, om 11:17 heeft Koen Kooi het volgende geschreven:
>
>> Hi,
>>
>> I updated to the current head  
>> (5ecf98b76fa95078277c9037bb01640fd3de5e2c) and get this on boot  
>> (with debug_ll) on omap3evm:
>>
>> <7>omap-dss DISPLAY: panel 'panel-dvi' registered
>> <6>Serial: 8250/16550 driver4 ports, IRQ sharing enabled
>> <6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
>> <....,...:4...4../0400..1=......F1.5S.<....,...:4.3^F!^C../ 
>> 0.0^F00..1=7K....F1.5S.<.....%;..&=%.".$.<."F:..5. .!*$.<...0^G.. 
>> 5. .!*$.<...%^B-J/.0.."..%C0^G...5(V6..!^C0.^D000)^V.6...%C0^G%C%. 
>> %^C!"2^G.."...$...&R...%C0^G...8).%
>> ..'%:%.#. ...,.<.!.74^C3..:..#.#V%...1.V..<.).5...v8. {...$.r. 
>> 3...6......
>>
>> Any ideas?
>
> I get this on rc3 now as well, it seems that the evm dss2 patch has  
> some side effects, console is restored when userspace launches getty

I can boot rc4 + dss2 + dss2-evm into userspace if the omap_rev() TWL  
writes don't get triggered in board-omap3evm.c. Once those get run I  
get more garbage and a crash, without them a little garbage that getty  
fixes up.

regards,

Koen

--Apple-Mail-14--750397894
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJHWvLMkyGM64RGpERAnjCAJ9L9XtppRFm9XDZgrr5vlY72RFaEACgqGYy
IFiFrtHZ+wwK+yruRRmZHzE=
=dIQ1
-----END PGP SIGNATURE-----

--Apple-Mail-14--750397894--
