From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Sat, 29 Nov 2014 00:54:39 +0200
Message-ID: <20141128225439.GC1382@fuloong-minipc.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
 <201411282241.12095@pali>
 <20141128224134.GB1382@fuloong-minipc.musicnaut.iki.fi>
 <201411282349.00487@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:43470 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaK1Wys (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 17:54:48 -0500
Content-Disposition: inline
In-Reply-To: <201411282349.00487@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 11:49:00PM +0100, Pali Roh=E1r wrote:
> On Friday 28 November 2014 23:41:35 Aaro Koskinen wrote:
> > On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh=E1r wrote:
> > > uboot (in mode when is loaded from NOLO) has those issues:
> > >=20
> > > 1) uboot cannot read n900 onenand mtd (uboot onenand driver
> > > not working, do not know why)
> > > 2) missing support for battery charging (can totally
> > > discharge battery)
> >=20
> > NOLO enables watchdogs when booting. So if you get stuck in
> > the U-boot for whatever reason the device will power off
> > after ~30 secs or so.
>=20
> Not truth!
>=20
> Uboot RX51 code periodically kick watchdogs if are enabled. I=20
> implemented that before RX51 uboot was merged into mainline.

Maybe then it shouldn't do that.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
