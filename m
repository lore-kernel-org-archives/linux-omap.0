From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 1/8] OMAP2+: cpufreq: move clk name decision to init
Date: Thu, 26 May 2011 10:33:36 -0700
Message-ID: <8739k1fjtb.fsf@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
	<1306366733-8439-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34853 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753780Ab1EZRdk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 13:33:40 -0400
Received: by mail-pz0-f51.google.com with SMTP id 26so493631pzk.24
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 10:33:39 -0700 (PDT)
In-Reply-To: <1306366733-8439-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 25 May 2011 16:38:46 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Clk name does'nt need to dynamically detected during clk init.
> move them off to driver initialization, if we dont have a clk name,
> there is no point in registering the driver anyways. The actual clk
> get and put is left at cpu_init and exit functions.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied.
