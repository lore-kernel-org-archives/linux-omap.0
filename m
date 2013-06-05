From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 2/2] RTC: rtc-twl: Cleanup with module_platform_driver()
 conversion
Date: Wed, 5 Jun 2013 11:05:26 -0700
Message-ID: <CAGa+x86FjN7-CMi2iSxrqyEKG+rBSPtfAOntjYftGUvToyn75g@mail.gmail.com>
References: <1366101013-21183-1-git-send-email-peter.ujfalusi@ti.com>
	<1366101013-21183-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46610 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756971Ab3FESF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jun 2013 14:05:27 -0400
Received: by mail-wi0-f177.google.com with SMTP id ey16so524387wid.16
        for <linux-omap@vger.kernel.org>; Wed, 05 Jun 2013 11:05:26 -0700 (PDT)
In-Reply-To: <1366101013-21183-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Christoph Fritz <chf.fritz@googlemail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomi Valkeinen <tomi.valkeinen@iki.fi>

On Tue, Apr 16, 2013 at 1:30 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Use module_platform_driver() to register the platform driver.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
