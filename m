From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/5] regulator: twl: make 6030 regulators useable
Date: Tue, 05 Apr 2011 10:06:48 +0100
Message-ID: <1301994408.14075.111.camel@vega>
References: <1301633566-5212-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57321 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1DEJGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 05:06:54 -0400
Received: by wwa36 with SMTP id 36so199678wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 02:06:53 -0700 (PDT)
In-Reply-To: <1301633566-5212-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>

On Fri, 2011-04-01 at 10:22 +0530, Nishanth Menon wrote:
> TWL6030 regulator dynamic operations such as those on vaux2 and vaux3
> were reported to be broken on platforms such as pandaboard(OMAP4).
> Digging deeper into the code, found that 6030 regulator support
> requires quiet a bit of fixes to make it useable. Major change w.r.t
> TWL4030 has been the introduction of CFG_STATE register in TWL6030
> which is needed to be used for regulator control compared to messages
> which were used in TWL4030.

All applied now.

Thanks

Liam

