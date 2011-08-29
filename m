From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 1/6 V2] OMAP4: Clock: Associate clocks for OMAP temperature sensor
Date: Mon, 29 Aug 2011 14:47:21 -0700
Message-ID: <87bov7rity.fsf@ti.com>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
	<1313664735-8917-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:56872 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754480Ab1H2VrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 17:47:25 -0400
Received: by mail-pz0-f45.google.com with SMTP id 33so11247551pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 14:47:24 -0700 (PDT)
In-Reply-To: <1313664735-8917-2-git-send-email-j-keerthy@ti.com> (Keerthy's
	message of "Thu, 18 Aug 2011 16:22:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rnayak@ti.com

Keerthy <j-keerthy@ti.com> writes:

> div_ts_ck feeds only the temperature sensor functional clock
> and also has a clksel associated (for divider selection). Mapping this
> as the functional clock for the temperature sensor in clkdev table,
> so a clk_set_rate() in the driver would have the effect of changing the
> temperature sensor clock rate indirectly.
>
> Reviewd-by: Rajendra Nayak <rnayak@ti.com>

s/Reviewd/Reviewed/
