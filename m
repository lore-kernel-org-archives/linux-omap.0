From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: USB and SD performance issue
Date: Tue, 3 Feb 2009 12:35:17 +0100
Message-ID: <780A8A94-6815-4EB3-9303-FBF79F65510A@student.utwente.nl>
References: <814dfab70902030316u36fd4912n55b5fa98571cc88c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13--196836225"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:30151 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbZBCLf1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Feb 2009 06:35:27 -0500
In-Reply-To: <814dfab70902030316u36fd4912n55b5fa98571cc88c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Remith Ravi <remith@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-13--196836225
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 3 feb 2009, om 12:16 heeft Remith Ravi het volgende geschreven:

> Hello,
>
> Recently I have done a performance comparison of OMAP3 'USB OTG Host'
> and 'SD' drivers on different Linux Kernels.
> The performance of latest git kernel is less comparing to 2.6.22 TI  
> kernel.
> Could some one please explain me what cause this performance  
> difference?
>
> The performance is calculated by doing data transfer between RAM and
> the storage device (using 'time' command).
>
> The performance details are given below.
>
> 1) 2.6.29-rc2 kernel
> USB OTG (Host)         Read (4.2 MB/s)		Write (2.6 MB/s)	
> SD Card                     Read (3.88 MB/s)		Write (3.1 MB/s)
>
> 2) 2.6.28 kernel
> USB OTG (Host)         error		                error	
> SD Card                     Read  (4.2 MB/s)		Write (3.27 MB/s)
>
> 3) 2.6.22 TI kernel
> USB OTG (Host)         Read (5.4MB/s)		Write (6.14MB/s)	
> SD Card                      Read (6.7MB/s)		Write (6.43MB/s)

I get this with 2.6.28:

root@omap3evm:~# hdparm -t /dev/mmcblk0
/dev/mmcblk0:
  Timing buffered disk reads:   42 MB in  3.10 seconds =  13.53 MB/sec

root@beagleboard:~# hdparm -t /dev/mmcblk0
/dev/mmcblk0:
  Timing buffered disk reads:   44 MB in  3.13 seconds =  14.04 MB/sec

regards,

Koen


>
>
> Regards,
> Remith
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-13--196836225
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJiCv3MkyGM64RGpERAg1YAKCe6BwtGG5DQFZ7gm5Vu2AcJmCy6ACfQxUj
IECm/por/sv+uCA6E67Kx1E=
=B+pf
-----END PGP SIGNATURE-----

--Apple-Mail-13--196836225--
