From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 6/7] OMAP4: hwmod data: TEMP: Fix timer1 main_clk
Date: Mon, 27 Jun 2011 17:19:25 -0700
Message-ID: <877h864xki.fsf@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
	<1309192391-12410-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59335 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755592Ab1F1ATb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 20:19:31 -0400
Received: by mail-pw0-f51.google.com with SMTP id 18so4022576pwi.24
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 17:19:30 -0700 (PDT)
In-Reply-To: <1309192391-12410-7-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 27 Jun 2011 18:33:10 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

Benoit Cousson <b-cousson@ti.com> writes:

> Since the timer is still not pm_runtime adapted, it is still
> using directly the physical clock nodes at init time.
>
> Replace the clock node by the original one in the clock data
> file.
>
> Keep the original name until the driver is fixed.

Is this still needed when used with Tony's devel-timer branch?  

I assume not.

Kevin
