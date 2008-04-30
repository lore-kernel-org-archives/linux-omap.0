From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB EHCI issue on OMAP3 Beagle
Date: Wed, 30 Apr 2008 04:17:45 -0500
Message-ID: <3d69a905f897ec2d3153921f1a447013@felipebalbi.com>
References: <0680EC522D0CC943BC586913CF3768C02E703DED@dbde02.ent.ti.com> <241B8109-541C-43EC-B83E-F301F53B6FA9@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57426 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbYD3JRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 05:17:47 -0400
In-Reply-To: <241B8109-541C-43EC-B83E-F301F53B6FA9@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org



On Wed, 30 Apr 2008 11:09:37 +0200, Koen Kooi <k.kooi@student.utwente.nl>
wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Op 30 apr 2008, om 10:42 heeft Syed Mohammed, Khasim het volgende
> geschreven:
>> Hi all,
>>
>> We have USB ECHI port 1 integrated with SMSC PHY (USB 3326) on
>> Beagle Board. I have connected a high speed Mass Storage (USB
>> harddisk) to the port, the enumeration happens fine and I am also
>> able to do a data transfer, but after some time, it fails with below
>> message:
> 
>> ehci-omap ehci-omap.0: port 1 reset error -110
>> hub 2-0:1.0: hub_port_status failed (err = -32)
>> # ehci-omap ehci-omap.0: port 1 reset error -110
>> hub 2-0:1.0: hub_port_status failed (err = -32)
> 
> I'm having similar issues with usbon the beagleboard:
> 
> usb 1-1: USB disconnect, address 2
> usb 1-1.3: USB disconnect, address 7
> eth0: unregister 'asix' usb-ehci-omap.0-1.3, ASIX AX8817x USB 2.0
> Ethernet
> usb 1-1: clear tt 4 (9082) error -19
> usb 1-1: clear tt 4 (9082) error -19
> 
> I tried various combinations of the usb-ethernet adaptor with and
> without hub and found:
> 
> * no hub,  low cpu load + slow transfer (e.g. download over adsl):
> transferring a few MiBs is OK
> * hub, low cpu load + slow transfer: transferring ~ 1MiB is OK
> * big cpu load (e.g. using scp): 128KiB max
> 
> I didn't dare to try a USB disk yet :)

false overcurrent indication maybe ?

try modprobe ehci_hcd ignore_oc=1

> 
> regards,
> 
> Koen
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.5 (Darwin)
> 
> iD8DBQFIGDdTMkyGM64RGpERAhm8AJ9KfZy30s9i+iupAHdvrXQt5b0pQwCcDhtI
> dz6wcEMGT++ps1nJ7SdgtVY=
> =5ZVu
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

