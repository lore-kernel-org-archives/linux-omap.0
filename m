From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Thu, 24 Mar 2011 18:33:06 +0530
Message-ID: <AANLkTi==Mz=szoa78EaRKgqTddOeu5xEeg5hfNWbWWO2@mail.gmail.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-2-git-send-email-khilman@ti.com>
	<4D874DC9.6020203@ti.com>
	<87vczcfq19.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:49727 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752882Ab1CXNDJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 09:03:09 -0400
Received: by mail-bw0-f50.google.com with SMTP id 2so19215bwz.23
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 06:03:07 -0700 (PDT)
In-Reply-To: <87vczcfq19.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>

Kevin,

On Mon, Mar 21, 2011 at 9:02 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
>> Hi Kevin,
>>
>> On 3/19/2011 1:18 AM, Hilman, Kevin wrote:
>>> The voltage domain pointer currently in struct omap_hwmod is not us=
ed
>>> and does not belong here. =A0Instead, voltage domains will be assoc=
iated
>>> with powerdomains in forthcoming patches.
>>
>> Technically speaking, an IP, and thus the hwmod does belong to a
>> voltage domain, a power domain and a clock domain.
>>
>> What is maybe important to add is that since clkdm < pwrdm < voltdm,
>> we can potentially avoid providing the information for the each doma=
in
>> type.
>>
>> At some point the hwmod will have to contain a clkdm instead of
>> relying on the main_clk to get it... but that's another topic...
>>
>>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>>> ---
>>> =A0 arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 -
>>> =A0 1 files changed, 0 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/ar=
m/plat-omap/include/plat/omap_hwmod.h
>>> index 1adea9c..a5fa7c1 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> @@ -520,7 +520,6 @@ struct omap_hwmod {
>>> =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*_=
clk;
>>> =A0 =A0 =A0struct omap_hwmod_opt_clk =A0 =A0 =A0 *opt_clks;
>>> =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*vdd_name;
>>
>> And what about vdd_name? It should probably be removed as well.
>>
>
> Yes, but it's currently used by the SR layer (currently the only user=
=2E)
>
> Removing it required cleaning up the SR layer as well, so I decided t=
o
> leave the SR cleanups for someone else for the moment while I focus o=
n
> the voltage layer(s)
Even if we try to remove 'vdd_name', how should we get 'struct voltaged=
omain'
info corresponding to sr_mpu, sr_core in sr_dev_init API?
As functional clock of SR1 and SR2 are from
wake up domain, so even if we try to use current Clockdomain and
Powerdomain framework
APIs, to get 'clkdomain' pointer and then retrieve 'pwrdomain'
pointer, finally getting 'voltdomain'
pointer we would get 'WKUP' voltage domain ptr not the 'mpu' or 'core'
voltdomain pointer.

> Kevin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
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
