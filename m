From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Wed, 24 Nov 2010 11:21:15 -0600
Message-ID: <4CED498B.3020201@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<87r5edp3so.fsf@deeprootsystems.com>	<8ef3de873d51409a38f19becb0d339cb@mail.gmail.com>	<87pqtveq1e.fsf@deeprootsystems.com>	<dfe358793629e4b10d1a5007fb273164@mail.gmail.com> <AANLkTi=ag81g-0iYdtAAp=tO8rUyoeE48MSnA595_daB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:42974 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960Ab0KXRVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 12:21:19 -0500
Received: by mail-yw0-f43.google.com with SMTP id 4so799213ywp.2
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 09:21:19 -0800 (PST)
In-Reply-To: <AANLkTi=ag81g-0iYdtAAp=tO8rUyoeE48MSnA595_daB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Jean Pihet had written, on 11/24/2010 11:11 AM, the following:
[...]
> When the code is split into the pure sleep code and the secure code
> parts, I would like to have the sleep code part cleaned up.
> BTW I rebased my clean-up patch on top of the 13 patches you sent and
> performed some testing. It is working OK AFAICT (also stands for "As
> far as I can test" TM).
I could help with testing on EMU zoom3 and SDP3430 If you could host a 
tree somewhere. Maybe some folks could pitch in for testing with N900 
which has HS device as well.

> 
> Can this happen before the .38 merge window?
I plan to work on this set over the next week - hopefully we can do the 
testing and posting by then. will probably post offline my initial 
versions for sync up.

-- 
Regards,
Nishanth Menon
