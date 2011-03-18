From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri, 18 Mar 2011 11:22:30 +0530
Message-ID: <22f62225a07b2c01dd21011588b8824c@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>
 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>
 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>
 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
 <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv>
 <1300258302.1917.32.camel@lappyti> <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>
 <4D814C72.9010300@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35316 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742Ab1CRGDF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Mar 2011 02:03:05 -0400
Received: by fxm17 with SMTP id 17so3388681fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 23:03:02 -0700 (PDT)
In-Reply-To: <4D814C72.9010300@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>, Mythri P K <mythripk@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

> i tried this test tree with omap2plus_defconfig.
>
> it seems the kernel crashes and poweroff the board on loading
> this hdmi stuff, but dont print any crashlog. is there a
> way any backtraces will be printed?
> output from serial console: http://paste.pocoo.org/show/354850/
> kernel config (omap2plus_defconfig, added squashfs support, added
> support to include initramfs in kernel, build omapfb stuff statically
> into the kernel): http://paste.pocoo.org/show/354853/
>
> i am using a own toolchain to crosscompile with gcc-4.5.2,
> binutils-2.21...

Just a hunch, but could you please turn off CONFIG_OMAP2_DSS_SDI
and try again?

- Anand
