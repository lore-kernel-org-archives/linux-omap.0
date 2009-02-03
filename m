From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: USB and SD performance issue
Date: Tue, 3 Feb 2009 12:47:28 +0100
Message-ID: <C48F0EBA-DB90-4CF9-AADF-6DCCB3F30A4D@student.utwente.nl>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F542051E@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-14--196105607"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:30660 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbZBCLr4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Feb 2009 06:47:56 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F542051E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Remith Ravi <remith@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-14--196105607
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 3 feb 2009, om 12:37 heeft Gadiyar, Anand het volgende geschreven:

>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
>> Sent: Tuesday, February 03, 2009 5:05 PM
>> To: Remith Ravi
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: USB and SD performance issue
>>
>>
>> Op 3 feb 2009, om 12:16 heeft Remith Ravi het volgende geschreven:
>>
>>> Hello,
>>>
>>> Recently I have done a performance comparison of OMAP3 'USB
>> OTG Host'
>>> and 'SD' drivers on different Linux Kernels.
>>> The performance of latest git kernel is less comparing to
>> 2.6.22 TI
>>> kernel.
>>> Could some one please explain me what cause this performance
>>> difference?
>>>
>>> The performance is calculated by doing data transfer between RAM and
>>> the storage device (using 'time' command).
>>>
>>> The performance details are given below.
>>>
>>> 1) 2.6.29-rc2 kernel
>>> USB OTG (Host)         Read (4.2 MB/s)		Write
>> (2.6 MB/s)	
>>> SD Card                     Read (3.88 MB/s)		
>> Write (3.1 MB/s)
>>>
>>> 2) 2.6.28 kernel
>>> USB OTG (Host)         error		                error	
>>> SD Card                     Read  (4.2 MB/s)		
>> Write (3.27 MB/s)
>>>
>>> 3) 2.6.22 TI kernel
>>> USB OTG (Host)         Read (5.4MB/s)		Write
>> (6.14MB/s)	
>>> SD Card                      Read (6.7MB/s)		Write (6.43MB/s)
>>
>> I get this with 2.6.28:
>>
>> root@omap3evm:~# hdparm -t /dev/mmcblk0
>> /dev/mmcblk0:
>>  Timing buffered disk reads:   42 MB in  3.10 seconds =  13.53 MB/sec
>>
>> root@beagleboard:~# hdparm -t /dev/mmcblk0
>> /dev/mmcblk0:
>>  Timing buffered disk reads:   44 MB in  3.13 seconds =  14.04 MB/sec
>>
>> regards,
>>
>> Koen
>>
>
> What does `hdparm -tT /dev/mmcblk0` give?

root@beagleboard:~# hdparm -tT /dev/mmcblk0
/dev/mmcblk0:
  Timing cached reads:   240 MB in  2.01 seconds = 119.32 MB/sec
  Timing buffered disk reads:   42 MB in  3.01 seconds =  13.97 MB/sec

root@omap3evm:~# hdparm -tT /dev/mmcblk0
/dev/mmcblk0:
  Timing cached reads:   300 MB in  2.00 seconds = 149.83 MB/sec
  Timing buffered disk reads:   42 MB in  3.17 seconds =  13.23 MB/sec

Which is misleading, since -T tests the bandwidth or your RAM, which  
in my case is limited since both machines are displaying a stream from  
a webcam attached to USB in X11, so the overlays and framebuffers are  
stealing a large part of the bw. Killing the screensaver on the EVM  
gave me 35MB/s 'back' :)

regards,

Koen


>
>
> - Anand
>


--Apple-Mail-14--196105607
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJiC7SMkyGM64RGpERAkPfAJ0eMI7aXavYtLSi3W6/c9PkGzkn2wCeLVfy
MuLhoCtuc5u8Tykufr8aflw=
=p6Wk
-----END PGP SIGNATURE-----

--Apple-Mail-14--196105607--
