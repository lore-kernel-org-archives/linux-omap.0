From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: suspend broken on 3.5-rc1?
Date: Thu, 12 Jul 2012 10:57:37 +0530
Message-ID: <4FFE6049.7040908@ti.com>
References: <4FD1D570.1010508@ti.com>	<20120608105611.GO12766@atomide.com>	<4FD1EF25.3060906@ti.com>	<1339160732.2091.47.camel@sokoban>	<4FD1FB47.8040007@ti.com>	<4FD72FB7.60905@ti.com>	<CALLhW=5HUJuUbEoz7GXJ3h75iqB_9_bNrofBU45zKQejkKExAQ@mail.gmail.com>	<87mx36ht3y.fsf@ti.com> <CALLhW=7FwtPy0_u863fH7-nSMW4AvxuqHvNeO2CqtF3aJEgh4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:40778 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751355Ab2GLF1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 01:27:45 -0400
Received: by obbuo13 with SMTP id uo13so2771631obb.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 22:27:43 -0700 (PDT)
In-Reply-To: <CALLhW=7FwtPy0_u863fH7-nSMW4AvxuqHvNeO2CqtF3aJEgh4Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>

On Thursday 12 July 2012 05:28 AM, Omar Ramirez Luna wrote:
> I suspect this might be specific to 4460 as Rajendra reported it was
> working for him on 4430 but not on 4460, I haven't tried 4430 but let
> me see if I can find one.

Yes, this is an issue specific to 4460. The patch 'ARM: OMAP4460:
Workaround for ROM bug because of CA9 r2pX GIC control register change'
from Tero's Core retention series [1] fixes it. Unfortunately the patch
does not apply on it own and has dependencies with other patches in the
series.

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/78399
