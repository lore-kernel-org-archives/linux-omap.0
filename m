From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4+: move errata initialization to omap4_pm_init_early
Date: Thu, 23 Jan 2014 09:53:32 -0800
Message-ID: <874n4uy483.fsf@paris.lan>
References: <CAGa+x863_MQ22h+U=KtK++3aG2F_X4x57Xtfe16GYXKNiaWX4A@mail.gmail.com>
	<1390248397-14112-1-git-send-email-nm@ti.com>
	<52E139C5.3090207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51974 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbaAWRxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jan 2014 12:53:34 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so2058465pde.14
        for <linux-omap@vger.kernel.org>; Thu, 23 Jan 2014 09:53:34 -0800 (PST)
In-Reply-To: <52E139C5.3090207@ti.com> (Grygorii Strashko's message of "Thu,
	23 Jan 2014 17:48:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> On 01/20/2014 10:06 PM, Nishanth Menon wrote:
>> Move all OMAP4 PM errata initializations to centralized location in
>> omap4_pm_init_early. This allows for users to utilize the erratas
>> in various submodules as needed.
>> 
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> This patch fixes build failure caused by patch 
> https://patchwork.kernel.org/patch/3084521/ 
> in case if SMP is not enabled.

So does that mean that that patch can now be applied as is?

We could sure use that fix (or equivalent) for CPUidle breakage on 4460.

Kevin
