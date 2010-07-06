From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 9/9] omap: id: add feature check for omap1
Date: Tue, 6 Jul 2010 11:07:58 -0500
Message-ID: <4C3354DE.8080308@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com> <1277259375-18521-10-git-send-email-nm@ti.com> <20100706124606.GP3192@atomide.com> <4C33275E.4030506@ti.com> <20100706131457.GQ3192@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab0GFQIA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jul 2010 12:08:00 -0400
In-Reply-To: <20100706131457.GQ3192@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

Tony Lindgren had written, on 07/06/2010 08:14 AM, the following:
> * Nishanth Menon <nm@ti.com> [100706 15:47]:
>> On 07/06/2010 07:46 AM, Tony Lindgren wrote:
>>> * Nishanth Menon<nm@ti.com>  [100623 05:10]:
>>>> add a minimalist feature - l2cache for omap1.
>>>>
>>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap1/id.c |    6 ++++++
>>>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
>>>> index 91dbb71..b98a17f 100644
>>>> --- a/arch/arm/mach-omap1/id.c
>>>> +++ b/arch/arm/mach-omap1/id.c
>>>> @@ -200,5 +200,11 @@ void __init omap1_check_revision(void)
>>>>  	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n"=
,
>>>>  	       die_rev, omap_revision&  0xff, system_serial_low,
>>>>  	       system_serial_high);
>>>> +
>>>> +	/*
>>>> +	 * TODO: add a better check feature once we have
>>>> +	 * more decent feature check
>>>> +	 */
>>>> +	omap_features |=3D OMAP_HAS_L2CACHE;
>>>>  }
>>> There's no L2 cache on omap1?
>> I thought it did, hence added.. am I wrong?
>=20
> Maybe you're thinking something else.. But for example, 1710 TRM says=
:
>=20
> ARM926EJ
> L1 32K-byte, four-way set-associative instruction cache
> L1 16K-byte, four-way set-associative data cache with write buffer
>=20
> Then 2430 TRM says:
>=20
> ARM1136JF-S
> 32K-byte instructions and 32K-byte data--4-way associative
> 64-entry instruction and 64-entry data memory management units (MMUs)
>=20
> So no L2 until 34xx I believe.
>=20
> Regards,
>=20
> Tony
Arrgh.. my bad. you are right.

here is a bigger list I just checked internally with TRMs

1510 - TI925T - no L2.
	A separate 16K-byte instruction cache and 8K-byte data cache. Both are=
=20
two-way associative with virtual index virtual tag (VIVT)

1610 - ARM926EJ
	L1 16K-byte, four-way set-associative instruction cache
	L1 8K-byte, four-way set-associative data cache with write buffer
1710 - ARM926EJ
	L1 32K-byte, four-way set-associative instruction cache
	L1 16K-byte, four-way set-associative data cache with write buffer

2420 (2.3) - ARM1136JF-S
	=96 32-KB instruction and 32-KB data; 4-way set associative memory=20
management units (MMUs)
	=96 64-entry instruction and 64-entry data write buffer
2430 (2.1) -
	=96 32K-byte instructions and 32K-byte data=974-way associative
	=96 64-entry instruction and 64-entry data memory management units (MM=
Us)

Please drop 9/9, and I will post a new revision of 8/9 without L2 enabl=
ed.

--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
