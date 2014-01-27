From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4+: move errata initialization to omap4_pm_init_early
Date: Mon, 27 Jan 2014 12:30:42 -0800
Message-ID: <87fvo9w4jx.fsf@paris.lan>
References: <CAGa+x863_MQ22h+U=KtK++3aG2F_X4x57Xtfe16GYXKNiaWX4A@mail.gmail.com>
	<1390248397-14112-1-git-send-email-nm@ti.com>
	<52E139C5.3090207@ti.com> <874n4uy483.fsf@paris.lan>
	<20140123184951.GJ7993@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65283 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbaA0Uap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jan 2014 15:30:45 -0500
Received: by mail-pb0-f46.google.com with SMTP id um1so6311933pbc.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Jan 2014 12:30:45 -0800 (PST)
In-Reply-To: <20140123184951.GJ7993@atomide.com> (Tony Lindgren's message of
	"Thu, 23 Jan 2014 10:49:52 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@linaro.org> [140123 09:55]:
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>> 
>> > On 01/20/2014 10:06 PM, Nishanth Menon wrote:
>> >> Move all OMAP4 PM errata initializations to centralized location in
>> >> omap4_pm_init_early. This allows for users to utilize the erratas
>> >> in various submodules as needed.
>> >> 
>> > Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> >
>> > This patch fixes build failure caused by patch 
>> > https://patchwork.kernel.org/patch/3084521/ 
>> > in case if SMP is not enabled.
>> 
>> So does that mean that that patch can now be applied as is?
>> 
>> We could sure use that fix (or equivalent) for CPUidle breakage on 4460.
>
> Yeah, seems OK to me, feel free to apply it directly:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

OK, I've picked up both $SUBJECT patch and the one from the above
patchworks link and will queue them up for v3.14-rc (and have added your
Ack to both.)

Thanks,

Kevin
