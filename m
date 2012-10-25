From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] ARM: OMAP2+: PM: VP: minor pr_warn updates
Date: Thu, 25 Oct 2012 15:11:24 -0700
Message-ID: <87pq46qk1f.fsf@deeprootsystems.com>
References: <1351190236-23443-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34825 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab2JYWKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 18:10:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2323040pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 15:10:52 -0700 (PDT)
In-Reply-To: <1351190236-23443-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 25 Oct 2012 13:37:16 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> change pr_warnings to pr_warn and ensure a newline
> is present in all messages
>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks queuing for v3.8 as PM cleanup (branch: for_3.8/cleanup/pm.)

Kevin
