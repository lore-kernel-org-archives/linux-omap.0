From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 3/6] OMAP: PRCM: Added an api to get id for a PRCM event
Date: Fri, 24 Jun 2011 14:58:33 -0700
Message-ID: <87wrgax56e.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36732 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754440Ab1FXV6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 17:58:36 -0400
Received: by mail-pw0-f54.google.com with SMTP id 7so3503055pwi.27
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:58:35 -0700 (PDT)
In-Reply-To: <1308760934-9757-4-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 22 Jun 2011 19:42:11 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> This is required by OMAP3 as it needs to dynamically unmask events during
> idle cycle.

This shouldn't be needed if you move the clearing etc. back into the
PRCM IRQ handler (more on this in [4/6])

Kevin
