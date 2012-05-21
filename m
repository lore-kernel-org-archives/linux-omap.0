From: Tony Lindgren <tony@atomide.com>
Subject: Re: rx51: support for lis3lv02d accelerometer
Date: Mon, 21 May 2012 09:08:40 -0700
Message-ID: <20120521160840.GK17852@atomide.com>
References: <1621273.5PNGJFOirm@pali>
 <20120509000734.GZ5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15261 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab2EUQIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 12:08:43 -0400
Content-Disposition: inline
In-Reply-To: <20120509000734.GZ5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lauri Leukkunen <lauri.leukkunen@nokia.com>, Sebastian Reichel <sre@debian.org>, Felipe Contreras <felipe.contreras@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

Hi Pali,

* Tony Lindgren <tony@atomide.com> [120508 17:12]:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [120504 08:41]:
> > Hi!
> >=20
> > Upstream linux kernel has already driver for lis3lv02d acceleromete=
r
> > in drivers/misc/lis3lv02d. So now can be added also platform suppor=
t
> > for nokia rx51. Patch exists for long time in meego obs repository:
> > https://build.pub.meego.com/package/view_file?file=3Dlinux-2.6-omap=
-rx51-Platform-support-for-lis3lv02d-acceleromet.patch&package=3Dkernel=
-adaptation-n900&project=3DCE%3AAdaptation%3AN900
> >=20
> > It is possible to include this patch to upstream kernel?
>=20
> Thanks, applying into board branch with From: Ameya as in the
> link above.

Just noticed that this one is still using OMAP_GPIO_IRQ that
won't work any longer. Can you please send a fix on top of this
patch against linux next to fix it?

The fix is to use gpio_to_irq() in the related init function
instead of static OMAP_GPIO_IRQ in the data structure.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
