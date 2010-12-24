From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Issue : jffs2 and ecc layout
Date: Fri, 24 Dec 2010 22:40:40 +0800
Message-ID: <AANLkTiky0G_H9vGDRNj-y=JTcfCcvRgfXraa0SbAZM4t@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com>
	<AANLkTimJFsjLT15FA+TqDKzjvPXgxUAvovWpWKP3NCK4@mail.gmail.com>
	<201012241602.36582.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51405 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab0LXOkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Dec 2010 09:40:43 -0500
Received: by wwa36 with SMTP id 36so7425539wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Dec 2010 06:40:42 -0800 (PST)
In-Reply-To: <201012241602.36582.manningc2@actrix.gen.nz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

2010/12/24 Charles Manning <manningc2@actrix.gen.nz>:

> THis might be due to the way the omap2.c driver is now screwed up so that it
> does not read when not u32 aligned.
>
> Try this:
> http://www.spinics.net/linux/lists/linux-omap/msg42422.html
>
> Please report back if that fixes the problem for you.

The patch is still a good catch, with it, the following error
message does disappear:

[  299.433197] uncorrectable error :
[  299.436737] uncorrectable error :
[  299.440338] mtd->read(0x530 bytes from 0xf9202d0) returned ECC error
[  299.447875] uncorrectable error :
[  299.451263] uncorrectable error :
[  299.454833] mtd->read(0x44 bytes from 0xf927efc) returned ECC error
[  299.461822] uncorrectable error :
[  299.465240] uncorrectable error :
[  299.468780] uncorrectable error :
[  299.472534] mtd->read(0x5a4 bytes from 0xf940d84) returned ECC error

If not applying this patch, even Jason's patch is reverted, the error message
above will be printed out very frequently during 'mount'.

thanks,
-- 
Lei Ming
