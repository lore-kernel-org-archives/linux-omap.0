From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 19/19] OMAP3430: SR: class3: restrict CPU to run on
Date: Thu, 17 Mar 2011 12:58:16 -0700
Message-ID: <87sjul1puv.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-20-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:57497 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754358Ab1CQT6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 15:58:23 -0400
Received: by mail-iy0-f171.google.com with SMTP id 40so4267467iyf.16
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 12:58:20 -0700 (PDT)
In-Reply-To: <1299338962-5602-20-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Use SmartReflex AVS Class3 initialization only for OMAP343x family of
> processors.

Why?

