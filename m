From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Register definition cleanup and
 improvements
Date: Fri, 16 Sep 2011 09:15:59 +0300
Message-ID: <1316153759.2487.33.camel@deskari>
References: <1316152941-20326-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:59896 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752398Ab1IPGQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 02:16:06 -0400
Received: by bkbzu5 with SMTP id zu5so4575518bkb.35
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 23:16:03 -0700 (PDT)
In-Reply-To: <1316152941-20326-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, 2011-09-16 at 11:32 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> 1.Add some H/w indexable registers missed in definition.
> 2.Remove usage of struct hdmi_reg and use u16 instead.
> 3.Move the avi_infoframe parameters comments above the field.

Please split this patch as those are separate things. And include this
patch in the HDMI patch series that we discussed about (reg dumps, clk
dumps etc).

 Tomi


