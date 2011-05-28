From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: don't trace functions called from sched_clock
Date: Fri, 27 May 2011 17:32:12 -0700
Message-ID: <8762ovvf5f.fsf@ti.com>
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
	<87hb8fyj2p.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45196 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757046Ab1E1AcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 20:32:15 -0400
Received: by pzk4 with SMTP id 4so1041797pzk.28
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 17:32:14 -0700 (PDT)
In-Reply-To: <87hb8fyj2p.fsf@ti.com> (Kevin Hilman's message of "Fri, 27 May
	2011 13:39:10 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Rabin Vincent <rabin@rab.in> writes:
>
>> omap_readl() is used from the sched_clock() implementations and so must
>> be marked notrace to avoid recursion in ftrace.  Same thing with
>> mpu_read() for OMAP1.
>>
>> Signed-off-by: Rabin Vincent <rabin@rab.in>
>
> Acked-by: Kevin Hilman <khilman@ti.com>

I also meant to suggest this should probably queue for .40-rc series.

Kevin
