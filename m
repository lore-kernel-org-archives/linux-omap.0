From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC 01/23] gpio/omap: raw read and write endian fix
Date: Tue, 19 Nov 2013 10:12:55 -0800
Message-ID: <87mwl0mfa0.fsf@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
	<1384560086-11994-2-git-send-email-taras.kondratiuk@linaro.org>
	<CACRpkdYD-Yw+RFnX0GshyQn2oHYNnXXRF4RXTzCox=2Z0_gKqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:65282 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab3KSSM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 13:12:59 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so4117008pdj.29
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 10:12:59 -0800 (PST)
In-Reply-To: <CACRpkdYD-Yw+RFnX0GshyQn2oHYNnXXRF4RXTzCox=2Z0_gKqg@mail.gmail.com>
	(Linus Walleij's message of "Tue, 19 Nov 2013 10:29:02 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Taras Kondratiuk <taras.kondratiuk@linaro.org>, ext Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linux-OMAP <linux-omap@vger.kernel.org>, linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Linus Walleij <linus.walleij@linaro.org> writes:

> On Sat, Nov 16, 2013 at 1:01 AM, Taras Kondratiuk
> <taras.kondratiuk@linaro.org> wrote:
>
>> From: Victor Kamensky <victor.kamensky@linaro.org>
>>
>> All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
>> Need to use endian neutral functions to read/write h/w registers.
>> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
>> need to use read[lw]_relaxed and write[lw]_relaxed functions.
>> If the first simply reads/writes register, the second will byteswap
>> it if host operates in BE mode.
>>
>> Changes are trivial sed like replacement of __raw_xxx functions
>> with xxx_relaxed variant.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
>
> Since I generally just dislike __raw accessors I went and applied
> this. If it collides with any of Tony's fixup work I might need to
> take the patch out again, no big deal.
>
> Some ACKs would be nice, but unless there are major objections
> this stays merged.

Acked-by: Kevin Hilman <khilman@linaro.org>
