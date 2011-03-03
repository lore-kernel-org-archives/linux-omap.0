From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP4: Add IVA OPP enteries with Updated Voltage Rail Values.
Date: Thu, 3 Mar 2011 19:37:25 +0530
Message-ID: <AANLkTikN8S4UEkvzBF_cJ+7+iFvYgJTiqPuZ1-uei3pQ@mail.gmail.com>
References: <1299144429-20942-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTimb4_EXmMwyBfR52Zx9nhZy25W3OZhQy9nKcQZ4@mail.gmail.com>
	<AANLkTi=HKUn5VK2KkXCMSHMDoRsgSB98LJnSYJCUgHc5@mail.gmail.com>
	<AANLkTi=xTJbbDF34Yzf54r5=ZigA=hzpkuo=cOjHH8ot@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:46472 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754588Ab1CCOH1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 09:07:27 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so1174471bwz.29
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 06:07:26 -0800 (PST)
In-Reply-To: <AANLkTi=xTJbbDF34Yzf54r5=ZigA=hzpkuo=cOjHH8ot@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Mar 3, 2011 at 3:53 PM, Menon, Nishanth <nm@ti.com> wrote:
> On Thu, Mar 3, 2011 at 15:39, Gulati, Shweta <shweta.gulati@ti.com> w=
rote:
>> Hi,
>>
>> On Thu, Mar 3, 2011 at 3:04 PM, Menon, Nishanth <nm@ti.com> wrote:
>>> On Thu, Mar 3, 2011 at 14:57, Shweta Gulati <shweta.gulati@ti.com> =
wrote:
>>>>
>>>> This Patch adds OPP enteries for IVA =A0in OMAP4 OPP Table
>>>> and updates IVA voltage Rail values obtained from latest
>>>> OMAP4430 Data Manual Operating Condition Addendum.
>>> Do you think =A0we should add the version of the document in the co=
mmit
>>> message - it looks like every "latest" version we look at has some
>>> update, so we'd know what baseline the code currently maps to when =
we
>>> do a git blame at a later point of time
>> Ok, Will do.
> Sorry, one more tiny point I missed - for the sake of ensuring the
> functional bisectability - could you do the following:
> a) update voltages (MPU,IVA) for doc 0.3
> b) introduce IVA OPPs

> what do you think?
I think its better to submit MPU and IVA domain Patches seperately
The way I have done:
1. Patch Series that has  MPU OPP Table and Voltage Rail Value changes.
2. Patch which adds IVA OPP Entries and updates Voltage Rail values.
>
> Regards,
> Nishanth Menon
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
