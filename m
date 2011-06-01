From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 2/4] OMAP2: PM debug: remove register dumping
Date: Tue, 31 May 2011 18:34:11 -0700
Message-ID: <87hb8al4h8.fsf@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-3-git-send-email-khilman@ti.com>
	<4DE3448E.6060502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60817 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758562Ab1FABeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 21:34:14 -0400
Received: by mail-px0-f174.google.com with SMTP id 15so3300710pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 18:34:13 -0700 (PDT)
In-Reply-To: <4DE3448E.6060502@ti.com> (Santosh Shilimkar's message of "Mon,
	30 May 2011 12:47:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On 5/27/2011 4:32 AM, Kevin Hilman wrote:
>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>
> Do you plan to keep wroking the patch which dumps registers
> before and after WFI ?

No.

I haven't thought through all the details yet, but I'm hoping that
dropping this feature will "encourage" others to help think about it as
well. ;)

Ideally, I'd like to see this handled by perf/ftrace.  We now have
tracepoints for clock, clockdomain and powerdomain events.  Maybe adding
additional data for each of these tracepoints which snapshots some key
registers values would be useful.  Then, visualizing with tools like
pytimechart or kernelshark could be done.

Another option would be a new driver which adds a way to snapshot
registers into a hash-table based on address (maybe triggered by the
existing tracepoints.)  This data could then be readable from userspace
via the drivers read/write interface, and displayed with a tool that
already knows about all the registers/bitfields etc. (e.g. omapconf.)

I'd guess the the latter is probably prefered since all the register &
bitfield knowlege is already in a tool like omapconf.

> Ofcourse this patch is in your pm-debug branch.

Right, I'll be dropping that branch.

> For this change
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

Thanks,

Kevin
