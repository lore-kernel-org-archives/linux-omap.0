From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: don't trace functions called from sched_clock
Date: Tue, 31 May 2011 09:13:07 -0700
Message-ID: <87oc2isvak.fsf@ti.com>
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
	<87hb8fyj2p.fsf@ti.com> <8762ovvf5f.fsf@ti.com>
	<20110531115039.GZ11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52710 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756994Ab1EaQNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 12:13:10 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so2334065pzk.15
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 09:13:09 -0700 (PDT)
In-Reply-To: <20110531115039.GZ11352@atomide.com> (Tony Lindgren's message of
	"Tue, 31 May 2011 04:50:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rabin Vincent <rabin@rab.in>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110527 17:28]:
>> Kevin Hilman <khilman@ti.com> writes:
>> 
>> > Rabin Vincent <rabin@rab.in> writes:
>> >
>> >> omap_readl() is used from the sched_clock() implementations and so must
>> >> be marked notrace to avoid recursion in ftrace.  Same thing with
>> >> mpu_read() for OMAP1.
>> >>
>> >> Signed-off-by: Rabin Vincent <rabin@rab.in>
>> >
>> > Acked-by: Kevin Hilman <khilman@ti.com>
>> 
>> I also meant to suggest this should probably queue for .40-rc series.
>
> Took a quick look and we should get rid of the omap_readl usage instead
> like I commented in another mail.

Agreed, that's a better approach.

Kevin
