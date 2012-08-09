From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Register the OPP table only for 4430
 device
Date: Thu, 09 Aug 2012 12:53:28 +0530
Message-ID: <50236570.6030301@ti.com>
References: <1344423254-3475-1-git-send-email-rnayak@ti.com> <1344423254-3475-3-git-send-email-rnayak@ti.com> <87628twbd3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:56542 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755305Ab2HIHXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 03:23:34 -0400
Received: by obbun3 with SMTP id un3so316943obb.13
        for <linux-omap@vger.kernel.org>; Thu, 09 Aug 2012 00:23:33 -0700 (PDT)
In-Reply-To: <87628twbd3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Wednesday 08 August 2012 10:48 PM, Kevin Hilman wrote:
>> The 4430 OPP table was being registered for all other OMAP4 variants
>> >  too, like 4460 and 4470 causing issues with cpufreq driver
>> >  enabled. 4460 and 4470 devices have different OPPs as compared to
>> >  4430, and they should be populated seperately. As long as that
>> >  happens, let the OPP table registeration happen only on 4430 device.
>> >
>> >  Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Thanks, adding to PM fixes for v3.6-rc (branch: for_3.6/fixes/pm)

I just posted a v2 of this series addressing the issues raised by
Santosh on Patch 1/2. The problem with taking just $subject fix (or
taking it before Patch 1/2) is that you would hit the issue fixed
by the Patch 1/2 and cause a crash on non-4430 based OMAP4 devices with
cpufreq enabled.

regards,
Rajendra

