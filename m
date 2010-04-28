From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v6] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Wed, 28 Apr 2010 05:22:59 -0500
Message-ID: <4BD80C83.8080903@ti.com>
References: <1272433677-28658-1-git-send-email-manjugk@ti.com> <4BD80867.7020801@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E94026F78A00B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab0D1KXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 06:23:12 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F78A00B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>

On 04/28/2010 05:20 AM, G, Manjunath Kondaiah wrote:
[..]

>>>
>>> +	dev->errata = 0;
>>> +
>>> +	if (cpu_is_omap2430() || cpu_is_omap34xx())
>>                      ^^^^^^^^ wont cpu_is_omap24xx() cover omap2420 as
>> well? I think it might be better using that.. apologies on
>> missing it in
>> the last look.
>
> This errata is not applicable for 2420 and it is applicable for:
> 1. omap2430
> 2. omap34xx(including omap3630).
>
> Sorry. My earlier patch was using this errata logic for all omap's
> except omap4 which was wrong(for omap2420 and omap1 - not sure, I don't have
> any data hence ignoring this errata for omap1 also).
>
Could you fix your commit message to state so instead of using OMAP2? 
thanks.. I think we are almost close to the final rev is Tony is ok as 
well.. Thanks for hanging in there..

[...]
Regards,
Nishanth Menon
