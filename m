From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 5/6] OMAP3: Serial: Made serial to work properly with PRCM chain handler
Date: Fri, 24 Jun 2011 15:00:53 -0700
Message-ID: <87oc1mx52i.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:51732 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754557Ab1FXWA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 18:00:57 -0400
Received: by pvg12 with SMTP id 12so1947558pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 15:00:56 -0700 (PDT)
In-Reply-To: <1308760934-9757-6-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 22 Jun 2011 19:42:13 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

You should put 'TEMP' or something similar in the subject of 5/6 and 6/6
since those are only needed without the full conversion from Govindraj.

If Govindraj is able to validate the rest of this series with his
runtime PM conversion, I'd prefer to merge his conversion instead of
your patches 5 & 6.

Kevin
