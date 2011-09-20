From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/5] OMAPDSS: HDMI: Add support to dump registers
 through
Date: Tue, 20 Sep 2011 16:29:10 +0300
Message-ID: <1316525350.1949.17.camel@deskari>
References: <1316522954-16594-1-git-send-email-mythripk@ti.com>
	 <1316522954-16594-2-git-send-email-mythripk@ti.com>
	 <1316522954-16594-3-git-send-email-mythripk@ti.com>
	 <1316522954-16594-4-git-send-email-mythripk@ti.com>
	 <1316522954-16594-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:50078 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750720Ab1ITN3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 09:29:15 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so586381bkb.33
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 06:29:13 -0700 (PDT)
In-Reply-To: <1316522954-16594-5-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Tue, 2011-09-20 at 18:19 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Add support to dump the HDMI core, PLL and PHY registers through debugfs

The subject seems to be broken.

This prints PLL registers twice, second time is when it should be
printing PHY registers.

It also prints lines like:

HDMI_CORE_AV_SPD_DBYTE(i)           00000000
HDMI_CORE_AV_SPD_DBYTE(i)           00000000
HDMI_CORE_AV_SPD_DBYTE(i)           00000000
HDMI_CORE_AV_SPD_DBYTE(i)           00000000

 Tomi


