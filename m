From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] OMAP1: I2C: fix device initialization
Date: Mon, 6 Dec 2010 20:34:00 -0800
Message-ID: <AANLkTimm2azv8fJ9W==dF5cV4jqx12As-WL4ffG390h=@mail.gmail.com>
References: <alpine.DEB.2.00.1012062130060.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59925 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab0LGEeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 23:34:21 -0500
Received: by wwa36 with SMTP id 36so13687834wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 20:34:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012062130060.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

On Mon, Dec 6, 2010 at 8:30 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Commit 4d17aeb1c5b2375769446d13012a98e6d265ec13 ("OMAP: I2C: split
> device registration and convert OMAP2+ to omap_device") broke I2C on
> OMAP1. =C2=A0The following messages appear at boot:
>
> i2c_omap i2c_omap.1: failure requesting irq 0
> i2c_omap: probe of i2c_omap.1 failed with error -22
>
> Investigation revealed that a chunk of code is missing from the
> original plat-omap/i2c.c file which configured the IRQ and base addre=
ss
> for the I2C block on OMAP1. =C2=A0Upon adding this back, the OMAP1 I2=
C block
> seems to initialize correctly.
>
> Thanks to Cory Maccarrone <darkstar6262@gmail.com> for reporting the =
bug,
> and apologies for the breakage.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

I tested this on my Herald.  Seems to do the job.

Tested-by: Cory Maccarrone <darkstar6262@gmail.com>

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
