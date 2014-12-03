From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 3 Dec 2014 22:22:17 +0000 (UTC)
Message-ID: <m5o2ep$5gq$1@ger.gmane.org>
References: <20141027200008.GR2560@atomide.com> <201411270038.01312@pali>
	<20141127011203.GR2817@atomide.com> <201411271232.47231@pali>
	<20141128202719.GU2817@atomide.com> <20141203165204.GD26685@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52494 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbaLCWWd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Dec 2014 17:22:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1XwIJb-0000EO-B9
	for linux-omap@vger.kernel.org; Wed, 03 Dec 2014 23:22:31 +0100
Received: from 178.70.169.181 ([178.70.169.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 03 Dec 2014 23:22:31 +0100
Received: from dbaryshkov by 178.70.169.181 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 03 Dec 2014 23:22:31 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On Wed, 03 Dec 2014 17:52:04 +0100, Pavel Machek wrote:

> On Fri 2014-11-28 12:27:19, Tony Lindgren wrote:
>> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141127 03:34]:
>> > On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
>> > >=20
>> > > Thinking about this probably the best long term solution is to p=
ass
>> > > optional board_revision in the kernel cmdline that can be parsed
>> > > early and copied to system_rev variable.
>> > >=20
>> > >=20
>> > Not possible. Our bootloader is closed & proprietary. I tried to
>> > replace it with u-boot I was not able to do that. So we will use t=
hat
>> > Nokia closed bootloader forever and it can provide data only in AT=
AG
>> > structure.
>>=20
>> I'm using just mainline u-boot flashed as kernel for nolo that then
>> loads the kernel.
>>=20
>> For passing the board revision using the pass through u-boot is
>> probably the best long term solution. U-boot can read the ATAGs from
>> nolo and modify the .dtb for the revision information.
>>=20
>> Are you saying there are some issues with that?
>=20
> Plenty :-).
>=20
> Basically, u-boot is great for production (select one of kernels and
> boot it), but pretty much unusable for development:

You might want to look at kexecboot project. Basically it is an initram=
fs
payload bundled with a Linux kernel that can further choose which kerne=
l
to load. USB is not supported (afair), but one might add that - it's
just a Linux environment in the end.

--=20
With best wishes
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
