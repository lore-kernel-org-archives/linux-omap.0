From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Wed, 05 Sep 2012 11:23:58 +0300
Message-ID: <50470C1E.7090300@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com> <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com> <5044C2DD.5000705@ti.com> <504578B3.3090804@ti.com> <5045D557.30404@ti.com> <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60086 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929Ab2IEIXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:23:36 -0400
Received: by yhpp61 with SMTP id p61so34450yhp.11
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:23:34 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On 09/05/2012 09:11 AM, Hiremath, Vaibhav wrote:
>> Not yet, but we discussed that with Peter and since he does have the=
se
>> patches for DT, he'll be able to test your series with the McBSP cha=
nges.
>>
>=20
> Great.

With his series and your patch for omap-hwmod audio was probing and wor=
king on
OMAP3/4/5 without issues.

>=20
>> I still want to update a couple of DTS to test that on some other IP=
s.
>>
>=20
> Ohh ok. Please let me know if I can help you here by any means.
> I am equipped with AM37xEVM, BeagleBoard and Panda.

You can try this series and your patch on top of linux-next on Panda. N=
ot all
patches are in which needed for BeagleBoard at the moment.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
