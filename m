From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v3 1/4] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Tue, 2 Jul 2013 12:44:40 +0530
Message-ID: <51D27DE0.3000905@ti.com>
References: <1372010299-30141-1-git-send-email-pekon@ti.com>  <1372010299-30141-2-git-send-email-pekon@ti.com> <1372666588.22014.43.camel@sauron.fi.intel.com> <20980858CB6D3A4BAE95CA194937D5E73E9E29F6@DBDE04.ent.ti.com> <51D1BE59.4000203@ti.com> <20980858CB6D3A4BAE95CA194937D5E73E9E3B5D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51001 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932219Ab3GBHPO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 03:15:14 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E3B5D@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "arnd@arndb.de" <arnd@arndb.de>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Benoit Cousson (benoit.cousson@linaro.org)" <benoit.cousson@linaro.org>

On 7/2/2013 9:44 AM, Gupta, Pekon wrote:
>>>> This does not apply to l2-mtd.git, could you please re-base?
>>>>
>>> [Pekon]: rebased to l2-mtd.git
>>> - updated [Patch 3/4] which conflicted with commit '26331c04' which
>> touched omap2.c.
>>> - Please ignore [Patch 4/4] as it=E2=80=99s a DT update, which adds=
 on top of Benoit's
>> tree (which has NAND node commits too).
>> If you need one patch (DT patch) in the series to be merged in anoth=
er
>> repository (DT maintainer tree) then separate out that patch as sepa=
rate
>> series and mention the dependency or need ack from the driver mainta=
iner
>> so that both maintainer can apply the whole series into his reposito=
ry
>> instead of applying partially here and there.
>>
> Agree. Yes, I should have sent the DT patch separately.
> But I posted all changes as part of single series, as its easy for us=
ers to
> Test and Ack them.
> Similarly patches for GPMC (Tony's tree) and NAND (Artem's tree) are
> functionally coupled, So at times I have to send them as part of same=
 series.
> However, I'll clearly mention that in my cover-letter for future patc=
hes.
> Thanks for feedback ..
>
>
In that case you can publish your testing branch to a public repo and p=
oint to
that repo in your cover letter so that someone who wants to test can te=
st
from your repo which has all dependent patches.

Regards
Mugunthan V N

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
