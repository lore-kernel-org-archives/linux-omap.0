From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Sat, 04 Apr 2015 01:47:07 +0300
Message-ID: <551F186B.90608@gmail.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com> <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com> <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com> <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com> <20150403163553.GA16247@earth> <551F0F50.1030701@gmail.com> <20150403221517.GX10805@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35228 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbDCWrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 18:47:11 -0400
Received: by widdi4 with SMTP id di4so118779123wid.0
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2015 15:47:10 -0700 (PDT)
In-Reply-To: <20150403221517.GX10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>


Hi,

> We should first verify the same bug happens with armel also.
> I just verified the CPU load in the background makes armhf
> apps segfault without $subject workaround enabled.
>
> If the segfaulting does not happen with armel, then chances
> it's some kind of neon related issue and the fix can be more
> targeted.
>
> Regards,
>
> Tony
>

I can assure you that at least SoC in N900 is affected by ARM errata 
430973, no matter armel or armhf. Though the crash is usually with 
SIGILL(because of the wrong T bit in CPSR the code is executed with), I 
don't remember seeing SIGSEGV, but that could be my ageing memory. I am 
the maintainer of the so-called cssu-thumb Fremantle upgrade [1], which 
is armel, thumb2 compiled, so I have some experience with the matter  :) 
. Without that errata workaround enabled in kernel, it is impossible to 
boot Fremantle with cssu-thumb on top. BTW it was the same back in the 
days when there was Ubuntu 12.04 for N900 - it was hardfp, thumb2 
compiled. Again, without that errata workaround enabled, there was no 
way to boot it.

Regards,
Ivo

[1] http://talk.maemo.org/showthread.php?t=84829
