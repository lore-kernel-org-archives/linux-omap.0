From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq
 handlers
Date: Tue, 06 Sep 2011 13:13:21 -0700
Message-ID: <4E667EE1.1020808@ti.com>
References: <1314900722-10252-1-git-send-email-khilman@ti.com> <1876183.c78P8V3ZbL@wuerfel> <201109012357.39873.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:44570 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754728Ab1IFUNY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 16:13:24 -0400
Received: by mail-yi0-f41.google.com with SMTP id 2so4061311yib.28
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 13:13:24 -0700 (PDT)
In-Reply-To: <201109012357.39873.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On 09/01/2011 02:57 PM, Rafael J. Wysocki wrote:
> On Thursday, September 01, 2011, Arnd Bergmann wrote:
>> On Thursday 01 September 2011 11:12:02 Kevin Hilman wrote:
>>> The suspend/resume _noirq handlers were #ifdef'd out in the
>>> !CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
>>> struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.
>>>
>>> Reported-by: Arnd Bergmann<arnd@arndb.de>
>>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>>
>> Acked-by: Arnd Bergmann<arnd@arndb.de>
>>
>> Thansk for the fast response!
>
> I'll apply the patch when kernel.org is back in order.
>

Tony,

I spoke w/Rafael and due to hera being down and Rafael traveling to LPC 
he wont be able to queue this for v3.1.  Can you queue up this fix? 
This needs to go in to v3.1-rc.

Thanks,

Kevin
