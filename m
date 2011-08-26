From: "Maupin, Chase" <chase.maupin@ti.com>
Subject: RE: 3.1-rc3 fails to boot on my pandaboard
Date: Fri, 26 Aug 2011 19:05:39 +0000
Message-ID: <7D46E86EC0A8354091174257B2FED1010346F40B@DLEE12.ent.ti.com>
References: <1314268769.2296.283.camel@cumari>
 <CAAL8m4whQJSXQw+E52qF2vLSBrt=RsA-r-B2q2gaW3XGiR4tYg@mail.gmail.com>
 <1314272358.2296.296.camel@cumari>
 <CAAL8m4x18v+QWFHsxhYDGRq3WmzmA+Ur7JGRrTabHrKDuvAjvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab1HZTFv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 15:05:51 -0400
In-Reply-To: <CAAL8m4x18v+QWFHsxhYDGRq3WmzmA+Ur7JGRrTabHrKDuvAjvw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>, "Coelho, Luciano" <coelho@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Govindraj
> Sent: Thursday, August 25, 2011 6:46 AM
> To: Coelho, Luciano
> Cc: linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org; Thomas
> Gleixner; Sebastian Andrzej Siewior
> Subject: Re: 3.1-rc3 fails to boot on my pandaboard
>=20
> On Thu, Aug 25, 2011 at 5:09 PM, Luciano Coelho <coelho@ti.com> wrote=
:
> > On Thu, 2011-08-25 at 17:05 +0530, Govindraj wrote:
> >> On Thu, Aug 25, 2011 at 4:09 PM, Luciano Coelho <coelho@ti.com>
> wrote:
> >> > Hi,
> >> >
> >> > There seems to be a problem with 3.1-rc3, which prevents it from
> booting
> >> > on my PandaBoard (ARM OMAP4).
> >> >
> >> > 3.1-rc2 works fine, so I have bisected the problem and it turns
> out to
> >> > be caused by this:
> >> >
> >> > commit f3637a5f2e2eb391ff5757bc83fb5de8f9726464
> >> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> > Date: =A0 Thu Jul 7 22:32:17 2011 +0200
> >> >
> >> > =A0 =A0irq: Always set IRQF_ONESHOT if no primary handler is spe=
cified
> >> >
> >> > After reverting this commit, -rc3 boots fine. =A0I'm not sure wh=
ere
> >> > exactly the problem is. =A0Maybe it's something in the omap code
> which is
> >> > broken and this patch causes the bug to show up?
> >> >
> >> > What happens is that the booting process hangs after printing ou=
t
> this:
> >> >
> >>
> >> fyi,
> >>
> >> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-
> 2.6.git;a=3Dcommitdiff;h=3D69dd3d8e29e294caaf63eb5e8a72d250279f9e5f;h=
p=3Dfcb8
> ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c
> >
> > Ah, thanks. =A0Now I see where the irq =3D=3D 74 comes from. :) Sti=
ll, I
> don't
> > see that on my system.
> >

=46YI, I also saw this same issue on an AM37x-evm and beagleboard.  Rev=
erting the above commit works for me to be able to see the boot message=
s from the file system after the kernel boots.

>=20
> 69dd3d8 Revert "irq: Always set IRQF_ONESHOT if no primary handler is
> specified"
> f2b6071 drm/radeon: Extended DDC Probing for Toshiba L300D Radeon
> Mobility X1100 HDMI-A Connector
> c87019e HID: wiimote: Add status and return request handlers
> 2cb5e4b HID: wiimote: Add drm request
> 23a5a4a HID: wiimote: Register led class devices
> 26af174 HID: wiimote: Correctly call HID open/close callbacks
> 3989ef6 HID: wiimote: Simplify synchronization
> 8d3bb23 drm/ttm: ensure ttm for new node is bound before calling
> move_notify()
> eac2095 drm/ttm: unbind ttm before destroying node in accel move
> cleanup
> 7c4c396 drm/ttm: fix ttm_bo_add_ttm(user) failure path
> f5e4282 HID: usbhid: Add support for SiGma Micro chip
> 11f3a6b bridge: fix a possible net_device leak
> b6bede3 xfs: fix tracing builds inside the source tree
> 832d80a Merge branch 'for-davem' of
> git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless
> fcb8ce5 Linux 3.1-rc3
>=20
>=20
> --
> Thanks,
> Govindraj.R
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
