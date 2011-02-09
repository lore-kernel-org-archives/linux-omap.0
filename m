From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] OMAP4: PandaBoard: Adding DVI support
Date: Wed, 9 Feb 2011 13:07:21 -0600
Message-ID: <AANLkTi=h8oyJGcBAXercT9OeKae9PiDhu_ta+7EAC++J@mail.gmail.com>
References: <1297259727-19690-1-git-send-email-raghuveer.murthy@ti.com>
	<AANLkTimwCDYGfeXc=mW-1wyvSj+OGHd_fJMB7Grh60ih@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47792 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1BITHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 14:07:24 -0500
Received: by eye27 with SMTP id 27so358201eye.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 11:07:22 -0800 (PST)
In-Reply-To: <AANLkTimwCDYGfeXc=mW-1wyvSj+OGHd_fJMB7Grh60ih@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Raghuveer Murthy <raghuveer.murthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 9, 2011 at 8:08 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> On Wed, Feb 9, 2011 at 7:25 PM, Raghuveer Murthy
> <raghuveer.murthy@ti.com> wrote:
>> Adding DVI support to OMAP4 PandaBoard.
>>
>> PandaBoard uses TFP410 DVI Framer chip
>> http://focus.ti.com/lit/ds/symlink/tfp410.pdf
>>
>> The TFP410 gets its power enable and display data over GPIO lines muxed
>> in from OMAP4430. PandaBoard supports other LCD displays through expansion
>> connectors, following board rework. This will disable the DVI interface.
>> However, the existing mux settings remain the same
>>
>> PandaBoard additionally supports display over HDMI interface. It is
>> mutually exclusive to display over DVI. Hence the mux settings need to be
>> configured seperately, as and when HDMI is enabled
>>
>> Also, I2C3 bus used for reading EDID data from DVI Monitors is
>> registered here. Since the design is similar to BeagleBoard, the code
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
>> ====
>> url =
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

These work great on my Panda A1, (mainline 2.6.38-rc4 base) haven't
seen any regressions on my Beagle C4 with the same patchset/image..

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
