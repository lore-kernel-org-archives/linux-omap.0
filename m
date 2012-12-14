From: Jarkko Nikula <jarkko.nikula@jollamobile.com>
Subject: Re: [PATCH_v2] watchdog: Convert twl4030_wdt to watchdog core
Date: Fri, 14 Dec 2012 09:35:19 +0200
Message-ID: <50CAD6B7.6060303@jollamobile.com>
References: <20120910215946.GB26184@blackmetal.musicnaut.iki.fi> <1347343270-16881-1-git-send-email-jarkko.nikula@jollamobile.com> <50643D2A.7020402@jollamobile.com> <20120927212312.GJ16482@spo001.leaseweb.com> <20121214012828.GB402@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp180.iad.emailsrvr.com ([207.97.245.180]:40805 "EHLO
	smtp180.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab2LNHnN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 02:43:13 -0500
In-Reply-To: <20121214012828.GB402@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>

Hi

On 12/14/2012 03:28 AM, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Sep 27, 2012 at 11:23:12PM +0200, Wim Van Sebroeck wrote:
>>> On 09/11/2012 09:01 AM, Jarkko Nikula wrote:
>>>> Convert the twl4030_wdt watchdog driver to watchdog core.
>>>>
>>>> While at there use devm_kzalloc and set the default timeout in order to be
>>>> able test this driver with a simple shell script.
>>>>
>>>> Signed-off-by: Jarkko Nikula<jarkko.nikula@jollamobile.com>
>>>> Tested-by: Aaro Koskinen<aaro.koskinen@iki.fi>
>> on my todo list.
> Will this patch get into 3.8? I did not yet see it
> in linux-watchdog-next.git.
I've been wondering the same. How to get forward with this patch?

-- 
Jarkko
