From: Jarkko Nikula <jarkko.nikula@jollamobile.com>
Subject: Re: [PATCH_v2] watchdog: Convert twl4030_wdt to watchdog core
Date: Thu, 27 Sep 2012 14:48:58 +0300
Message-ID: <50643D2A.7020402@jollamobile.com>
References: <20120910215946.GB26184@blackmetal.musicnaut.iki.fi> <1347343270-16881-1-git-send-email-jarkko.nikula@jollamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp160.iad.emailsrvr.com ([207.97.245.160]:55974 "EHLO
	smtp160.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab2I0LtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 07:49:00 -0400
In-Reply-To: <1347343270-16881-1-git-send-email-jarkko.nikula@jollamobile.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@jollamobile.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>

Hi

On 09/11/2012 09:01 AM, Jarkko Nikula wrote:
> Convert the twl4030_wdt watchdog driver to watchdog core.
>
> While at there use devm_kzalloc and set the default timeout in order to be
> able test this driver with a simple shell script.
>
> Signed-off-by: Jarkko Nikula<jarkko.nikula@jollamobile.com>
> Tested-by: Aaro Koskinen<aaro.koskinen@iki.fi>
> ---
> v2:
> - select WATCHDOG_CORE in Kconfig was accidentally put to to OMAP_WATCHDOG
>    instead of TWL4030_WATCHDOG. Thanks to Aaro Koskinen<aaro.koskinen@iki.fi>
>    for noticing.
> - Added Aaro's Tested-by
> ---
>   drivers/watchdog/Kconfig       |    1 +
>   drivers/watchdog/twl4030_wdt.c |  183 ++++++++--------------------------------
>   2 files changed, 35 insertions(+), 149 deletions(-)
>
Gentle ping if this got lost and if I need to repost, fix, etc.

-- 
Jarkko
