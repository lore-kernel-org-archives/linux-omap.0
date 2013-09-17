From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/2] ARM: OMAP: Add secure function omap_smc3()
 which calling instruction smc #1
Date: Tue, 17 Sep 2013 16:17:44 -0700
Message-ID: <20130917231744.GJ9994@atomide.com>
References: <20130916171023.GA17477@localhost.localdomain>
 <20130917154331.GA9994@atomide.com>
 <201309171753.24433@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752890Ab3IQXSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Sep 2013 19:18:05 -0400
Content-Disposition: inline
In-Reply-To: <201309171753.24433@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Dave Martin <Dave.Martin@arm.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, "nm@ti.com" <nm@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130917 09:01]:
> On Tuesday 17 September 2013 17:43:31 Tony Lindgren wrote:
> > Have you guys checked how this works with the recently posted
> > "[PATCH v6 0/5] ARM: support for Trusted Foundations secure
> > monitor" series?
>=20
> this code looks like some Tegra and "Trusted Foundations"=20
> specific. There is Note: The API followed by Trusted Foundations=20
> does *not* follow the SMC calling conventions.  Also code calling=20
> smc #0 instruction, so in my opinion for rx51 it is useless.

OK, so still no generic SMC code then :( This patch is fine
with me.
=20
> Tony, can you include this two rx51 secure patches (patch v4 1/2=20
> and patch v2 2/2)? Or is there some any other problem?

No other comments on this patch, I'll post some comments on the
v2 2/2 patch considering we're moving to device tree based
booting.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
