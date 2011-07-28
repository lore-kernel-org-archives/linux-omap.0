From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [Q] No message from Kernel (Howto start debug?)
Date: Thu, 28 Jul 2011 20:26:10 +0530
Message-ID: <5d52501338122438f9712b01f5b6de81@mail.gmail.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41263 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754524Ab1G1O4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 10:56:14 -0400
Received: by wwe6 with SMTP id 6so2374627wwe.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 07:56:12 -0700 (PDT)
In-Reply-To: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>, linux-omap@vger.kernel.org

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Arno Steffen
>Sent: Thursday, July 28, 2011 6:45 PM
>To: linux-omap@vger.kernel.org
>Subject: [Q] No message from Kernel (Howto start debug?)
>
>Maybe you are so kind to give me a hint:
>
>Try to migrate from Kernel 33 to 37. Currently I don't see any message
>after
>
>  Verifying Checksum ... OK
>   Loading Kernel Image ... OK
>OK
>
>Starting kernel ...
>
 If you are stuck with Starting kernel ... and do not see
   "Uncompressing Linux... done, booting the kernel" means could have
crashed before your kernel in case of uImage.
 Check the arch_id that you are passing from the bootloader.

Also enable early printk.

>From what I understand kernel starts with start_kernel()).
>What is best way to find out which part is failing? At which point I
>do a printk to see what's going on, or at least set a GPIO Pin of the
>processor?
>How to debug without any external tools like JTAG.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
 Sricharan
