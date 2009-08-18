From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: SDP support seems broken in LO
Date: Tue, 18 Aug 2009 18:28:14 +0530
Message-ID: <ce9ab5790908180558m184fd48euece1093575160c0c@mail.gmail.com>
References: <ce9ab5790908180519t644723cbw6876901066f1f213@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B9DCC60E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:37981 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758810AbZHRM6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 08:58:35 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1215021qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 05:58:36 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B9DCC60E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 18, 2009 at 5:53 PM, Shilimkar,
Santosh<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of vimal singh
>> Sent: Tuesday, August 18, 2009 5:49 PM
>> To: linux-omap@vger.kernel.org
>> Subject: SDP support seems broken in LO
>>
>> LO seems broken on OMAP3430 SDP platform. I compile latest kernel wi=
th
>> 'omap_3430sdp_defconfig' config options.
>>
>> Booting hangs after kernel uncompressed and last message which appea=
rs
>> is 'booting the kernel'
>>
>>
>> Thanks and regards,
>> vimal
>>
>> See below log:
>>
>> ## Booting image at 80000000 ...
>> =A0 =A0Image Name: =A0 Linux-2.6.31-rc5-omap1-05896-ge0
>> =A0 =A0Image Type: =A0 ARM Linux Kernel Image (uncompressed)
>> =A0 =A0Data Size: =A0 =A02520992 Bytes =3D =A02.4 MB
>> =A0 =A0Load Address: 80008000
>> =A0 =A0Entry Point: =A080008000
>> =A0 =A0Verifying Checksum ... OK
>> OK
>>
>> Starting kernel ...
>>
>> Uncompressing
>> Linux...............................................................=
=2E.....
>> ....................................................................=
=2E.....
>> ..................
>> done, booting the kernel.
> Mainly because of frame-buffer and musb. You can try disabling these =
two and see if it boots.

I disabled frame-buffer and usb support fully:
# CONFIG_FB is not set
# CONFIG_USB_SUPPORT is not set

I still get same message.

-vimal

>
>
> Regards,
> Santosh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
