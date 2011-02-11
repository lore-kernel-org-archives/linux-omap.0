From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] OMAP4: PandaBoard: Adding DVI support
Date: Fri, 11 Feb 2011 20:12:11 +0800
Message-ID: <AANLkTimQxC3HgaRs-bBOGChLhvAK69XHCPEGyOcKeOz6@mail.gmail.com>
References: <1297259727-19690-1-git-send-email-raghuveer.murthy@ti.com> <AANLkTimwCDYGfeXc=mW-1wyvSj+OGHd_fJMB7Grh60ih@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34217 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab1BKMMh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 07:12:37 -0500
Received: by yxt3 with SMTP id 3so1034805yxt.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 04:12:36 -0800 (PST)
In-Reply-To: <AANLkTimwCDYGfeXc=mW-1wyvSj+OGHd_fJMB7Grh60ih@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "Jan, Sebastien" <s-jan@ti.com>, robertcnelson@gmail.com
Cc: Raghuveer Murthy <raghuveer.murthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 9, 2011 at 10:08 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> On Wed, Feb 9, 2011 at 7:25 PM, Raghuveer Murthy
> <raghuveer.murthy@ti.com> wrote:
>> Adding DVI support to OMAP4 PandaBoard.
>>
>> PandaBoard uses TFP410 DVI Framer chip
>> http://focus.ti.com/lit/ds/symlink/tfp410.pdf
>>
>> The TFP410 gets its power enable and display data over GPIO lines mu=
xed
>> in from OMAP4430. PandaBoard supports other LCD displays through exp=
ansion
>> connectors, following board rework. This will disable the DVI interf=
ace.
>> However, the existing mux settings remain the same
>>
>> PandaBoard additionally supports display over HDMI interface. It is
>> mutually exclusive to display over DVI. Hence the mux settings need =
to be
>> configured seperately, as and when HDMI is enabled
>>
>> Also, I2C3 bus used for reading EDID data from DVI Monitors is
>> registered here. Since the design is similar to BeagleBoard, the cod=
e
>> for the same is taken from the kernel.org commit e3333f48dd5cb21
>> (omap: Adding beagle i2c eeprom driver to read EDID)
>>
>> Reviewed-by: Manjunath G Kondaiah <manjugk@ti.com>
>> Reviewed-by: Anand Gadiyar <gadiyar@ti.com>
>
> I've also tested it on the Panda, and gone through this and most
> of the other patches in the series. So if you like, you could
> consider this an:
>
> Acked-by: Anand Gadiyar <gadiyar@ti.com>
>
>> Reviewed-by: Nishanth Menon <nm@ti.com>
>> Reviewed-by: Sumit Semwal <sumit.semwal@ti.com>
>> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
>> ---
>>
>> Base
>> =3D=3D=3D=3D
>> url =3D
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> branch "master"
>> commit 100b33c8bd8a3235fd0b7948338d6cbb3db3c63d
>> tag 2.6.38-rc4
>>
>
> To make it easier for someone to test, I've extracted this
> and the 6 dependent series from patchwork, and hosted
> them in a branch on my devel tree. They are available
> against v2.6.38-rc4 here:
>
> git://dev.omapzoom.org/pub/scm/anand/linux-omap-usb.git
>
> in the display-patches-for-v2.6.38-rc4 branch if someone
> wants to take a look.

I fetched this branch which contains 35 patches on top of 2.6.38-rc4.
After fixing some conflict, I applied these 35 patches on our Ubuntu
ti-omap-dev kernel. With built-in the DSS2 driver and GENERIC_DPI
driver, kernel boots fine on my Panda with Ubuntu GUI. But I have to
set the kernel boot command args with omapfb.mode=3Ddvi:1024x768MR-24@6=
0
omapdss.def_disp=3Ddvi, pointed out by Sebastien. Without this bootargs=
,
no graphic at all. so as Robert concerned, EDID detection doesn't
work. Does that related to I2C driver? I2C driver always tell me
timeout in dmesg.

Thanks a lot,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
