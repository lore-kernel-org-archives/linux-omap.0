From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: don't trace functions called from sched_clock
Date: Fri, 27 May 2011 13:39:10 -0700
Message-ID: <87hb8fyj2p.fsf@ti.com>
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55393 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752499Ab1E0UjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 16:39:14 -0400
Received: by pvg13 with SMTP id 13so1095325pvg.12
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 13:39:13 -0700 (PDT)
In-Reply-To: <1304846514-15641-1-git-send-email-rabin@rab.in> (Rabin Vincent's
	message of "Sun, 8 May 2011 14:51:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rabin Vincent <rabin@rab.in> writes:

> omap_readl() is used from the sched_clock() implementations and so must
> be marked notrace to avoid recursion in ftrace.  Same thing with
> mpu_read() for OMAP1.
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Kevin Hilman <khilman@ti.com>
