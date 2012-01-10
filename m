From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 0/2] arm:omap:am33xx: Add voltage and power domain data
Date: Tue, 10 Jan 2012 15:39:48 -0800
Message-ID: <87ty43f7p7.fsf@ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:33035 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755381Ab2AJXjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 18:39:54 -0500
Received: by iaby26 with SMTP id y26so314557iab.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 15:39:53 -0800 (PST)
In-Reply-To: <1324803628-16790-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 25 Dec 2011 14:30:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Last time I had submitted a big patch-series, almost changing >7.5K lines
> for AM33XX voltage, power, clock and HWMOD data support (as a RFC);
> which I believe is very hard to review and difficult to manage also.
> So I decided to split the patches as and when they are clean
> and ready for review/merge/acceptance,

FYI... 

In usually (but not always) helps to specifically Cc the maintainers of
the code you're changin.  In this case, Paul & Benoit are maintaining
most of this core code/data, so you should make sure they are Cc'd as
well.

Thanks,

Kevin
