From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/3] omap gpmc : add support of setting CYCLE2CYCLEDELAY
 and BUSTURNAROUND
Date: Tue, 6 Nov 2012 14:34:03 -0600
Message-ID: <5099743B.3040804@ti.com>
References: <1352220277-4251-1-git-send-email-matthieu.castet@parrot.com> <5099478A.50901@ti.com> <5099504A.5060505@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33860 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab2KFUeK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 15:34:10 -0500
In-Reply-To: <5099504A.5060505@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>, Afzal Mohammed <afzal@ti.com>


On 11/06/2012 12:00 PM, Matthieu CASTET wrote:
> Jon Hunter a =E9crit :
>> On 11/06/2012 10:44 AM, Matthieu CASTET wrote:
>>> =20
>>>  	/* caller is expected to have initialized CONFIG1 to cover
>>>  	 * at least sync vs async
>>> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat=
-omap/include/plat/gpmc.h
>>> index 2e6e259..34ca454 100644
>>> --- a/arch/arm/plat-omap/include/plat/gpmc.h
>>> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
>>> @@ -131,6 +131,8 @@ struct gpmc_timings {
>>>  	/* The following are only on OMAP3430 */
>>>  	u16 wr_access;		/* WRACCESSTIME */
>>>  	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>>> +	u16 cycle2cycledelay;	/* CYCLE2CYCLEDELAY */
>>> +	u16 busturnaround;		/* BUSTURNAROUND */
>>
>> So you should be able to move these out of OMAP3430 specific as they=
 are
>> generic.
> Thanks for the quick review.
>=20
> I will post another patch, unless this is already done in  Afzal patc=
h (Is there
> a tree where I can get Afzal pending patches ?)

Afzal keeps his kernel tree on gitorious [1]. However, I am not sure
what Afzal's plans are for the remaining patches not yet merged and
which branch you should look at (I have a lot of problems viewing
anything on gitorious these days).

Afzal, let us know how you prefer to handle this.

Cheers
Jon

[1] http://gitorious.org/x0148406-public/linux-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
