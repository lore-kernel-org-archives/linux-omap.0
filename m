From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM3505/3517 support
Date: Tue, 5 Jul 2011 04:19:52 -0700
Message-ID: <20110705111952.GG5783@atomide.com>
References: <4E121485.6060700@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:36685 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932074Ab1GELTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 07:19:55 -0400
Content-Disposition: inline
In-Reply-To: <4E121485.6060700@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Cc: linux-omap@vger.kernel.org

* Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110704 12:51]:
>=20
> The am3505 is apparently so similar to the 3430 that it was treated a=
s such=20
> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There are howe=
ver a
> few differences that need to be addressed. I have therefore created a=
 new
> CHIP_IS and patched clocks, hwmod and power management related files
> consequently. My system now boots until it complains that it is unabl=
e=20
> to mount its root filesystem.

Can you please describe where you need CHIP_IS for am3505? It seems tha=
t
your patches just enable the same CHIP_IS_OMAP3430 features for am3505 =
too?

I'd rather see us improve the code so we can support am3505 properly wi=
thout
a need to patch all over the place..

> One of the next things I'll look at is how to properly support the ZC=
N package.
> Right now, the CBB package is used (board-am3517evm.c for instance) b=
ut there
> are differences that prevent some GPIOs from being configured properl=
y. It would
> be nice to know if someone is working on this before I start...

You should be able to handle the differences easily just by adding a
new package_subset to mux34xx.c, that just overrides the desired pins
in omap3_muxmodes. Eventually we will be using device tree + common
mux framework for this, but you might as well do the omap3_znc_subset
meanwhile as we can then generate the device tree entries for all of
them. That is assuming it's not a huge delta from omap3_muxmodes :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
