From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Tue, 20 Sep 2011 16:31:17 +0300
Message-ID: <1316525477.1949.20.camel@deskari>
References: <1316522954-16594-1-git-send-email-mythripk@ti.com>
	 <1316522954-16594-2-git-send-email-mythripk@ti.com>
	 <1316522954-16594-3-git-send-email-mythripk@ti.com>
	 <1316522954-16594-4-git-send-email-mythripk@ti.com>
	 <1316522954-16594-5-git-send-email-mythripk@ti.com>
	 <1316522954-16594-6-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:47127 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810Ab1ITNbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 09:31:22 -0400
Received: by mail-ew0-f42.google.com with SMTP id 1so243469ewy.15
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 06:31:20 -0700 (PDT)
In-Reply-To: <1316522954-16594-6-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Tue, 2011-09-20 at 18:19 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Add support to dump the HDMI regm, regn, and other clock parameters.

This patch doesn't work at all. It's checking for CONFIG_OMAP2_DSS_HDMI,
whereas the actual define is CONFIG_OMAP4_DSS_HDMI. And even after
fixing that, the output is:

HDMI Clock Info
regm            104regmf 104
dcofreq 0regsd 1
DSS_FCK (DSS_FCLK)      (off)
hdmi fclk source = 3

Did you test your patches at all?

 Tomi


