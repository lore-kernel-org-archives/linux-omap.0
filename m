From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Wed, 16 Mar 2011 16:29:51 +0530
Message-ID: <1300273191.1917.88.camel@lappyti>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
	 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>
	 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>
	 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>
	 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
	 <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv>
	 <1300258302.1917.32.camel@lappyti>
	 <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46924 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab1CPLAH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 07:00:07 -0400
In-Reply-To: <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Stephan Raue <mailinglists@openelec.tv>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-03-16 at 05:53 -0500, K, Mythri P wrote:
> Hi Tomi,
> 
> On Wed, Mar 16, 2011 at 12:21 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> > Anybody else there to test HDMI on Panda and/or Blaze? I pushed the
> > latest DSS + HDMI patches to a test branch for easier testing (I'll push
> > Panda DVI patches there also when I get the new version):
> >
> > git://gitorious.org/linux-omap-dss2/linux.git test
> 
> Stephan,
> It would be great if you could try out with this tree with omap2plus_defconfig.
> Note : Please disable VENC , there is a known issue of kernel crash
> with VENC enabled.

My test branch actually contains a simple hack patch that skips
registering the venc driver on omap4, which should circumvent this
problem.

 Tomi


