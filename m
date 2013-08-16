From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] drivers/gpio/gpio-omap.c: convert comma to semicolon
Date: Fri, 16 Aug 2013 17:13:32 +0200
Message-ID: <CACRpkdYL8cOqM_S2LvZBHZPEG9_fGON0Ufb3FLN+0Wd4SVE9pg@mail.gmail.com>
References: <1376149225-3997-1-git-send-email-Julia.Lawall@lip6.fr>
	<1376149225-3997-2-git-send-email-Julia.Lawall@lip6.fr>
	<1376151231.2083.32.camel@joe-AO722>
	<87ob92rilt.fsf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <87ob92rilt.fsf@kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Joe Perches <joe@perches.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Santosh Shilimkar <santosh.shilimkar@ti.com>, kernel-janitors@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 12, 2013 at 6:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Joe Perches <joe@perches.com> writes:
>
>> On Sat, 2013-08-10 at 17:40 +0200, Julia Lawall wrote:
>>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>> Replace a comma between expression statements by a semicolon.
>> []
>>> I can't tell if the assignment to ct->regs.mask is really intended to be
>>> under the if.  The proposed patch preserves the current semantics, but not
>>> the current indentation.
>>
>> I'd suspect more that the indentation is correct
>> and the comma use incorrect.
>>
>> It also looks more like a copy/paste error from
>> commit f8b46b583 when the code was restructured
>> a bit.
>>
>> Kevin?
>
> Yes, looks like a copy/paste error.  The comma should simply be replaced
> by a semi-colon.

So can I have a patch for this? Pretty please...

Yours,
Linus Walleij
