From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: omap2: fix build failure
Date: Thu, 17 Nov 2011 11:36:33 -0800
Message-ID: <87aa7u4k3i.fsf@ti.com>
References: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com>
	<87mxc61kpw.fsf@ti.com>
	<CACVXFVMtaiFiKSRh8geVpOzymtZsaUKc9tDHfgJYR57N+RQZ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:44189 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752580Ab1KQTgl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 14:36:41 -0500
Received: by mail-ey0-f180.google.com with SMTP id 5so3644637eyg.25
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 11:36:39 -0800 (PST)
In-Reply-To: <CACVXFVMtaiFiKSRh8geVpOzymtZsaUKc9tDHfgJYR57N+RQZ-g@mail.gmail.com>
	(Ming Lei's message of "Thu, 17 Nov 2011 11:00:18 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:

> On Wed, Nov 9, 2011 at 3:24 AM, Kevin Hilman <khilman@ti.com> wrote:
>> tom.leiming@gmail.com writes:
>>
>>> From: Ming Lei <tom.leiming@gmail.com>
>>>
>>> The patch fixes the compile failure:
>>>
>>> =C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/arm/mach-omap2/cpuidle34xx.o
>>> arch/arm/mach-omap2/cpuidle34xx.c:317:12: error: 'THIS_MODULE'
>>> undeclared here (not in a function)
>>> make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
>>> make: *** [arch/arm/mach-omap2] Error 2
>>> make: *** Waiting for unfinished jobs....
>>>
>>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>>
>> FYI...
>>
>> Tony has already queued fix for this in his fixes branch.
>>
>> =C2=A0 =C2=A0 http://marc.info/?l=3Dlinux-arm-kernel&m=3D13207103662=
1713&w=3D2
>
> The fix is not merged into 3.2.0-rc2-next-20111116+ yet...

OK, but that doesn't mean you have to keep sending it.  It just means
Tony's fixes branch isn't in -next (yet.)

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
