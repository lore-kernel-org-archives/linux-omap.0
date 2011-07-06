From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: Re: [PATCH] AM3505/3517 ZCN package support
Date: Wed, 06 Jul 2011 12:54:49 -0400
Message-ID: <4E149359.1090400@8d.com>
References: <4E147F55.8090805@8d.com> <B85A65D85D7EB246BE421B3FB0FBB593024D9B4CA5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:53699 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab1GFQyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jul 2011 12:54:50 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D9B4CA5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 06/07/11 12:11 PM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rapha=EBl Ass=
=E9nat
>> Sent: Wednesday, July 06, 2011 8:59 PM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH] AM3505/3517 ZCN package support
>>
>> This patch adds support for the AM35xx ZCN package specific muxmodes=
=2E
>>
>> Signed-off-by: Raphael Assenat <raph@8d.com>
>>
>=20
> [sp] Few quick comments below:
Thank you for your comments. I just sent an updated version according t=
o them.


>> +#define _OMAP3_NULL_MUXENTRY(M0) _OMAP3_MUXENTRY(M0, 0,=20
>> NULL, NULL,	\
>> +				NULL, NULL, NULL, NULL, NULL, NULL)
>> +
>>  /*
>>   * Superset of all mux modes for omap3
>>   */
>> @@ -651,51 +654,50 @@ static struct omap_mux __initdata=20
>> omap3_muxmodes[] =3D {
>>  		"gpio_166", NULL, NULL, "safe_mode"),
>> =20
>>  	/* Only on 3630, see omap36xx_cbp_subset for the signals */
>> -	_OMAP3_MUXENTRY(GPMC_A11, 0,
>> -		NULL, NULL, NULL, NULL,
>> -		NULL, NULL, NULL, NULL),
> [snip]...[snip]
>> +	_OMAP3_NULL_MUXENTRY(GPMC_A11),
>> +	_OMAP3_NULL_MUXENTRY(SAD2D_MBUSFLAG),
>> +	_OMAP3_NULL_MUXENTRY(SAD2D_MREAD),
>=20
> [sp] These changes don't go with the current patch description.
>      You may want to keep them in a separate patch; and use here.
Ok, I will send another patch for this that will apply on top of the ZC=
N
patch.

Regards,
Rapha=EBl Ass=E9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
