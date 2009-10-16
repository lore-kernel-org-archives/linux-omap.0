From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Fri, 16 Oct 2009 14:39:04 -0600
Message-ID: <4b73d43f0910161339l360c1b59s7a3c6380c31844a5@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <4AD81DC2.4080607@googlemail.com>
	 <4b73d43f0910160643y59d39373y1dd1c1995f521778@mail.gmail.com>
	 <4AD88B0A.1010006@googlemail.com>
	 <4b73d43f0910160859j6958afeaw415a2a71efc72672@mail.gmail.com>
	 <4AD89A01.1020400@googlemail.com>
	 <4b73d43f0910161151t2b85a5e8w3fa9951e1339d69a@mail.gmail.com>
	 <4AD8CFAD.40507@googlemail.com>
	 <4b73d43f0910161337k24908c7bjf5d84a90efb27bef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:53404 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZJPUjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 16:39:00 -0400
Received: by pzk26 with SMTP id 26so1874567pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 13:39:04 -0700 (PDT)
In-Reply-To: <4b73d43f0910161337k24908c7bjf5d84a90efb27bef@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: linux-omap@vger.kernel.org

cc'ing list after responding only to Dirk.

On Fri, Oct 16, 2009 at 2:37 PM, John Rigby <jcrigby@gmail.com> wrote:
> On Fri, Oct 16, 2009 at 1:55 PM, Dirk Behme <dirk.behme@googlemail.co=
m> wrote:
>> John Rigby wrote:
>>>
>>> First the disclaimers:
>>> The board is new board that has had hardware mmc/sdio problems befo=
re.
>>> =A0It is based closely on beagle but uses a different package which=
 has
>>> some package specific issues. =A0We think we have found them all bu=
t who
>>> knows.
>>>
>>> My kernel is a few months old 2.6.29.
>>
>> Then you can't apply my patch 1:1. Steve already found that there ar=
e a lot
>> of differences between recent git head and 2.6.31. A lot of omap_hsm=
mc
>> changes were done since 2.6.31.
>
> I applied your patch in spirit:) thus the disclaimer.
>
> .....
>
>
>>
>> Additionally, what I wonder regarding this, is the davinci driver [1=
]
>> additionally checking for DAT1 level in enable_sdio_irq
>>
>> 1114 =A0 =A0 =A0 =A0 if (enable) {
>> 1115 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!((readl(host->base + DAVIN=
CI_SDIOST0))
>> 1116 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SDIOS=
T0_DAT1_HI)) {
>> 1117 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(SDIOIST_=
IOINT,
>> 1118 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 host->base + DAVINCI_SDIOIST);
>> 1119 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_signal_sdio=
_irq(host->mmc);
>> 1120 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> ... enable int
>> 1124 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> 1125 =A0 =A0 =A0 =A0 } else {
>> ... disable int
>> 1129 =A0 =A0 =A0 =A0 }
>>
>> And it does similar stuff in xfer_done
>>
>> =A0873 =A0 =A0 =A0 =A0 if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
>> =A0874 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->sdio_int && (!((rea=
dl(host->base +
>> DAVINCI_SDIOST0))
>> =A0875 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 & SDIOST0_DAT1_HI))) {
>> =A0876 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(SDIOIS=
T_IOINT, host->base +
>> DAVINCI_SDIOIST);
>> =A0877 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_signal_sd=
io_irq(host->mmc);
>> =A0878 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0879 =A0 =A0 =A0 =A0 }
>>
>> Most probably there is a reason for doing so?
>
> This looks to me like it is detecting the irq where the hw may not
> otherwise do so. =A0It is basically saying if the line is low signal =
an
> sdio irq. =A0Sort of the opposite of the problem we have.
>
>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
