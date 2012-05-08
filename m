From: Tony Lindgren <tony@atomide.com>
Subject: Re: Broken UART I/O wakeups on v3.4-rc4+
Date: Tue, 8 May 2012 13:12:03 -0700
Message-ID: <20120508201203.GE5088@atomide.com>
References: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40866 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab2EHUMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 16:12:06 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, khilman@ti.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org

* Raja, Govindraj <govindraj.raja@ti.com> [120508 02:17]:
> On Tue, May 8, 2012 at 10:35 AM, Paul Walmsley <paul@pwsan.com> wrote=
:
> >
> > Govindraj,
> >
> > After your commit bce492c04ba8fc66a4ea0a52b181ba255daaaf54 ("ARM: O=
MAP2+:
> > UART: Fix incorrect population of default uart pads"), the kernel d=
oes not
> > return from static suspend when off-mode is enabled upon an incomin=
g
> > serial character.
> >
> > The following steps reproduce the problem:
> >
> > echo 1 > /debug/pm_debug/enable_off_mode
> > echo mem > /sys/power/state
> > (send a serial character after suspend is entered)
> >
> > (N.B., on the BeagleBoard, the GPIO-connected "USER" button can be =
used to
> > wake the system at this point.)
> >
>=20
> The same is discussed in this thread as in here:
> http://www.spinics.net/lists/linux-omap/msg68659.html
>=20
> > Could you please fix this? =C2=A0We probably aren't too far from th=
e v3.5 merge
> > window opening, so there isn't much time to fix it.
>=20
> okay, one possible solution is to probe pins dynamically
> and make rx wakeup capable which myself and Tony
> discussed and came up with this patch [1]

This would be good for the v3.5 merge window.
=20
> or to add rx wakeup pad support for each board,
> based on uart used as console.

This should be still done too to avoid bootloader dependency
for setting up the serial ports.

Regards,

Tony
=20
> [1]: http://www.spinics.net/lists/linux-omap/msg67822.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
