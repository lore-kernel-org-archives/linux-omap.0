From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Latest l-o and usb gadget + NFS root problems
Date: Fri, 27 Mar 2009 11:38:39 +0100
Message-ID: <7945E68B-8E2E-4B15-9198-3B3F16F0D10E@student.utwente.nl>
References: <1238146821.28118.36.camel@tubuntu>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-41--2402036"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:38284 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZC0Kk6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Mar 2009 06:40:58 -0400
Received: from [172.20.1.5] (vpn006032.vpn.utwente.nl [130.89.6.32])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n2RAcdWN018902
          for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2009 11:38:39 +0100
In-Reply-To: <1238146821.28118.36.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-41--2402036
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 27 mrt 2009, om 10:40 heeft Tomi Valkeinen het volgende geschreven:

> Hi,
>
> There seems to be something wrong with latest l-o, usb gadget ethernet
> and nfsroot. I'm not sure when it broke, but 2.6.29-rc3 worked fine.
> This happens to me with beagleboard and a non-public omap3 board:
>
> g_ether gadget: high speed config #1: CDC Ethernet (ECM)
> IP-Config: Guessing netmask 255.255.255.0
> IP-Config: Complete:
>    device=usb0, addr=192.168.2.15, mask=255.255.255.0,  
> gw=255.255.255.255,
>    host=192.168.2.15, domain=, nis-domain=(none),
>    bootserver=255.255.255.255, rootserver=192.168.2.14, rootpath=
> Looking up port of RPC 100003/2 on 192.168.2.14
> Looking up port of RPC 100005/1 on 192.168.2.14
> VFS: Mounted root (nfs filesystem) on device 0:12.
> Freeing init memory: 140K
> nfs: server 192.168.2.14 not responding, still trying
> nfs: server 192.168.2.14 not responding, still trying
> ...
>
> With the nonpublic board I was able to boot up occasionally, but it
> failed after doing something heavier on the nfs filesystem.

Are you running with lockdep enabled or disabled?

regards,

Koen


--Apple-Mail-41--2402036
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJzKyvMkyGM64RGpERAkM9AJ99LQN/o9xM6Lath1XUxQOonwk18QCbBpHI
7epjqMwYl/aYbHqYsx1vSIA=
=zD4h
-----END PGP SIGNATURE-----

--Apple-Mail-41--2402036--
