From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v7 00/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Thu, 25 Nov 2010 11:50:58 +0530
Message-ID: <AANLkTi=X8+qZzX_bVxJyT130kbpc2_28skspm-N8kyAM@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <87lj4i2nb2.fsf@deeprootsystems.com>
 <AANLkTi=wXjf9m-RTxnzTjP0H8EpjtG1529a6Ch2zbt6Z@mail.gmail.com> <AANLkTin6Sp1k-1sYYrRLc4T7z8gv9MgUOc7Yp8S3B53x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34675 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab0KYGVj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 01:21:39 -0500
Received: by mail-iw0-f170.google.com with SMTP id 6so718439iwn.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 22:21:38 -0800 (PST)
In-Reply-To: <AANLkTin6Sp1k-1sYYrRLc4T7z8gv9MgUOc7Yp8S3B53x@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

On Thu, Nov 25, 2010 at 11:49, Kevin Hilman <khilman@deeprootsystems.co=
m> wrote:
> Hi Charu,
>
> [...]
>
>>>
>>> Please be sure your board file changes are updated for the board fi=
le
>>> changes in the devel-board branch.
>>
>> Okay. But if it is different, should I send only the board files cha=
nges on
>> devel-board =A0branch as a separate patch mentioning the dependencie=
s on
>> my patch series?
>>
>
> My pm-core includes the devel-board branch since it's part of Tony's
> for-next, so that shouldn't be necessary.
>
> However, if you find it's easier to break it into separate series fee=
l
> free, as long as the dependencies are mentioned.

Okay. Thanks.

>
> Thanks,
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
