From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 0/5] omap: mailbox: hwmod support
Date: Fri, 11 Feb 2011 08:37:04 -0800
Message-ID: <87zkq2bk9b.fsf@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<20110209183219.GA20795@atomide.com>
	<20110210.080134.54852186899891738.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:46369 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754346Ab1BKQhK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 11:37:10 -0500
Received: by yxt3 with SMTP id 3so1191746yxt.33
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 08:37:08 -0800 (PST)
In-Reply-To: <20110210.080134.54852186899891738.Hiroshi.DOYU@nokia.com>
	(Hiroshi DOYU's message of "Thu, 10 Feb 2011 08:01:34 +0200 (EET)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: tony@atomide.com, b-cousson@ti.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, omar.ramirez@ti.com

Hi Hiroshi,

Hiroshi DOYU <Hiroshi.DOYU@nokia.com> writes:

> From: ext Tony Lindgren <tony@atomide.com>
> Subject: Re: [PATCH v5 0/5] omap: mailbox: hwmod support
> Date: Wed, 9 Feb 2011 10:32:19 -0800
>
>> * Omar Ramirez Luna <omar.ramirez@ti.com> [110202 11:37]:
>>> Mailbox hwmod support for OMAP 2,3,4.
>> 
>> Hiroshi, any comments on these?
>
> Well, I haven't followed hwmod much. If Kevin is ok, ok for me.

Do you have any simple standalone tests for mailbox (e.g. without
bridge/syslink) that can be used to so some sanity checking on these
driver changes?

Thanks,

Kevin
