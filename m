From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH 1/3] omap gpmc : add support of setting CYCLE2CYCLEDELAY
 and BUSTURNAROUND
Date: Tue, 6 Nov 2012 19:00:42 +0100
Message-ID: <5099504A.5060505@parrot.com>
References: <1352220277-4251-1-git-send-email-matthieu.castet@parrot.com> <5099478A.50901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:33113 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab2KFSAr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 13:00:47 -0500
In-Reply-To: <5099478A.50901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>, Afzal Mohammed <afzal@ti.com>

Jon Hunter a =E9crit :
> On 11/06/2012 10:44 AM, Matthieu CASTET wrote:
>> =20
>>  	/* caller is expected to have initialized CONFIG1 to cover
>>  	 * at least sync vs async
>> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-=
omap/include/plat/gpmc.h
>> index 2e6e259..34ca454 100644
>> --- a/arch/arm/plat-omap/include/plat/gpmc.h
>> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
>> @@ -131,6 +131,8 @@ struct gpmc_timings {
>>  	/* The following are only on OMAP3430 */
>>  	u16 wr_access;		/* WRACCESSTIME */
>>  	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>> +	u16 cycle2cycledelay;	/* CYCLE2CYCLEDELAY */
>> +	u16 busturnaround;		/* BUSTURNAROUND */
>=20
> So you should be able to move these out of OMAP3430 specific as they =
are
> generic.
Thanks for the quick review.

I will post another patch, unless this is already done in  Afzal patch =
(Is there
a tree where I can get Afzal pending patches ?)


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
