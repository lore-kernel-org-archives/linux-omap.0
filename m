From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP3EVM: Update pad configuration for wakeup enabled pads
Date: Mon, 10 May 2010 09:39:24 -0700
Message-ID: <87fx1zk8xv.fsf@deeprootsystems.com>
References: <1272886671-21749-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:49216 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0EJQje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:39:34 -0400
Received: by qyk13 with SMTP id 13so6415180qyk.1
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 09:39:33 -0700 (PDT)
In-Reply-To: <1272886671-21749-1-git-send-email-ranjithl@ti.com> (Ranjith Lohithakshan's message of "Mon\,  3 May 2010 17\:07\:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> OMAP3530 TRM section 7.4.4.4.2 requires OFFOUTENABLE to be set (active low)
> if wakeup capabilities are enabled on a pad. During OFF mode testing
> on OMAP3530 EVM, it was observed that the device was not residing in
> the OFF state. The device enters into the OFF state and immediately exits
> from that state as if an IO wakeup event has occured. The issue was traced
> down to the pad configuration of wkaeup enabled pad's.
>
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
