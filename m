From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Sat, 30 Nov 2013 19:45:05 -0300
Message-ID: <20131130224504.GA2446@localhost>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131120220212.GA12776@localhost>
 <528DC168.7090204@linutronix.de>
 <20131121113025.GA2942@localhost>
 <528DF233.40502@linutronix.de>
 <20131121115519.GC2942@localhost>
 <20131121130155.GC24559@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46888 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159Ab3K3WpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Nov 2013 17:45:07 -0500
Content-Disposition: inline
In-Reply-To: <20131121130155.GC24559@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roger Quadros <rogerq@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Thu, Nov 21, 2013 at 07:01:55AM -0600, Felipe Balbi wrote:
> On Thu, Nov 21, 2013 at 08:55:20AM -0300, Ezequiel Garcia wrote:
> > On Thu, Nov 21, 2013 at 12:44:51PM +0100, Sebastian Andrzej Siewior=
 wrote:
> > > On 11/21/2013 12:30 PM, Ezequiel Garcia wrote:
> > > > Ah, good to know. That patch should be picked ASAP, without it =
the USB
> > > > in AM335x is broken. Is it already too late to -rc1?
> > > Yes.
> > >=20
> > > > Who is supposed to merge that? Greg?
> > >=20
> > > Felipe will start collecting fixes once -rc1 is out [0] so it sho=
uld be
> > > part of -rc2.
> > >=20
> >=20
> > OK, fine by me. Please note that Felipe's commit is a much bigger (=
and
> > nicer) rework of the code, and that it doesn't clearly state it fix=
es
> > the current code.
> >=20
> > Felipe: Maybe you should add some message stating it fixes a regres=
sion?
>=20
> sure, makes sense. Sebastian had already mentioned it sounded too nic=
e
> of a commit log ;-)
>=20

I'm looking at -rc2 and it seems the fix was never pushed, so my board
is probably still broken :-(

Can anybody _please_please_ fix the issue by merging some fix so we can
use USB with mainline?

(FWIW, the fix from Felipe (pointed out by Sebastian) is sitting at
linux-next).

Thanks a lot!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
