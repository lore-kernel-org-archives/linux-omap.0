From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: musb_hdrc: usb_disconnect is not called when the USB device is
	disconnected.
Date: Wed, 14 Jul 2010 16:54:27 +0200
Message-ID: <AANLkTik4eaJJ1j8LQYJ9FzkHrRFpPLdD0SEQ8wDqoNe-@mail.gmail.com>
References: <AANLkTik34PBAF9TRK1KRy0D6xb_vdR4hCPRXGUDt1f9v@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323A2C0E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59992 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab0GNOy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jul 2010 10:54:28 -0400
Received: by pwi5 with SMTP id 5so2780132pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Jul 2010 07:54:27 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C0E3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

2010/7/14 Gadiyar, Anand <gadiyar@ti.com>:
> Enric Balletb=C3=B2 i Serra
>> Hello,
>>
>> When I disconnect an USB pendrive using twl4030 otg as host (step 2)
>> the usb_disconnect function is not called. OTOH if I reconnect the
>> device (step 3), then the usb_disconnect function is called.
>>
>> Does anyone have any ideas why usb_disconnect is not called when the
>> device is removed?
>>
>
> Which kernel version is this? Can you check if this patch fixes the b=
ehavior?
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D7d9645fdca444d53907b22a4b73e3967efe09781

I'm using stable kernel 2.6.33.6

And yes this patch is not applied in this version. I applied and
solves the issue. Thank you very much.

Best regards,
-- Enric

>
> - Anand
>
>
>> Steps to see the feature:
>>
>> Step 1 : Plug a USB pendrive:
>> [ 2116.491546] usb 1-1: new high speed USB device using musb_hdrc an=
d address 6
>> [ 2116.751861] usb 1-1: New USB device found, idVendor=3D058f, idPro=
duct=3D6387
>> [ 2116.758697] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2=
, SerialNumber=3D3
>> [ 2116.765899] usb 1-1: Product: Mass Storage
>> [ 2116.770019] usb 1-1: Manufacturer: 2.0
>> [ 2116.773834] usb 1-1: SerialNumber: A15B7B60
>> [ 2116.786468] scsi4 : usb-storage 1-1:1.0
>> [ 2117.797332] scsi 4:0:0:0: Direct-Access =C2=A0 =C2=A0 2.0 =C2=A0 =
=C2=A0 =C2=A0Flash Disk =C2=A08.07 PQ: 0 ANSI: 2
>> [ 2117.813293] sd 4:0:0:0: [sda] 1968128 512-byte logical blocks: (1=
=2E00 GB/961 MiB)
>> [ 2117.829040] sd 4:0:0:0: [sda] Write Protect is off
>> [ 2117.834014] sd 4:0:0:0: [sda] Mode Sense: 03 00 00 00
>> [ 2117.834014] sd 4:0:0:0: [sda] Assuming drive cache: write through
>> [ 2117.849212] sd 4:0:0:0: [sda] Assuming drive cache: write through
>> [ 2117.856597] =C2=A0sda: sda1
>> [ 2117.965698] sd 4:0:0:0: [sda] Assuming drive cache: write through
>> [ 2117.971954] sd 4:0:0:0: [sda] Attached SCSI removable disk
>> [ 2118.738769] FAT: bogus number of reserved sectors
>> [ 2118.743621] VFS: Can't find a valid FAT filesystem on dev sda.
>>
>> Step 2: Unplug the USB pendrive
>>
>> [ nothing here ]
>>
>> Step 3: Plug the USB pendrive:
>> [ 2218.820556] usb 1-1: USB disconnect, address 6
>> [ 2219.139831] usb 1-1: new high speed USB device using musb_hdrc an=
d address 7
>> [ 2219.400146] usb 1-1: New USB device found, idVendor=3D058f, idPro=
duct=3D6387
>> [ 2219.406951] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2=
, SerialNumber=3D3
>> [ 2219.414184] usb 1-1: Product: Mass Storage
>> [ 2219.418304] usb 1-1: Manufacturer: 2.0
>> [ 2219.422119] usb 1-1: SerialNumber: A15B7B60
>> [ 2219.434875] scsi5 : usb-storage 1-1:1.0
>> [ 2220.445770] scsi 5:0:0:0: Direct-Access =C2=A0 =C2=A0 2.0 =C2=A0 =
=C2=A0 =C2=A0Flash Disk =C2=A08.07 PQ: 0 ANSI: 2
>> [ 2220.461547] sd 5:0:0:0: [sda] 1968128 512-byte logical blocks:(1.=
00 GB/961 MiB)
>> [ 2220.476379] sd 5:0:0:0: [sda] Write Protect is off
>> [ 2220.481323] sd 5:0:0:0: [sda] Mode Sense: 03 00 00 00
>> [ 2220.481323] sd 5:0:0:0: [sda] Assuming drive cache: write through
>> [ 2220.497314] sd 5:0:0:0: [sda] Assuming drive cache: write through
>> [ 2220.504516] =C2=A0sda: sda1
>> [ 2220.603790] sd 5:0:0:0: [sda] Assuming drive cache: write through
>> [ 2220.610015] sd 5:0:0:0: [sda] Attached SCSI removable disk
>> [ 2221.378570] FAT: bogus number of reserved sectors
>> [ 2221.383453] VFS: Can't find a valid FAT filesystem on dev sda.
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
