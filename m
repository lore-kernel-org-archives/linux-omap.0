From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/3] ARM: OMAP: SmartReflex driver
Date: Mon, 2 Jun 2008 14:31:57 +0200
Message-ID: <CC3604C1-277A-4CE1-9B3D-EE0ADFB97E3E@student.utwente.nl>
References: <1212406192.32058.18.camel@kj-ubuntu>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:37776 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872AbYFBNjI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jun 2008 09:39:08 -0400
In-Reply-To: <1212406192.32058.18.camel@kj-ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 2 jun 2008, om 13:29 heeft Kalle Jokiniemi het volgende geschreven:

> Here is an updated version of the SmartReflex driver.
>
> Patches 1 and 2 are same as before, but patch 3 has some new things:
>
> - Changed the register accessing to use the prm_xxx_mod_reg{_bits}()
>  functions.
>
> - Created a Kconfig entry for SmartReflex in "System type->TI OMAP
>  Implementations" menu.
>
> Tested on 3430SDP.

Compiles for beagleboard, but the board hangs after:

echo -n 1 > /sys/power/sr_vdd1_autocomp
echo -n 1 > /sys/power/sr_vdd2_autocomp

But that's likely to be a beagleboard specific problem.

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIQ+g/MkyGM64RGpERAqwgAJ97AE4z0bIBZJs7nZcO1Npa8YkIcgCfY6KM
3Hhr4AIdmzNiozdqs1uQUgg=
=rcQP
-----END PGP SIGNATURE-----
