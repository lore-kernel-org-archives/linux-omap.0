From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Fri, 6 Dec 2013 19:03:33 -0300
Message-ID: <20131206220332.GA2458@localhost>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131120220212.GA12776@localhost>
 <528DC168.7090204@linutronix.de>
 <20131121113025.GA2942@localhost>
 <528DF233.40502@linutronix.de>
 <20131121115519.GC2942@localhost>
 <20131121130155.GC24559@saruman.home>
 <20131130224504.GA2446@localhost>
 <20131206201623.GB21086@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55623 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161289Ab3LFWDY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 17:03:24 -0500
Content-Disposition: inline
In-Reply-To: <20131206201623.GB21086@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roger Quadros <rogerq@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Fri, Dec 06, 2013 at 02:16:23PM -0600, Felipe Balbi wrote:
> On Sat, Nov 30, 2013 at 07:45:05PM -0300, Ezequiel Garcia wrote:
> > On Thu, Nov 21, 2013 at 07:01:55AM -0600, Felipe Balbi wrote:
> > > On Thu, Nov 21, 2013 at 08:55:20AM -0300, Ezequiel Garcia wrote:
> > > > On Thu, Nov 21, 2013 at 12:44:51PM +0100, Sebastian Andrzej Sie=
wior wrote:
> > > > > On 11/21/2013 12:30 PM, Ezequiel Garcia wrote:
> > > > > > Ah, good to know. That patch should be picked ASAP, without=
 it the USB
> > > > > > in AM335x is broken. Is it already too late to -rc1?
> > > > > Yes.
> > > > >=20
> > > > > > Who is supposed to merge that? Greg?
> > > > >=20
> > > > > Felipe will start collecting fixes once -rc1 is out [0] so it=
 should be
> > > > > part of -rc2.
> > > > >=20
> > > >=20
> > > > OK, fine by me. Please note that Felipe's commit is a much bigg=
er (and
> > > > nicer) rework of the code, and that it doesn't clearly state it=
 fixes
> > > > the current code.
> > > >=20
> > > > Felipe: Maybe you should add some message stating it fixes a re=
gression?
> > >=20
> > > sure, makes sense. Sebastian had already mentioned it sounded too=
 nice
> > > of a commit log ;-)
> > >=20
> >=20
> > I'm looking at -rc2 and it seems the fix was never pushed, so my bo=
ard
> > is probably still broken :-(
> >=20
> > Can anybody _please_please_ fix the issue by merging some fix so we=
 can
> > use USB with mainline?
>=20
> it's in Greg's tree
>=20

Yeah, I just saw the pull. Thanks for the notice! I'll re-test in -rc4
and let you know if I find any more problems.

=46WIW, I'm not entirely happy with the solution. Probably being a bit
paranoid, but it seemed to me the fix could be smaller (and fix only
the problem) and then pospone your refactoring until v3.14.

Just my two cents and thanks again for the notice.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
