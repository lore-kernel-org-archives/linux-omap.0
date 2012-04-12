From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Remove un-used control module headers
 and defines.
Date: Thu, 12 Apr 2012 14:57:08 +0200
Message-ID: <4F86D124.8050405@ti.com>
References: <1330338743-24097-1-git-send-email-santosh.shilimkar@ti.com> <4F86AF0C.5060806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35496 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757496Ab2DLM5Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 08:57:16 -0400
In-Reply-To: <4F86AF0C.5060806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh,

On 4/12/2012 12:31 PM, Santosh Shilimkar wrote:
> Benoit,
>
> On Monday 27 February 2012 04:02 PM, Santosh Shilimkar wrote:
>> Most of the OMAP4 control module register defines are not used and
>> can be removed. Keep only needed defines and move them to common
>> control module header just like other OMAP versions.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> ---
>
> What do you think about this patch ?

I'm fine with it. I'm just wondering if we have to send it right now or 
along with the control module driver implementation we've just started.

Regards,
Benoit
