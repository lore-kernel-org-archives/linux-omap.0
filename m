From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 7/32] mmc: add host capabilities for SD only and MMC	only
Date: Sat, 25 Jul 2009 22:45:07 +0300
Message-ID: <4A6B60C3.3070609@nokia.com>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower> <20090710124054.1262.18902.sendpatchset@ahunter-tower> <20090725155336.GA12665@console-pimps.org> <4A6B300A.10706@nokia.com> <20090725184030.GB12665@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16770 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZGYTop (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jul 2009 15:44:45 -0400
In-Reply-To: <20090725184030.GB12665@console-pimps.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Pierre Ossman <pierre@ossman.eu>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "Karpov Denis.2 (EXT-Teleca/Helsinki)" <ext-denis.2.karpov@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Matt Fleming wrote:
> On Sat, Jul 25, 2009 at 07:17:14PM +0300, Adrian Hunter wrote:
>> Matt Fleming wrote:
>>> And by saying what capabilities a host supports, when we add new
>>> capabilities we don't have to modify existing code to say that it
>>> doesn't support the new capability.
>> If the capabilities are the other way around, then all existing drivers
>> must be changed.  On the other hand, the if statement can easily be
>> improved:
>>
>> #define mmc_cap_mmc(host) (!((host)->caps & MMC_CAP_NOT_MMC))
>> #define mmc_cap_sd(host) (!((host)->caps & MMC_CAP_NOT_SD))
>> #define mmc_cap_sdio(host) (!((host)->caps & MMC_CAP_NOT_SDIO))
>>
>> -	mmc_send_if_cond(host, host->ocr_avail);
>> +	if (mmc_cap_sdio(host) || mmc_cap_sd(host))
>> +		mmc_send_if_cond(host, host->ocr_avail);
>> +
> 
> OK, that's a fair point, all drivers would need to be changed. However,
> I'm not adverse to making a one-time change to all drivers in the name
> of sanity. Enumerating what cards a controller doesn't support just
> doesn't sound correct to me.
> 
> It wouldn't be a complicated change either, I'd even be happy to write
> the patch ;-)

I have no objections if you write such a patch :-)

