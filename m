From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.12
Date: Tue, 27 Aug 2013 11:43:26 +0200
Message-ID: <521C74BE.9080404@baylibre.com>
References: <521384D5.1050607@baylibre.com> <20130821071334.GQ7656@atomide.com> <5214D4FD.4060405@baylibre.com> <87fvu0mf87.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:57817 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab3H0Jna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Aug 2013 05:43:30 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so1503830bkb.34
        for <linux-omap@vger.kernel.org>; Tue, 27 Aug 2013 02:43:29 -0700 (PDT)
In-Reply-To: <87fvu0mf87.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On 23/08/2013 20:31, Kevin Hilman wrote:
> Benoit Cousson <bcousson@baylibre.com> writes:
>
>> Hi Kevin & Olof,
>>
>> I've just updated the branch with the few USB3 patches I missed from Felipe.
>>
>> So here is a new pull-request.
>>
>> Thanks,
>> Benoit
>>
>> ----------------------------------------------------------------
>> Add the minimal DTS support for DRA7xx based SoC core.
>> Add the initial support for N900 and gta04 phones.
>> Enable USB3 on OMAP5 evm board.
>> Do a lot of various cleanups.
>> ----------------------------------------------------------------
>
> This is a nice description, but would be even better if it was the
> description of the signed tag.  For future pulls, since we're pulling
> from you directly into arm-soc, can you start using signed tags please?
>
>
>> The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:
>>
>>    Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.12/dts
>>
>> for you to fetch changes up to 5903208d4e2c09a3872feba6b9e2e49c64fd07ad:
>>
>>    ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies (2013-08-21 16:43:21 +0200)
>>
>
> Pulled into next/dt.

Thanks.

> Benoit, since we're pulling directly from you into arm-soc, can you
> start using signed tags please?  Thanks.

OK, no problem, I'll RTFM to see how it works and do that next time.

Regards,
Benoit


