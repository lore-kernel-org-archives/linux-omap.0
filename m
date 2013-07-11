From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
Date: Thu, 11 Jul 2013 17:45:55 +0200
Message-ID: <51DED333.9080609@ti.com>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com> <20130711145916.GA6138@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48094 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126Ab3GKPqT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 11:46:19 -0400
In-Reply-To: <20130711145916.GA6138@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/11/2013 04:59 PM, Nishanth Menon wrote:
> On 16:23-20130711, Peter Ujfalusi wrote:
>> OMAP4 no longer boots in legacy mode so the code here is no longer u=
sed.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm/mach-omap2/twl-common.c | 332 ++--------------------------=
-----------
>>  arch/arm/mach-omap2/twl-common.h |   8 -
>>  2 files changed, 12 insertions(+), 328 deletions(-)
> Could we modify the Makefile and build twl-common.o only for
> CONFIG_ARCH_OMAP3?
>=20
> We could get rid of all the #ifdef from the code that way. OMAP3 is t=
he
> only platform that still depends on this - Further, with this change,

Yep, I can do that. I'll send a separate patch to do this.

> commit 34a38440689b06a515104d668494e0ff8a4e1537
> (regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators)
> will need a relook as well. currently part of the discussion with Mar=
k
> in [1]
>=20
> [1] http://marc.info/?t=3D137185016300003&r=3D1&w=3D2

I don't see anything touching twl-common.c/h in the series.
But at the end we should get rid of the legacy support in all of the dr=
ivers
aimed for OMAP4+ gradually since it is pointless to keep dead code. Emp=
hasis
on gradually ;)

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
