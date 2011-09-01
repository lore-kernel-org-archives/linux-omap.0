From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 07/10] OMAP4: DSS2: HDMI: Provide a wrapper API to
 configure
Date: Thu, 01 Sep 2011 11:38:55 +0300
Message-ID: <1314866335.2169.9.camel@lappyti>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
	 <1314598500-24005-2-git-send-email-mythripk@ti.com>
	 <1314598500-24005-3-git-send-email-mythripk@ti.com>
	 <1314598500-24005-4-git-send-email-mythripk@ti.com>
	 <1314598500-24005-5-git-send-email-mythripk@ti.com>
	 <1314598500-24005-6-git-send-email-mythripk@ti.com>
	 <1314598500-24005-7-git-send-email-mythripk@ti.com>
	 <1314598500-24005-8-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54562 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756437Ab1IAIjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 04:39:00 -0400
Received: by mail-bw0-f44.google.com with SMTP id r4so2342236bka.17
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 01:38:59 -0700 (PDT)
In-Reply-To: <1314598500-24005-8-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Instead of DSS knowing of the interior IP driver function provide
> a wrapper API to configure.

This commit message doesn't make much sense. What you do in this patch
is just rename the functions, and add the hdmi_pll_disable function.

 Tomi


