From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Remove un-used control module headers
 and defines.
Date: Mon, 16 Apr 2012 15:04:37 +0530
Message-ID: <4F8BE7AD.2040505@ti.com>
References: <1330338743-24097-1-git-send-email-santosh.shilimkar@ti.com> <4F86AF0C.5060806@ti.com> <4F86D124.8050405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:48842 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752511Ab2DPJen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 05:34:43 -0400
Received: by obhx4 with SMTP id x4so8762023obh.8
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 02:34:42 -0700 (PDT)
In-Reply-To: <4F86D124.8050405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 12 April 2012 06:27 PM, Cousson, Benoit wrote:
> Hi Santosh,
> 
> On 4/12/2012 12:31 PM, Santosh Shilimkar wrote:
>> Benoit,
>>
>> On Monday 27 February 2012 04:02 PM, Santosh Shilimkar wrote:
>>> Most of the OMAP4 control module register defines are not used and
>>> can be removed. Keep only needed defines and move them to common
>>> control module header just like other OMAP versions.
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> ---
>>
>> What do you think about this patch ?
> 
> I'm fine with it. I'm just wondering if we have to send it right now or
> along with the control module driver implementation we've just started.
> 
Let's do that as part of the driver implementation.

Regards
Santosh

