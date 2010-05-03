From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
Date: Mon, 03 May 2010 16:35:08 -0700
Message-ID: <87tyqor237.fsf@deeprootsystems.com>
References: <1272927847-21226-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:34596 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab0ECXfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 19:35:18 -0400
Received: by gxk9 with SMTP id 9so1867088gxk.8
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 16:35:17 -0700 (PDT)
In-Reply-To: <1272927847-21226-1-git-send-email-mike@android.com> (Mike Chan's message of "Mon\,  3 May 2010 16\:04\:06 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com

Mike Chan <mike@android.com> writes:

> IO events can also come from GPIO modules, which reside in the PER domain.
> It is possible for the PER to enter RET while CORE is still in ON.
> If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
> wakeup in this case, unless we enable it.
>
> Signed-off-by: Mike Chan <mike@android.com>

Thanks, adding both patches to PM branch (pm-fixes branch) and will
queue for 2.6.35.

Kevin
