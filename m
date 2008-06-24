From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH v2] OMAP3 clock: fix omap2_clk_wait_ready for OMAP3430ES2 DSS
Date: Tue, 24 Jun 2008 08:54:13 +0300
Message-ID: <877icfl6nu.fsf@trdhcp146196.ntc.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com>
	<485CA347.909@googlemail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB022BB66209@dbde02.ent.ti.com>
	<alpine.DEB.1.00.0806211054100.19765@utopia.booyaka.com>
	<ACAEC52B-E9B4-4789-8D63-114C53846760@student.utwente.nl>
	<13B9B4C6EF24D648824FF11BE8967162035BA2A659@dlee02.ent.ti.com>
	<alpine.DEB.1.00.0806221308090.7503@utopia.booyaka.com>
	<874p7kad66.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.1.00.0806230849130.4919@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38308 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYFXFy7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 01:54:59 -0400
In-Reply-To: <alpine.DEB.1.00.0806230849130.4919@utopia.booyaka.com> (ext Paul
	Walmsley's message of "Mon, 23 Jun 2008 08:52:00 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dirk Behme <dirk.behme@googlemail.com>

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hi Jouni
>
> On Mon, 23 Jun 2008, H=C3=B6gander Jouni wrote:
>
>> Hello Paul,
>>=20
>> It should actually wait for SSI also. Read my comments below.
>
> ...
>
>> And add this part
>>=20
>> +       if (cpu_is_omap34xx() &&
>> +	    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
>> +	    clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT) {
>> +		bit =3D OMAP3430ES2_ST_SSI_IDLE;
>
> what should OMAP3430ES2_ST_SSI_IDLE be set to?  I don't have any=20
> documentation here that defines this bit.

Sorry for not to mention this in my first mail:

#define OMAP3430ES2_ST_SSI_IDLE				(1 << 8)
#define OMAP3430ES2_ST_SSI_STDBY			(1 << 0)

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
