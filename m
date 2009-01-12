From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Suspend/Resume questions
Date: Mon, 12 Jan 2009 19:26:22 +0100
Message-ID: <74170B21-3F2A-4D9B-9C1E-9B30DDC0C5E9@student.utwente.nl>
References: <1231780282.21812.194.camel@blackhole>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10-74511981"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:45068 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbZALS0m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 13:26:42 -0500
In-Reply-To: <1231780282.21812.194.camel@blackhole>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-10-74511981
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 12 jan 2009, om 18:11 heeft Peter Barada het volgende geschreven:

>
> I'm using the current PM branch (2.6.28-rc8, revision 2beb9b4b) to
> investigate power consumption on an OMAP35x board (Logic's LV SOM).
>
> When I:
>
> # mount -t vfat /dev/mmc0blkp1 /mnt/sdcard
> # echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> omapfb omapfb: timeout waiting for FRAME DONE
> mmc0: card 133b removed
> MMC: killing requests for dead queue
> cpufreq: suspend failed to assert current frequency is what timing  
> core
> thinks it is.
> Powerdomain (iva2_pwrdm) didn't enter target state 1
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (per_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend
> cpufreq: resume failed to assert current frequency is what timing core
> thinks it is.
>
> eth0: link down
> soc-audio soc-audio: scheduling resume work
> Restarting tasks ...
> soc-audio soc-audio: starting resume work
> soc-audio soc-audio: resume work completed
> done.
> omap3530# mmc0: new high speed SD card at address 133b
> mmcblk1: mmc0:133b SD02G 1.91 GiB
> mmcblk1: p1
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>
> omap3530# ls -l /dev/mmcblk0*
> ls: /dev/mmcblk0*: No such file or directory
> omap3530#
>
> 1) Is "echo mem > /sys/power/state" the proper method to put the board
> into suspend?
>
> 2) Why does the MMC "move" from /dev/mmcblk0 before the suspend
> to /dev/mmcblk1 after the suspend? (If the card is not mounted, it
> doesn't "move").

Do you have CONFIG_MMC_UNSAFE_RESUME=y in your .config? It's basically  
always needed if you suspend a mounted filesystem on MMC/SD.

regards,

Koen

>

--Apple-Mail-10-74511981
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJa4tQMkyGM64RGpERAu0xAJ0aqBT2sjemjWFlZbDMaNUg35z7kwCfSdB1
vnwJfeC1a9Cb0pFJ2X1toKg=
=QcWB
-----END PGP SIGNATURE-----

--Apple-Mail-10-74511981--
