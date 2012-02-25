From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP3: Mark only those mmc devices which use
 gpio_cd, as deferred
Date: Sat, 25 Feb 2012 10:00:19 +0530
Message-ID: <4F4863DB.9090702@ti.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com> <1330077537-19618-5-git-send-email-rnayak@ti.com> <20120224222136.GB18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34566 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753888Ab2BYEa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 23:30:28 -0500
Received: by mail-pw0-f45.google.com with SMTP id ro12so3503974pbb.32
        for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 20:30:25 -0800 (PST)
In-Reply-To: <20120224222136.GB18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 25 February 2012 03:51 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120224 01:27]:
>> mmc devices which actually do not depend on twl4030-gpio for
>> gpio_cd should not be maked as deferred.
>>
>> Also on overo, since none of the mmc devices need to be deferred,
>> get rid of omap_hsmmc_late_init() altogether.
>>
>> Reported-by: Igor Grinberg<grinberg@compulab.co.il>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> Thanks, I'll fold this into the original patch with your SOB
> so we avoid the extra churn.

okay, thanks.

>
> Regards,
>
> Tony

