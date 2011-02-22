From: Felipe Balbi <balbi@ti.com>
Subject: Re: Nokia CBUS code
Date: Tue, 22 Feb 2011 13:18:32 +0200
Message-ID: <20110222111832.GN2979@legolas.emea.dhcp.ti.com>
References: <1298371692.6998.19.camel@maggie>
 <20110222110512.GM2979@legolas.emea.dhcp.ti.com>
 <1298373127.6998.25.camel@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36654 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575Ab1BVLSh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 06:18:37 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so2165897bwz.33
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 03:18:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298373127.6998.25.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Cc: balbi@ti.com, linux-omap <linux-omap@vger.kernel.org>

On Tue, Feb 22, 2011 at 12:12:07PM +0100, Michael B=FCsch wrote:
> On Tue, 2011-02-22 at 13:05 +0200, Felipe Balbi wrote:=20
> > > That probably is a major effort, as it needs a rewrite in some pa=
rts,
> > > but I'm certainly interested in getting it mainlined, because I'm
> > > currently developing a driver on top of it.
> >=20
> > We're almost there actually. Retu is in great shape and tahvo is a =
lot
> > simpler, but it still needs help. Probably porting the changes I ma=
de on
> > retu would be the way to go.
>=20
> Ok, that's pretty cool. I'll try to port this to OpenWRT, soon,
> to check how it works.
>=20
>=20
> On another issue: Did you try tahvo-usb recently?

Nope :-(

> I was trying it with the OpenWRT cbus codebase (which is some months
> old) and I couldn't get it to work. It would always crash with
> some weird NULL pointer accesses and stuff like this. I was wondering
> if the omap-tree tahvo code would actually work on the USB device.

It's been a long time since I tested that part of the code. My n810
actually died :-( so Tony has been testing my patches.

But hey, if you get a NULL pointer with linux-omap's code, then please
let us know about it. Give us whatever information you can give us and
we will work together on fixing it ;-)

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
