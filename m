From: Maciej Purski <m.purski@samsung.com>
Subject: Re: Regression in Linux next again
Date: Wed, 30 May 2018 16:03:15 +0200
Message-ID: <20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11~zcQzVKtj30757607576eucas1p2V@eucas1p2.samsung.com>
References: <20180529221501.GJ5702@atomide.com>
        <CGME20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61@epcas4p2.samsung.com>
        <20180530091314.GB6920@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530091314.GB6920@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>
List-Id: linux-omap@vger.kernel.org


On 05/30/2018 11:13 AM, Mark Brown wrote:
> On Tue, May 29, 2018 at 03:15:01PM -0700, Tony Lindgren wrote:
> 
>> I think I bisected this same issue for the second time now
>> but for a different merge window. What's up with that?
> 
> Last time we just reverted it as Maciej was unable to reproduce your
> problem, he's tried again with some alterations.
> 
>> Reverting both patches fixes the issue for me. I could
>> not debug it further because of the compile error(s).
> 
> OK, unless this gets fixed really quickly I'll revert again.
> 

I'm afraid, I have no idea, how to fix it quickly. You can revert it and
in the next version I'll fix the build error and split the last patch even
more, so we could perform a more precise bisection. I'd be grateful if you
could push it on your test coupled branch and Tony could test it again before
merging it with next again.

Best regards,

Maciej Purski
