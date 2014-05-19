From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 06/11] ARM: OMAP2+: Fix voltage scaling init for device
 tree
Date: Mon, 19 May 2014 13:52:18 -0500
Message-ID: <537A52E2.6080601@ti.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>	<1397173639-29587-7-git-send-email-tony@atomide.com>	<CAGhQ9VxS+Hg6EX=CDxbibV2TFw++LwZY+GQomZEHx--JGuWHNg@mail.gmail.com>	<20140519180104.GL4849@atomide.com>	<CAGo_u6oGHFAFimYSc8Utgbp=oCahXzO0ZoYjhFgOkT3YkppS6A@mail.gmail.com> <CAGhQ9Vw38vJCS5TGRMz0MMif15narY=9=C8-vwzGuGormhwcYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53596 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbaESSwo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 14:52:44 -0400
In-Reply-To: <CAGhQ9Vw38vJCS5TGRMz0MMif15narY=9=C8-vwzGuGormhwcYw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 05/19/2014 01:48 PM, Joachim Eastwood wrote:
[...]
>> we can add TPS data here for 4460 mpu (panda-ES) if that is
>> interesting to us - given that the common voltage domain/VC/VP stuff
>> so far has gone in no positive direction in our discussions last year.
> 
> If this means that voltage scaling and 1.5GHz would work for 4460 it
> would make me very happy :)
> But I assume that would bring lots of more code into mach-omap2 which
> wouldn't be good either. Escaping the old 3.4 kernel would be nice,
> though.
Not really.. we cannot make 1.5GHz work without ABB integration into
the transition sequence[1] - what we can try to do is make basic dvfs
work. the approach we'd be taking (if we introduce tps handlers) is to
do exactly what we did in 3.0/3.4 kernels. I am not too happy with
that. instead, I would prefer we skip dvfs for 4460(which was never
working in upstream) and do it the *right* way - which ever the
upstream maintainers want it to be. that is my personal 2 cents.

[1] last attempt:
http://marc.info/?l=linux-omap&m=139275579731801&w=2 (patch 1-5).
Blocked at:
http://marc.info/?l=linux-arm-kernel&m=139526861215152&w=2

-- 
Regards,
Nishanth Menon
