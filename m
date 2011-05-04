From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 0/2 v5] twl4030-madc driver
Date: Wed, 4 May 2011 09:53:07 +0530
Message-ID: <BANLkTimyxpfBLUTPUostFjHkCUSW7wzyVA@mail.gmail.com>
References: <1298986926-31180-1-git-send-email-j-keerthy@ti.com>
	<20110302101512.GC16181@sortiz-mobl>
	<BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
	<BANLkTi=zt1j_s1uDfjL=SRG6_LS1pa3xAg@mail.gmail.com>
	<BANLkTik2B_w5Rn+Q-erPhQs6VbfrNz2mcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50047 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802Ab1EDEXI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 00:23:08 -0400
Received: by mail-iy0-f182.google.com with SMTP id 12so903907iyj.13
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 21:23:07 -0700 (PDT)
In-Reply-To: <BANLkTik2B_w5Rn+Q-erPhQs6VbfrNz2mcA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Wed, May 4, 2011 at 9:41 AM, Steve Sakoman <sakoman@gmail.com> wrote=
:
> On Tue, May 3, 2011 at 12:49 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
>> Hello Steve,
>>
>> Can you try adding this patch?
>
> Thanks!
>
> I tried the patch and it did indeed fix the issue. =A0We should try t=
o
> get this in mainline since the hwmon driver won't work without it.
>

Yes Steve. I am posting a patch today.
> Steve
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
