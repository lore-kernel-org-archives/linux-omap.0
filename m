From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 3/4 v4] OMAP: McBSP: Introduce caching in register write
 operations
Date: Fri, 04 Dec 2009 13:57:47 +0100
Message-ID: <4B19074B.1000606@tis.icnet.pl>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <200912031330.43464.jkrzyszt@tis.icnet.pl> <20091203200301.GB4348@atomide.com> <200912040018.02309.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:34210 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291AbZLDM5r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Dec 2009 07:57:47 -0500
In-Reply-To: <200912040018.02309.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Janusz Krzysztofik napisa=C5=82(a):
> Thursday 03 December 2009 21:03:02 Tony Lindgren napisa=C5=82(a):
>> Hi,
>>
>> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091203 04:29]:
>>> Reserve space inside omap_mcbsp structure for storing cached copies=
 of
>>> McBSP register values.
>>> Modify the MCBSP_WRITE() macro to update the cache with every regis=
ter
>>> write operation.
>>> Introduce a new macro that reads from the cache instead of hardware=
=2E
>>>
>>> Applies on top of patch 2 from this series:
>>> [PATCH v3 2/4] OMAP: McBSP: Prepare register read/write macros API =
for
>>> caching
>>>
>>> Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
>>> commit 4421752e331cfb1d942b47ffdb26e451a8da58a0.
>>> Compile-tested with omap_3430sdp_defconfig.
>>>
>>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>>>
>>> ---
>>>
>>> Thursday 03 December 2009 08:49:21 Jarkko Nikula wrote:
>>>> On Tue, 1 Dec 2009 04:15:50 +0100
>>>>
>>>> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
>>>>>  #define MCBSP_WRITE(mcbsp, reg, val) \
>>>>> -		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
>>>>> +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
>>>>> +		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
>>>>> +			=3D val)
>>>>> +#define MCBSP_READ_CACHE(mcbsp, reg) \
>>>>> +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1])
>>>> These divisions by DDR1 are confusing. Use rather sizeof:
>>>>
>>>> reg_cache[OMAP_MCBSP_REG_##reg / sizeof(*mcbsp->reg_cache)]
>>> Done.
>>>
>>> Jarkko, many thanks for your cooperation :).
>>>
>>> Janusz
>>>
>>>  arch/arm/plat-omap/include/plat/mcbsp.h |    5 +++++
>>>  arch/arm/plat-omap/mcbsp.c              |    7 ++++++-
>>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> --- git/arch/arm/plat-omap/include/plat/mcbsp.h.orig	2009-11-27
>>> 11:53:45.000000000 +0100 +++
>>> git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-01 03:37:21.000=
000000
>>> +0100 @@ -415,6 +415,11 @@ struct omap_mcbsp {
>>>  	u16 max_tx_thres;
>>>  	u16 max_rx_thres;
>>>  #endif
>>> +#ifdef CONFIG_ARCH_OMAP1
>>> +	u16 reg_cache[OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1];
>>> +#else
>>> +	u32 reg_cache[OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1];
>>> +#endif
>>>  };
>>>  extern struct omap_mcbsp **mcbsp_ptr;
>>>  extern int omap_mcbsp_count;
>> How about rather set:
>>
>> static u16 omap1_reg_cache[];
>>
>> and
>>
>> static u32 omap2_reg_cache[];
>=20
> Hi Tony,
>=20
> Let me understand more precisely what you mean before I submit next v=
ersion.
>=20
> Did you mean something like:
>=20
> static u16 omap1_reg_cache[3][OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1]=
;
> static u32 omap2_reg_cache[5][OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1];
>=20
> both put in arch/arm/plat-omap/mcbsp.c without any ifdefs?

Tony,

I think I've already found one part of the answer myself: you probably=20
mean putting each table definition in a corresponding=20
arch/arm/mach-omap[12]/mcbsp.c source file, don't you?

What remains unclear for me is if you really intend to reserve static=20
cache space for all McBSP ports supported by a machine, even if not=20
supported by a particular cpu or not used on a particular board.

>>> --- git/arch/arm/plat-omap/mcbsp.c.orig	2009-12-01 03:19:56.0000000=
00
>>> +0100 +++ git/arch/arm/plat-omap/mcbsp.c	2009-12-03 11:37:21.000000=
000
>>> +0100 @@ -49,7 +49,12 @@ int omap_mcbsp_read(void __iomem *io_bas
>>>  #define MCBSP_READ(mcbsp, reg) \
>>>  		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
>>>  #define MCBSP_WRITE(mcbsp, reg, val) \
>>> -		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
>>> +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
>>> +		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / \
>>> +				 sizeof(*mcbsp->reg_cache)] =3D val)
>>> +#define MCBSP_READ_CACHE(mcbsp, reg) \
>>> +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / \
>>> +				  sizeof(*mcbsp->reg_cache)])
>>>
>>>  #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
>>>  #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
>> Then rather than doing this cache manipulation in the macro, just
>> do it in the omap_mcbsp_read/write functions based on the
>> cpu_class_is_omap1() accessing omap1_reg_cache or omap2_reg_cache.
>=20
> omap_mcbsp_wrtie() case seems clear to me, but:
>=20
> Did you mean defining a new omap_mcbsp_read_cache() function, similia=
r to=20
> omap_mcbsp_read(), but reading from cache instead of hardware?
>=20
> Or do you prefere if I modify omap_mcbsp_read() to be able to read fr=
om both=20
> hardware and cache, dependig on an additional argument, for example?
>=20
> Thanks,
> Janusz
>=20
>> This way you can get rid of the ifdef else.

But shouldn't declarations for both tables be placed in=20
arch/arm/plat-omap/include/plat/mcbsp.h withing an ifdef else block? If=
=20
yes, one ifdef else block would be replaced with another. Or did you=20
mean placing those declarations inside existing ifdef block with define=
s=20
for register offsets?

Thanks,
Janusz


>>
>> Regards,
>>
>> Tony
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
