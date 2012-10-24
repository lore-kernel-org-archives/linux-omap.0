From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
Date: Wed, 24 Oct 2012 18:19:29 +0530
Message-ID: <5087E3D9.6040007@ti.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com> <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932517Ab2JXMtr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 08:49:47 -0400
In-Reply-To: <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 24 October 2012 05:32 PM, Grazvydas Ignotas wrote:
> On Tue, Oct 23, 2012 at 9:09 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> From: Kevin Hilman <khilman@ti.com>
>>
>> When debounce clocks are disabled, ensure that the banks
>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>> subsequent off-mode transition will restore previous value from the
>> shadow copies (bank->context.debounce*) leading to mismatch state
>> between driver state and hardware state.
>
> This doesn't look right to me, aren't you effectively disabling
> debounce forever here? _gpio_dbck_disable is called from
> omap_gpio_runtime_suspend() and nothing will ever restore
> dbck_enable_mask back to what it was set by _set_gpio_debounce and
> debounce functionality is lost.
>
As per commit log, the issue seen with request->debounce->free()
sequence and hence on free, debounce state needs to be cleared.
Next gpio_set_debounce() should set the debounce mask right so
the patch seems to be right.

>>
>> This was discovered when board code was doing
>>
>>    gpio_request_one()
>>    gpio_set_debounce()
>>    gpio_free()
>>
>> which was leaving the GPIO debounce settings in a confused state.
>> Then, enabling off mode causing bogus state to be restored, leaving
>> GPIO debounce enabled which then prevented the CORE powerdomain from
>> transitioning.
>>

But there is one more case which might break because of this patch.
As part of idle, we might end up with below without gpio_free()
omap2_gpio_prepare_for_idle()
  ->pm_runtime_put_sync_suspend()
   -> omap_gpio_runtime_suspend()
    ->_gpio_dbck_disable()

And last call will clear the debounce mask state which will lost and
hence the debounce clock won't be enabled on resume.

I let Kevin comment whether this is the valid case or not.

Regards
Santosh


