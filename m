From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 10:47:10 +0100
Message-ID: <CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:47564 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab3LEJrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 04:47:13 -0500
Received: by mail-wi0-f177.google.com with SMTP id cc10so9518312wib.4
        for <linux-omap@vger.kernel.org>; Thu, 05 Dec 2013 01:47:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-mtd@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Peter,

2013/12/5 Peter Meerwald <pmeerw@pmeerw.net>:
> Hello,
>
> on OMAP3, the NAND area holding MLO and u-boot need a different ECC scheme
> (hw) than the rootfs (sw)
>

There is some discussion around this, please take a look at this thread,

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg98969.html

> is there a way to tell the kernel which ECC scheme to use on a
> per-partition basis?
>

At this moment this is not possible.

> I'd like to be able to update MLO and u-boot from within a booted Linux
> system on the device (I have to resort to u-boot for that where I can
> control the ECC scheme used)
>

Meanwhile, to do this we use a small userspace program created by
Javier Martinez in order to flash the MLO in our OMAP3 boards. See

http://git.isee.biz/?p=pub/scm/writeloader.git;a=summary

Hope it helps you. Regards,
   Enric

> thanks, regards, p.
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
