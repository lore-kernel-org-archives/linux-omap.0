From: Felipe Balbi <balbi@ti.com>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Tue, 1 Mar 2011 16:39:15 +0200
Message-ID: <20110301143915.GD12368@legolas.emea.dhcp.ti.com>
References: <1298925943.16391.19.camel@marge>
 <20110301092057.GA2942@legolas.emea.dhcp.ti.com>
 <1298989395.6461.2.camel@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44461 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756500Ab1CAOjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 09:39:19 -0500
Received: by mail-bw0-f44.google.com with SMTP id 13so5351971bwz.31
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 06:39:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298989395.6461.2.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Cc: balbi@ti.com, linux-omap <linux-omap@vger.kernel.org>, Varadarajan Charulatha <charu@ti.com>, Kai Svahn <kai.svahn@nokia.com>

On Tue, Mar 01, 2011 at 03:23:15PM +0100, Michael B=FCsch wrote:
> On Tue, 2011-03-01 at 11:20 +0200, Felipe Balbi wrote:=20
> > On Mon, Feb 28, 2011 at 09:45:43PM +0100, Michael Buesch wrote:
> > > The n810 LCD does not work on the 2.6.38(-rc6) kernel
> > > due to changes in the OMAP GPIO-hwmod code.
> > >=20
> > > The hwmod code performs a soft-reset on the GPIO
> > > module. The first GPIO module carries the MIPID
> > > "nreset" line, which is toggled due to the hwmod soft reset.
> > > This resets Blizzard and breaks it, because
> > > it assumes the LCD was left in the state that the
> > > bootloader initialized it to:
> >=20
> > so that's the bug which needs to be fixed. Unfortunately I don't ha=
ve
> > any documentation available anymore. Maybe someone from Nokia would=
 fix
> > that ?
> >=20
> > > I'm wondering if a better fix suitable for the mainline
> > > kernel inclusion could be found.
> > > Any ideas?
> >=20
> > Don't depend on the bootloader :-)
>=20
> Yeah that's the obvious fix, of course. However, it requires
> deep knowledge of the device and/or hardware documentation. Both
> of which I don't have.
> The driver also doesn't seem to have a maintainer.
>=20
> If someone can get me documentation, I'm willing to implement
> the required bits to remove the bootloader dependency.

Someone from Nokia might be able to help. Kai ??

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
