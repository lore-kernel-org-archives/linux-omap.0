From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 8/8] ARM: DRA7: Kconfig: Increase the default gpio count
Date: Tue, 16 Jul 2013 10:51:44 +0530
Message-ID: <51E4D868.8010609@ti.com>
References: <1373354873-12359-1-git-send-email-rnayak@ti.com> <1373354873-12359-9-git-send-email-rnayak@ti.com> <51E29482.7060208@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60768 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab3GPFWQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jul 2013 01:22:16 -0400
In-Reply-To: <51E29482.7060208@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, benoit.cousson@gmail.com, ambresh@ti.com

On Sunday 14 July 2013 05:37 PM, Kevin Hilman wrote:
> On 07/09/2013 08:27 AM, Rajendra Nayak wrote:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> DRA7xx has 8 GPIO banks so that there are 32x8 = 256 GPIOs.
>> In order for the gpiolib to detect and initialize these
>> additional GPIOs and other TWL GPIOs, ARCH_NR_GPIO is set
>> to 512 instead of present 256.
> nit: the patch itself doesn't change 256 to 512, but just adds another
> Kconfig default.
>
> Kevin
 hmm, ok. Will reword the $subject and commit accordingly

Regards,
 Sricharan
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 5ef7af0..9faed52 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1599,7 +1599,7 @@ config LOCAL_TIMERS
>>  config ARCH_NR_GPIO
>>  	int
>>  	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
>> -	default 512 if SOC_OMAP5
>> +	default 512 if SOC_OMAP5 || SOC_DRA7XX
>>  	default 512 if ARCH_KEYSTONE
>>  	default 392 if ARCH_U8500
>>  	default 352 if ARCH_VT8500
>>

