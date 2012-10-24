From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
Date: Wed, 24 Oct 2012 20:08:52 +0530
Message-ID: <5087FD7C.1000006@ti.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com> <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com> <87pq4854wu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34167 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934928Ab2JXOjK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 10:39:10 -0400
In-Reply-To: <87pq4854wu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 24 October 2012 07:49 PM, Kevin Hilman wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>
>> On Tue, Oct 23, 2012 at 9:09 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> From: Kevin Hilman <khilman@ti.com>
>>>
>>> When debounce clocks are disabled, ensure that the banks
>>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>>> subsequent off-mode transition will restore previous value from the
>>> shadow copies (bank->context.debounce*) leading to mismatch state
>>> between driver state and hardware state.
>>
>> This doesn't look right to me, aren't you effectively disabling
>> debounce forever here? _gpio_dbck_disable is called from
>> omap_gpio_runtime_suspend() and nothing will ever restore
>> dbck_enable_mask back to what it was set by _set_gpio_debounce and
>> debounce functionality is lost.
>
> Yes, you're right.   Good catch.
>
> I need a fix that's more targetted to the free/reset path.
>
Right. Just clearing the debounce mask in omap_gpio_free()
should do the trick.

Regards
Santosh

