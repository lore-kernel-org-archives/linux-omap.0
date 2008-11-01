From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Sat, 1 Nov 2008 04:31:51 +0200
Message-ID: <20081101023151.GK32518@frodo>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <200810310300.24515.david-b@pacbell.net> <5e088bd90810311635p26bdd8b9n3e7429bac29bd82c@mail.gmail.com> <200810311736.45168.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50306 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbYKACb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 22:31:59 -0400
Content-Disposition: inline
In-Reply-To: <200810311736.45168.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Oct 31, 2008 at 05:36:44PM -0700, David Brownell wrote:
> On Friday 31 October 2008, Steve Sakoman wrote:
> > TI claims that the 1.0.2 release of the 35XX EVM software will supp=
ort
> > the libertas_sdio driver via the EVM's mmc slot. =A0However, I don'=
t see
> > that version of the software yet on the TI site, and my guess is th=
at
> > it will be using the internal TI kernel and not linux-omap.
>=20
> Darn...
>=20
> So while Tony's updates will enable root-on-MMC (vs just ramfs)
> Overo won't yet have network links except over bluetooth.
>=20
> Until the twl4030 USB transceiver driver goes to mainline,
> at which point usb network links will work.  :)

about that, I'm hacking on it starting next week. Finaly sorted out a
few other stuff I had to do internally and now i'll try to add proper i=
d
pin handling and finish that patch of yours ruling out the
otg_transceiver from struct musb (using only a pointer).

That will take a while since I'll have to make
otg_{set,get}_transceiver() generic (again), clean musb driver
(otg_transceiver crap) and then fix twl4030-usb. Hopefully i'll get it
done by 2.6.29 merge window, not sure though.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
