From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] arm: omap: sram: fix OMAP4 errata handling
Date: Wed, 29 Aug 2012 08:27:52 -0700
Message-ID: <CAMQu2gyqMZjZkHsG-sG3BZwT8mBbcwATsa3hw-XY_zq1iutPgA@mail.gmail.com>
References: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47238 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658Ab2H2P2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 11:28:13 -0400
Received: by obbwc20 with SMTP id wc20so3521689obb.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 08:28:12 -0700 (PDT)
In-Reply-To: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Wed, Aug 29, 2012 at 8:24 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> OMAP4-specific code should be executed only if we are running on
> OMAP4. Otherwise it may break multi-OMAP kernels. Found by reading
> the code.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
Looks good.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
