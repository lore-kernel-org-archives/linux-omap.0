From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v3 3/4] OMAP4: DMIC: initializes the DMIC driver
Date: Fri, 28 Jan 2011 13:16:16 +0530
Message-ID: <AANLkTi=XrhiNZxdtgM_SSna7tBJKb--ZQt=ssQ8WcgsM@mail.gmail.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com> <1295992862-6154-4-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50906 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753304Ab1A1HrA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 02:47:00 -0500
Received: by gyd10 with SMTP id 10so1001420gyd.28
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 23:46:56 -0800 (PST)
In-Reply-To: <1295992862-6154-4-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, Jan 26, 2011 at 03:31, David Lambert <dlambert@ti.com> wrote:
> This code is used to read the HWMOD database and initialize

use "hwmod" and not HWMOD

> the DMIC driver.
>
> Signed-off-by: David Lambert <dlambert@ti.com>
> ---

<<snip>>
