From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/1] OMAP: TWL: set clk32kg regulator on
Date: Fri, 04 Nov 2011 16:16:01 -0700
Message-ID: <87zkgb1nta.fsf@ti.com>
References: <1320162052-32276-1-git-send-email-vishalm@ti.com>
	<1320162052-32276-2-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46928 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750975Ab1KDXQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 19:16:05 -0400
Received: by mail-iy0-f174.google.com with SMTP id e36so4723537iag.33
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 16:16:03 -0700 (PDT)
In-Reply-To: <1320162052-32276-2-git-send-email-vishalm@ti.com> (Vishal
	Mahaveer's message of "Tue, 1 Nov 2011 09:40:52 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishal Mahaveer <vishalm@ti.com>
Cc: linux-omap@vger.kernel.org

Vishal Mahaveer <vishalm@ti.com> writes:

> omap4_clk32kg regulator is used by connectivity (WLAN/BT/GPS) chip on
> omap4 platforms.
> Set always_on flag to true for connectivity chip to operate.

The driver/init for the connectivity chip should be using the regulator
API to enable/disable the regulator as needed.

Kevin

