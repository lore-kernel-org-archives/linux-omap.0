From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 18/22] gpio/omap: use pm-runtime framework
Date: Wed, 24 Aug 2011 11:49:12 +0530
Message-ID: <4E5497E0.4090004@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-19-git-send-email-tarun.kanti@ti.com> <4E53BA80.7030200@ti.com> <4E5477D0.9090301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:59835 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751018Ab1HXGTT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 02:19:19 -0400
Received: by mail-gy0-f169.google.com with SMTP id 10so763235gyg.14
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 23:19:18 -0700 (PDT)
In-Reply-To: <4E5477D0.9090301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Wednesday 24 August 2011 09:32 AM, Rajendra Nayak wrote:
> On 8/23/2011 8:04 PM, Santosh wrote:
>> + Rajendra and Benoit to comment on optional clock
>> handling.
>>
>> On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:

[....]

>>>
>>> + if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev)< 0))
>>> + dev_err(bank->dev, "%s: GPIO bank %d "
>>> + "pm_runtime_get_sync failed\n",
>>> + __func__, bank->id);
>>> +
>>> for (j = 0; j< hweight_long(bank->dbck_enable_mask); j++)
>>> clk_enable(bank->dbck);
>> Optional clock handling also should been addressed using runtime hooks,
>> isn't it ?
>
> Whats handled by runtime hooks is the device;s *main* clocks, which are
> needed for the device to become accessible.
> Anything else *optional* which the device would need optionally based on
> the various modes it can operate etc are still controlled by the driver
> by enabling/disabling them as and when needed using the clock framework.
>
Thanks Rajendra for clarification. In summary, we continue to use clock
framework for the optional clock handling from the drivers.

Regards
Santosh
