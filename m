From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
Date: Fri, 5 Jun 2009 10:45:28 +0200
Message-ID: <20090605104528.7824f137@hskinnemoen-d830>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
	<20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
	<20090605101816.6bbe496e@hskinnemoen-d830>
	<aec7e5c30906050134u1bcfc326p15691d90b6902d68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:53436 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbZFEIpg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 04:45:36 -0400
In-Reply-To: <aec7e5c30906050134u1bcfc326p15691d90b6902d68@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, pavel@ucw.cz, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

Magnus Damm wrote:
> On Fri, Jun 5, 2009 at 5:18 PM, Haavard
> Skinnemoen<haavard.skinnemoen@atmel.com> wrote:
> > Magnus Damm wrote:
> >> +static struct dev_pm_ops dw_dev_pm_ops =3D {
> >> + =C2=A0 =C2=A0 .suspend_noirq =3D dw_suspend_noirq,
> >> + =C2=A0 =C2=A0 .resume_noirq =3D dw_resume_noirq,
> >> +};
> >
> > Can this be const?
>=20
> Hm, adding const generates a warning for me. At on SuperH with
> gcc-4.3.3 (Sourcery G++ Lite 4.3-143):
>=20
> [modified dev_pm_ops to const in sh_keysc.c]
>=20
>   CC      drivers/input/keyboard/sh_keysc.o
> drivers/input/keyboard/sh_keysc.c:299: warning: initialization
> discards qualifiers from pointer target type

Ok, it looks like the .pm field in struct device_driver is not const.
Changing that will introduce lots of warnings elsewhere, so it's
probably better to leave it alone.

So I guess the answer is no, it can't be const.

Haavard
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
