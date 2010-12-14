From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 05/12] OMAP4: PRCM: Add SCRM header file
Date: Tue, 14 Dec 2010 21:16:37 +0100
Message-ID: <4D07D0A5.9040703@ti.com>
References: <20101214063308.21555.76050.stgit@twilight.localdomain> <20101214063447.21555.64470.stgit@twilight.localdomain> <4D07782E.5050000@ti.com> <alpine.DEB.2.00.1012141105570.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41392 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756853Ab0LNUQp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 15:16:45 -0500
In-Reply-To: <alpine.DEB.2.00.1012141105570.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

On 12/14/2010 7:13 PM, Paul Walmsley wrote:
> On Tue, 14 Dec 2010, Cousson, Benoit wrote:
>
>> This patch will conflict with your power prcm series, because you are creating
>> an empty scrm44xx.h in it.
>>
>> So I did rebased this series on top on your prcm to fix that.
>>
>> Don't you want to use the already rebased version instead?
>
> I would rather have patches and branches based on mainline commits where
> possible.  If a series has some explicit dependency on a non-mainline
> patch or branch then I'd like to know about it in the messages if
> possible.

Well, I sent this series before you sent your prcm one, so at the time 
the dependency didn't exist ;-)

> As far as the empty scrm44xx.h goes, I will probably go back and rebuild
> that branch with your patch that creates SCRM from my patch set inserted
> earlier, so I can drop the part of my patch that creates the empty file.

OK good for me.

Thanks,
Benoit
