From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary
 CPUs are offline.
Date: Fri, 03 Jun 2011 17:35:01 +0530
Message-ID: <4DE8CDED.5060504@ti.com>
References: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com> <87ei3bomn3.fsf@ti.com> <4DE87E78.6000107@ti.com> <4DE89BE6.40809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52495 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555Ab1FCMFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 08:05:06 -0400
Received: by mail-gw0-f54.google.com with SMTP id 15so1075438gwb.27
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 05:05:06 -0700 (PDT)
In-Reply-To: <4DE89BE6.40809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On 6/3/2011 2:01 PM, Santosh Shilimkar wrote:
> On 6/3/2011 11:56 AM, Santosh Shilimkar wrote:
>> On 6/3/2011 4:40 AM, Kevin Hilman wrote:

[...]

>> Can do that as well.
>>
> After re-looking at this, seems not straight forward. This check is
> not for cpufreqdriver_init time but per-CPU init functions which is
> called after the driver is registered to the governor. We don't do
> registration again except the cases where driver is build as a module.
>
> How do we handle that ?
Ignore this questions since mostly we don't need that anymore.
Will post and updated patch.

regards
Santosh
