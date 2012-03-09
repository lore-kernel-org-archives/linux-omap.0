From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [RFC PATCH] OMAP: UART: Enable tx wakeup bit in wer
Date: Fri, 9 Mar 2012 11:49:51 +0530
Message-ID: <CAMrsUdL6jPguVLDnEkg-T9fyvv+XY5tkNiooZOXszUYrdrUwPw@mail.gmail.com>
References: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com>
 <alpine.DEB.2.00.1201251217120.5324@utopia.booyaka.com> <alpine.DEB.2.00.1203051321580.1430@utopia.booyaka.com>
 <CAMrsUdJqmJ75=X_Qg3vQCr7zezs0jOK8L1ri8p5K=+6ZKsRFcg@mail.gmail.com> <alpine.DEB.2.00.1203062251270.23214@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50330 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751537Ab2CIGUN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 01:20:13 -0500
Received: by obceq6 with SMTP id eq6so1883620obc.26
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 22:20:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1203062251270.23214@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, Mar 7, 2012 at 11:27 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 6 Mar 2012, Raja, Govindraj wrote:
>
>> I see two ways of adding this tx wake-up flag.
>>
>> 1.) passing a feature flag from pdata and populating the feature val=
ue to wer.
>>
>> 2.) Duplicating the uart1/2/3 hwmod for omap3430 without dev attrib
>> and uart1/2/3/4
>> =A0 =A0 =A0hwmod for omap3630 with dev attribs.
>>
>> Approach-2 adds unnecessary code duplication in hwmod file with and =
without
>> dev_attribs, So right now here is the patch to follow approach [1],
>>
>> If its strongly recommended to use approach-2 will add it.
>> (My concern is the diffstat it might produce with approach-2)
>
> Both 1 and 2 are needed.
>
> The current way that errata are handled in arch/arm/mach-omap2/serial=
=2Ec
> needs to be changed. =A0Those should be flags that are passed from hw=
mod
> dev_attr data. =A0The presence of the TX wakeup bit should simply be =
another
> dev_attr flag. =A0These flags should be passed to the driver via the
> omap_up.errata field for the time being.

okay.

>
> The exception to this is if the IP block's revision register was chan=
ged
> when TX wakeups became possible. =A0If that's the case, then that mec=
hanism
> can be used in lieu of dev_attr and platform_data in this situation.

I will check on the MVR reg available for uart-rev on different omap so=
cs,
and will get back by end on next of week with a possible patch.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
