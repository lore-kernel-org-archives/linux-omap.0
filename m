From: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Subject: Re: MMC3 Overo
Date: Thu, 06 Aug 2009 16:44:36 +0200
Message-ID: <4A7AEC54.107@nt.tu-darmstadt.de>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>	<bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>	<bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>	<873a866xdo.fsf@deeprootsystems.com>	<bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>	<5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>	<4A79C83E.9040603@deeprootsystems.com>	<5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>	<4A79D104.60607@deeprootsystems.com>	<bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>	<bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com> <871vnp8170.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:50836 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbZHFOok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 10:44:40 -0400
Received: from [192.168.1.22] (p50996ded.dip0.t-ipconnect.de [80.153.109.237])
	by post.strato.de (klopstock mo51) (RZmta 20.2)
	with ESMTP id a04032l76EOU4e for <linux-omap@vger.kernel.org>;
	Thu, 6 Aug 2009 16:44:37 +0200 (MEST)
In-Reply-To: <871vnp8170.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman wrote:

>>         AB1_35XXCBB_MMC3_CLK
>>         AF10_35XXCBB_MMC3_CLK
>>         R9_35XXCBC_MMC3_CLK
>>         AB2_35XXCBC_MMC3_CLK
>>         AC1_35XXCUS_MMC3_CLK
>>  We would then have to update mux.c making sure the position matches
>>  and add the proper settings.
>>
>>  So this is obviously a maintenance nightmare.
>
> So why don't we drop the ball (pun intended.) ;)
>
> This is what I proposed to Phillip Ballister for his SPI changes for Beagle.
>
> Though I haven't looked at the details for each package, I have a hard
> time imagining that the reg offsets and functionality for each package
> is different.  In fact, I'm pretty sure they're even the same between
> 34xx and 35xx.
>
> IOW, why not just name it OMAP3_MMC3_CLK and have a single entry.
>
> Then each board file that cares simply has to call omap_cfg_reg() on
> that name and not care about the package.

even for 1 package, how will you know whether OMAP3_MMC3_CLK is connected
to ball AB1 or AF10 as both is possible...

