From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 26 Nov 2014 15:14:36 -0800
Message-ID: <20141126231435.GQ2817@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <201411262022.03338@pali>
 <20141126200806.GO2817@atomide.com>
 <201411270001.44871@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31213 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752540AbaKZXRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 18:17:10 -0500
Content-Disposition: inline
In-Reply-To: <201411270001.44871@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 15:03]:
> On Wednesday 26 November 2014 21:08:06 Tony Lindgren wrote:
>=20
> With your patch I'm getting:
>=20
> Hardware        : Nokia RX-51 board
>=20
> So patch is good.

Is that a Tested-by: then? :)
=20
> > > Revision comes from bootloader (via ATAG) and it is HW
> > > revision of N900 device. It cannot be hardcoded into kernel
> > > or DTS as it it depends on HW.
> >=20
> > Well for the "Revision" line problem, we could pass the
> > revision in cmdline or .dts if not passed in the legacy
> > ATAGs. It sounds like were just not copying it to system_rev
> > for DT based booting? Maybe it's just some missing
> > CONFIG_ATAG option that needs to be enabled?
>=20
> Yes it looks like DT code does not read Revision ATAG... I tried=20
> to enable everything but always same problem...

Maybe check if it shows up properly in /proc/atags or whatever
the interface for it was?

The build_tag_list() should parse ATAG_REVISION and then
parse_tag_revision() should copy it to system_rev. Maybe try
adding some printks to see if those functions get called?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
