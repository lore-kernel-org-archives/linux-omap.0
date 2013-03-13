From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all CPU power states except off
Date: Wed, 13 Mar 2013 10:42:08 -0700
Message-ID: <874ngfrybz.fsf@linaro.org>
References: <1360745724-30058-1-git-send-email-santosh.shilimkar@ti.com>
	<513DBB60.3010406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:54417 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab3CMRmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 13:42:13 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so512361dal.26
        for <linux-omap@vger.kernel.org>; Wed, 13 Mar 2013 10:42:13 -0700 (PDT)
In-Reply-To: <513DBB60.3010406@ti.com> (Santosh Shilimkar's message of "Mon,
	11 Mar 2013 16:39:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Kevin,
>
> On Wednesday 13 February 2013 02:25 PM, Santosh Shilimkar wrote:
>> Current CPU PM code code make use of common cpu_suspend() path for all the
>> CPU power states which is not optimal. In fact cpu_suspend() path is needed
>> only when we put CPU power domain to off state where the CPU context is lost.
>> 
>> Update the code accordingly so that the expensive cpu_suspend() path
>> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
>> 
>> The patch has been tested on OMAP4430 and OMAP5430(with few out of tree patches)
>> devices for suspend and CPUidle.
>> 
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> 
>> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> Update changelog to include testing details as suggested
>> by Kevin Hilman.
>> 
> Ping.
> It can get into rc's but since it is not strict regression,
> and if it has to wait for 3.10 then I can add this one
> along with rest of the PM patches posted towards 3.10
>
> Either way, let me know.

I have this updated one queued for v3.10 in my PM cleanup branch
(for_3.10/cleanup/pm)

Kevin





