From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 26 Nov 2014 17:12:04 -0800
Message-ID: <20141127011203.GR2817@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <201411270001.44871@pali>
 <20141126231435.GQ2817@atomide.com>
 <201411270038.01312@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63252 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752938AbaK0BOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 20:14:35 -0500
Content-Disposition: inline
In-Reply-To: <201411270038.01312@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 15:40]:
>=20
> With enabled CONFIG_ARM_APPENDED_DTB=3Dy file /proc/atags is=20
> missing.

OK I guess it should not be needed for DT based booting.
=20
> > The build_tag_list() should parse ATAG_REVISION and then
> > parse_tag_revision() should copy it to system_rev. Maybe try
> > adding some printks to see if those functions get called?
>=20
> Now I see... Problem is that build_tag_list() is called from=20
> convert_to_tag_list() which is called from setup_machine_tags()=20
> which is called from setup_arch() only if setup_machine_fdt()=20
> call fails. And it fails for *non* DT boot. You can check this=20
> chain too.

Thinking about this probably the best long term solution is
to pass optional board_revision in the kernel cmdline that
can be parsed early and copied to system_rev variable.

Or if you can think of some other way to get it, we can set
system_rev in pdata-quirks.c.

Or maybe add some code to copy the ATAGs somewhere where
they are out of the way and don't conflict with the device
tree data? Then we can query ATAG_REVISION from pdata-quirks.c
and set system_rev.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
