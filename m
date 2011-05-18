From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [RESEND PATCH 1/4] omap: igep0020: name refactoring for future
 merge with IGEP3
Date: Wed, 18 May 2011 12:05:08 +0300
Message-ID: <4DD38BC4.6080905@compulab.co.il>
References: <cover.1305235542.git.mike@compulab.co.il>	<d6dc9e334c729523f25993b7d610808e537ca74c.1305235542.git.mike@compulab.co.il>	<BANLkTikJaN=Q2RgrA7Hz-ye2BCOjNK42zA@mail.gmail.com>	<20110517075345.GQ5323@atomide.com>	<BANLkTikCgWxQoiYfS4O4+9jYCVBmcMAEOQ@mail.gmail.com> <20110517103352.GB27250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:45050
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752031Ab1ERJFO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 05:05:14 -0400
In-Reply-To: <20110517103352.GB27250@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: =?UTF-8?B?RW5yaWMgQmFsbGV0YsOyIGkgU2VycmE=?= <eballetbo@gmail.com>, Tony.Lindgren.tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

On 05/17/11 13:33, Tony Lindgren wrote:

> * Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [110517 00:53]:
>> Hi,
>>
>> 2011/5/17 Tony Lindgren <tony@atomide.com>:
>>> * Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [110516 10:11]:
>>>> Hi Mike,
>>>>
>>>> The only comment I wanted to do is maybe I prefer rename the
>>>> board-igep0020 to board-igep00x0 to be more generic. Apart from th=
is
>>>> these patch series looks good for me and has my ack. Thanks.
>>> I suggest we do the rename separately later on. Otherwise it
>>> easily gets classified as "crazy churn" type of patch, so best
>>> to stick to just code coalescing and fixes for this merge window.
>> Ok, so Mike you've my ack, thanks
> Thanks, applying these to devel-cleanup for the upcoming merge
> window.

You mean for-next? Or you've just forgot to update the devel-cleanup?


--=20
Regards,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
