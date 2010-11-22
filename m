From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Mon, 22 Nov 2010 10:25:46 -0600
Message-ID: <4CEA998A.7060406@ti.com>
References: <87tyjey6h3.fsf@deeprootsystems.com> <4CE55A88.6010300@ti.com> <20101118175215.GE9264@atomide.com> <AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com> <20101118182752.GI9264@atomide.com> <AANLkTi=m1MXATmUzXNxbggoUS01AbyeGZm9WMgWUqdNo@mail.gmail.com> <AANLkTikztB6aSir83P4odPznmvXGvq0uzYhRN2UWC1Dr@mail.gmail.com> <92CDD168D1E81F4F9D3839DC45903FC6A5E5A085@dlee03.ent.ti.com> <20101122100716.GC26003@nokia.com> <87bp5hz6og.fsf@deeprootsystems.com> <20101122162224.GH26003@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33546 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980Ab0KVQZv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 11:25:51 -0500
Received: by mail-qw0-f49.google.com with SMTP id 6so116901qwd.22
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 08:25:50 -0800 (PST)
In-Reply-To: <20101122162224.GH26003@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "ext Derrick, David" <dderrick@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Pihet-XID, Jean" <j-pihet@ti.com>

Peter 'p2' De Schrijver had written, on 11/22/2010 10:22 AM, the following:
[...]
>>> The root cause for the DLL not locking has been found though and a
>>> workaround implemented. So it should work now :) 
>> Is the workaround for this reflected in Nishanth's series?
> 
> No. It seems not. The workaround needs VDD2 voltage scaling which seems
> to be missing now from l-o ?

yep, that is correct - we dont have dvfs/OPP/voltage scaling in 
kernel.org as of today - until we have those, it might not be possible 
to push the "real workaround". the mentioned patch is, as documented, 
support for the voltage workaround.

-- 
Regards,
Nishanth Menon
