From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 07 Nov 2013 16:02:26 -0800
Message-ID: <87siv7pxpp.fsf@linaro.org>
References: <1383863549-7438-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49569 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3KHACa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 19:02:30 -0500
Received: by mail-pb0-f46.google.com with SMTP id un15so1343251pbc.33
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 16:02:29 -0800 (PST)
In-Reply-To: <1383863549-7438-1-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Thu, 7 Nov 2013 23:32:29 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com, s.neumann@raumfeld.com, mporter@ti.com, nsekhar@ti.com, Russ.Dill@ti.com, nm@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>
> All information can be reconstructed by already known runtime
> information.
>
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
> Ok, here is v5.
>
> v4 -> v5:
>
> 	* dropped pm_runtime_* function calls entirely
> 	* moved the function pointers to .suspend/resume _noirq

[...]

> +static const struct dev_pm_ops edma_pm_ops = {
> +	.suspend	= edma_pm_suspend,

I suspect you intended to use the _noirq version like the changelog
says?

> +	.resume_noirq	= edma_pm_resume,
> +};

Also, I believe it was already suggested by Nishanth, but the late/early
callbacks are probably more appropriate here than the noirq callbacks.
Unless there's a *really* good reason to use the noirq callbacks, they
should be avoided.

That being said, I wonder if the whole approach here is the right one.
I know you're basing your stuff on some TI tree, but that doesn't make
it the right way (usually, it's the opposite, but I digress...)  ;)

IMO, EDMA should be done like we currently do I2C and not implement
suspend/resume at all.  Instead, the driver should do runtime PM done on
a per xfer basis.  Then when suspend comes along, all that needs to be
done is ensure all in-flight xfers are done, then runtime PM will kick
in.

Kevin
