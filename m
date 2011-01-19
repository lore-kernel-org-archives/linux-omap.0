From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for function body copying
Date: Wed, 19 Jan 2011 14:29:00 -0800
Message-ID: <87bp3cr0ib.fsf@ti.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44935 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893Ab1ASW3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 17:29:09 -0500
Received: by mail-qw0-f53.google.com with SMTP id 5so1390768qwe.12
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 14:29:04 -0800 (PST)
In-Reply-To: <1295039877-7976-1-git-send-email-dave.martin@linaro.org> (Dave
	Martin's message of "Fri, 14 Jan 2011 15:17:57 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Dave Martin <dave.martin@linaro.org> writes:

> In low-level board support code, there is sometimes a need to
> copy a function body to another location at run-time.
>
> A straightforward call to memcpy doesn't work in Thumb-2,
> because bit 0 of external Thumb function symbols is set to 1,
> indicating that the function is Thumb.  Without corrective
> measures, this will cause an off-by-one copy, and the copy
> may be called using the wrong instruction set.
>
> This patch adds an fncpy() macro to help with such copies.
>
> Particular care is needed, because C doesn't guarantee any
> defined behaviour when casting a function pointer to any other
> type.  This has been observed to lead to strange optimisation
> side-effects when doing the arithmetic which is required in
> order to copy/move function bodies correctly in Thumb-2.
>
> Thanks to Russell King and Nicolas Pitre for their input
> on this patch.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Tested-by: Jean Pihet <j-pihet@ti.com>

Tested-by: Kevin Hilman <khilman@ti.com>

along with Jean's OMAP patch on:

OMAP2420/n810: including basic suspend/resume test.

OMAP16xx/OSK: boot test only.

Kevin
