From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH RESEND v2 1/2] arm/dts: Add AM33XX basic pinctrl support
Date: Wed, 08 Aug 2012 15:05:44 +0300
Message-ID: <50225618.9070501@ti.com>
References: <1343144719-26352-1-git-send-email-anilkumar@ti.com> <1343144719-26352-2-git-send-email-anilkumar@ti.com> <50125B1C.8000209@ti.com> <331ABD5ECB02734CA317220B2BBEABC13EA06E4B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44150 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755967Ab2HHMGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 08:06:19 -0400
Received: by obqv19 with SMTP id v19so1657262obq.30
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 05:06:18 -0700 (PDT)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA06E4B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

On 07/31/2012 04:37 PM, AnilKumar, Chimata wrote:
>> I'm just curious about the size here: how it ended up as 0x0338?
>> While looking at the TRM of AM335x I can come up with 0x0238 (0x44e1=
0800 -
>> 0x44e10a38), but I don't see any sings of the remaining 0x0100 to be
>> documented at least.
>=20
> No, pinmux registers are available till 0x44E10B38, look at AM335x la=
test TRM
> or pinmux utility (we cannot find the exact offsets but pins we can f=
ind after
> 0x0A38, conf_ddr_resetn) at http://www.ti.com/tool/pinmuxtool

I have looked at the latest TRM (Rev F, SPRUH73F -  public TRM) and the=
re is
not mention of registers between 0x0a34 and 0x0e00.
I can not even find any reference of conf_ddr_resetn register either in=
 the TRM.
I can not check with the pinmuxtool since it is crashing with wine unde=
r Linux.
There could be registers after 0x0a34, but they are not publicly docume=
nted...

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
