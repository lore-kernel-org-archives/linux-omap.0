From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant
 code from DSS.
Date: Fri, 01 Jul 2011 14:44:37 +0300
Message-ID: <1309520677.1821.43.camel@deskari>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
	 <1308823101.1834.79.camel@deskari>
	 <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
	 <1308832274.1834.109.camel@deskari>
	 <BANLkTik1TYgaGBYKqYxih1RjPKn8nU_cAA@mail.gmail.com>
	 <1309179518.1813.38.camel@lappyti>
	 <BANLkTi=VAaTf7SwXJikHAJGmxJLmbg84Dw@mail.gmail.com>
	 <1309364515.20494.20.camel@deskari>
	 <BANLkTi=XUVEXxw7Ag23BEBw8zHY6J+c9OQ@mail.gmail.com>
	 <1309510269.1821.18.camel@deskari>
	 <BANLkTik+0P1ycGpS-xU1Utu2Zfzk17ZkWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46283 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755255Ab1GALol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 07:44:41 -0400
Received: by mail-bw0-f54.google.com with SMTP id 20so5317921bwa.27
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 04:44:40 -0700 (PDT)
In-Reply-To: <BANLkTik+0P1ycGpS-xU1Utu2Zfzk17ZkWA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-07-01 at 14:52 +0530, K, Mythri P wrote:

> > I don't see a need for a separate file right now. We have the
> > hdmi_ti_4xxx_ip.c file which contains code for the HDMI block as a
> > whole, and could well contain the code that implements the API.
> >
> if the hdmi_ti_4xxx_ip.c  is handling the configuration then how are
> we going to handle a scenario where netra uses a different PHY block ,

I wasn't aware that Netra has different HDMI blocks. I understood it's
the same as on OMAP4.

So they have a different PHY driver, but want to use PLL and core parts
of OMAP4 HDMI driver?

> you suggest to have a #if in the programming sequence within
> hdmi_ti_4xxx_ip.c function ?

No, we can't use #ifdefs as the same kernel has to work for both SoCs.

> Also in future OMAP's when are using the PHY and PLL block from
> hdmi_ti_4xxx_ip.c , but a different core/video block from
> hdmi_ti_5xxx_ip.c then how  would hdmi_ti_5xxx_ip.c hdmi_enable be
> able to call the PHY and PLL configuration functions  from
> hdmi_ti_4xxx_ip.c ??

If the different HDMI blocks will be mixed like that, then we need to
split the blocks to separate files. Otherwise it will get strange if
OMAP5 HDMI code is calling PLL functions from OMAP4 HDMI code.

And on top of those drivers/libs we would have a higher level driver/lib
for the whole HDMI entity, and this higher level driver would implement
the API being discussed. It would then use the lower level drivers/libs,
and be used by OMAP/Netra DSS.

 Tomi


