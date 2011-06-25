From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Sat, 25 Jun 2011 22:10:58 +0200
Message-ID: <DE79F8F5-7D8A-46B8-8C8C-C2A7515E9117@dominion.thruhere.net>
References: <1308932625-17632-1-git-send-email-premi@ti.com> <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59356 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab1FYULC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 16:11:02 -0400
Received: by wyg8 with SMTP id 8so433030wyg.19
        for <linux-omap@vger.kernel.org>; Sat, 25 Jun 2011 13:11:01 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>


Op 25 jun 2011, om 20:51 heeft Premi, Sanjeev het volgende geschreven:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
>> Sent: Saturday, June 25, 2011 1:47 PM
>> To: linux-omap@vger.kernel.org List
>> Cc: linux-arm-kernel; Paul Walmsley
>> Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
>>=20
>>=20
>> Op 24 jun 2011, om 18:23 heeft Sanjeev Premi het volgende geschreven=
:
>>=20
>>> The current selection of the GPTIMER on was result of
>>> a hardware issue in early versions of the Beagleboards
>>> (Ax and B1 thru B4). [1] [2]
>>>=20
>>> Its been long since the hardware issue has been fixed.
>>> This patch uses GPTIMER 1 for all newer board revisions
>>> incl. Beagleboard XM.
>=20
> [sp] I didn't include a reason - because the problem may not
>     be reproducible on the public trees.
>=20
>     During tests performed in internal development trees, the
>     BogoMIPS calculations @ 1GHz wouldn't go beyond "830-850"
>     range. While there was no such inconsistency on OMAP3EVM.
>=20
>     After few days of debug GPTIMER12 came to be only difference.
>     Tracing GPTIMER12 in the spec proved quite a challenge; the
>     as timer is not included in the TRM and corresponding interrupt
>     is marked reserved. Paul (in cc:) obviously had access to
>     documents that we don't.
>=20
>     This patch is merely trying to bring parity in use of GPTIMER
>     across OMAP3 boards (AND use documented IP) - taking note of
>     many Beagleboards where current code is necessary.

I get a value of 1010 =B110 bogoMIPS consistently with .39 + dvfs patch=
es. Having said that, this patch does seem to be an improvement, but ha=
s it actually been tested on real beagleboard hardware with a recent ke=
rnel? Especially on the boards affected by the capacitor issue on the e=
xternal clock.--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
