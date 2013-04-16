From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: Re: [RFC PATCH v2 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Tue, 16 Apr 2013 14:28:06 +0300
Message-ID: <516D35C6.2080606@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com> <1366032491-4162-6-git-send-email-andrii.tseglytskyi@ti.com> <20130415164316.6507.66311@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42472 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab3DPL2J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Apr 2013 07:28:09 -0400
In-Reply-To: <20130415164316.6507.66311@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-omap@vger.kernel.org, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

Hi Mike,

On 04/15/2013 07:43 PM, Mike Turquette wrote:
> Quoting Andrii Tseglytskyi (2013-04-15 06:28:10)
>> Cc: Mike Turquette <mturquette@linaro.org>
>>
>> Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> It is very strange to Cc me and include my Signed-off-by.  Go ahead and
> drop my SoB.  I'll review these patches this week but I don't think
> implicitly including my SoB is appropriate.
OK. I'll drop your Signed-off-by

> Also why is this limited to LOML?  Cc LKML and Mark Brown (regulator
> maintainer) on the next version.  More eyeballs on the code is better.
>
> Finally I also suggest that you rename this patch to:
>
> "regulator: introduce omap abb driver"
OK.

> As we move stuff out of arch/arm it's important to loop in wider mailing
> lists, Cc the appropriate maintainers and title patches more
> appropriately.
I'm going to post next patch series to wider mailing lists.
Before doing this I prefer to finish at least one review cycle with you.

Thank you.

Regards,
Andrii
