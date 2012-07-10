From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
Date: Tue, 10 Jul 2012 11:20:22 +0530
Message-ID: <CAMQu2gxZz+wfucuzFbJoREitkynzVpW90azHnxANmrcDzO2UXg@mail.gmail.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
 <873950x4ng.fsf@ti.com> <4FFB6789.2000100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:58867 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753059Ab2GJFuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jul 2012 01:50:44 -0400
Received: by qcpx40 with SMTP id x40so7063501qcp.12
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 22:50:42 -0700 (PDT)
In-Reply-To: <4FFB6789.2000100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, tony@atomide.com, R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 10, 2012 at 4:51 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Kevin,
>
> On 07/09/2012 11:47 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> From: R Sricharan <r.sricharan@ti.com>
>>>
>>> OMAP socs has a legacy and a highlander version of the
>>> 32k sync counter IP. The register offsets vary between the
>>> highlander and the legacy scheme. So use the 'SCHEME'
>>> bits(30-31) of the revision register to distinguish between
>>> the two versions and choose the CR register offset accordingly.
>>
>> Do these scheme bits exist on *all* OMAPs?  including OMAP1?
>>
>> This driver is used on OMAP1 as well as OMAP2+.
>>
>> The cover letter says this was only build tested on OMAP1 so I suggest
>> this actually be tested on OMAP1 before merging.
>
> I have tested this on an omap5912 osk. I booted and verified that the
> offset is good.
>
> Santosh, add my tested-by for OMAP1 ...
>
> Tested-by: Jon Hunter <jon-hunter@ti.com>
>
Thanks a lot Jon. I don't have OMAP1 hardware and hence
couldn't do boot testing.

I have already sent out PULL request to Tony. if he has not already
pulled I should be able to update the OMAP1 tested by tag.

Regards
Santosh
