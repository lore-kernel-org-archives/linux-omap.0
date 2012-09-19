From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
Date: Wed, 19 Sep 2012 16:36:46 -0500
Message-ID: <505A3AEE.8060408@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com> <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com> <alpine.DEB.2.00.1209192124570.5264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ISVgw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 17:36:52 -0400
In-Reply-To: <alpine.DEB.2.00.1209192124570.5264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 9/19/2012 4:26 PM, Paul Walmsley wrote:
> Hi Beno=EEt
>
> On Wed, 19 Sep 2012, Cousson, Benoit wrote:
>
>> Thanks for the rebase / repost. I'll pulled the full series if Paul =
is OK with
>>    ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
>>
>> Paul,
>> Is that OK?
>
> Looks to me like the clock change is unrelated to the DTS changes?  B=
est
> thing would be if you could just take the DTS changes and I'll take t=
he
> clkdev alias change.

Good point, it can be separated.

> Otherwise if that doesn't work I can ack it, but there might be some
> conflicts with other clkdev data changes.

No problem, that's fine for me.

Regards,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
