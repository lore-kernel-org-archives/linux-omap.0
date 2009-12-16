From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: U boot flash to SD Card
Date: Wed, 16 Dec 2009 10:23:27 +0530
Message-ID: <d6a0f7aa0912152053s41afc7a9nd90d1a066d9bf8ee@mail.gmail.com>
References: <4ad3b6300912152038h59852b57wd17f4d513cc2d4a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:64352 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbZLPEx2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 23:53:28 -0500
Received: by qyk30 with SMTP id 30so316514qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 20:53:27 -0800 (PST)
In-Reply-To: <4ad3b6300912152038h59852b57wd17f4d513cc2d4a4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Niamathullah sharief <omapsha@gmail.com>
Cc: linux-omap@vger.kernel.org

you need copy MLO[x-loader], u-boot and uImage to first partition.

You can refer to:

http://elinux.org/BeagleBoard#MMC.2FSD_boot

---
Regards,
Govindraj.R


On Wed, Dec 16, 2009 at 10:08 AM, Niamathullah sharief
<omapsha@gmail.com> wrote:
> Hello,
> I am using ARM based board. I want to boot the kernel from SD Card.
> For that i have to install the u boot bootloader into SD card. how to
> install u boot from host computer? i have partitioned my SD card into
> 3. i have to install u boot in first partition. So please kindly help
> me.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
