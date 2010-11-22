From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Mon, 22 Nov 2010 12:31:20 -0600
Message-ID: <4CEAB6F8.4090005@ti.com>
References: <87tyjey6h3.fsf@deeprootsystems.com> <4CE55A88.6010300@ti.com>	<20101118175215.GE9264@atomide.com>	<AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>	<20101118182752.GI9264@atomide.com>	<AANLkTi=m1MXATmUzXNxbggoUS01AbyeGZm9WMgWUqdNo@mail.gmail.com>	<AANLkTikztB6aSir83P4odPznmvXGvq0uzYhRN2UWC1Dr@mail.gmail.com>	<92CDD168D1E81F4F9D3839DC45903FC6A5E5A085@dlee03.ent.ti.com>	<20101122100716.GC26003@nokia.com>	<87bp5hz6og.fsf@deeprootsystems.com>	<20101122162224.GH26003@nokia.com> <4CEA998A.7060406@ti.com> <87tyj9tdxy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40207 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756567Ab0KVSbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 13:31:36 -0500
Received: by mail-pw0-f53.google.com with SMTP id 3so2568680pwj.26
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 10:31:27 -0800 (PST)
In-Reply-To: <87tyj9tdxy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "ext Derrick, David" <dderrick@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Pihet-XID, Jean" <j-pihet@ti.com>

Kevin Hilman had written, on 11/22/2010 12:23 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Peter 'p2' De Schrijver had written, on 11/22/2010 10:22 AM, the following:
>> [...]
>>>>> The root cause for the DLL not locking has been found though and a
>>>>> workaround implemented. So it should work now :) 
>>>> Is the workaround for this reflected in Nishanth's series?
>>> No. It seems not. The workaround needs VDD2 voltage scaling which seems
>>> to be missing now from l-o ?
>> yep, that is correct - we dont have dvfs/OPP/voltage scaling in
>> kernel.org as of today - until we have those, it might not be possible
>> to push the "real workaround". the mentioned patch is, as documented,
>> support for the voltage workaround.
> 
> It would be worth noting other known issues that are not worked around
> in this series due to external dependencies.
I believe I have done that
http://marc.info/?l=linux-omap&m=129013172525234&w=2
"IMPORTANT: this is not a complete workaround implementation as recommended
by the silicon errata. this is a support logic for detecting lockups and
attempting to recover where possible and is known to provide stability
in multiple platforms.
"

> 
> Also, is the current SR/voltage series as proposed capable of handling
> the workaround for this fix?
I believe a new series is due sometime- we should see if the required 
changes are part of that series.

Regards,
Nishanth Menon
