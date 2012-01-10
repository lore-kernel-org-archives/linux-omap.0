From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 1/2] arm:omap:am33xx: Add voltage domain data
Date: Tue, 10 Jan 2012 10:29:59 -0800
Message-ID: <87ipkjpg0o.fsf@ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
	<1324803628-16790-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:39107 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756717Ab2AJSaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 13:30:03 -0500
Received: by mail-gy0-f174.google.com with SMTP id g21so2616593ghb.33
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 10:30:01 -0800 (PST)
In-Reply-To: <1324803628-16790-2-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 25 Dec 2011 14:30:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Currently dummy voltage domain data is being created
> in order to succeed boot process, nothing has been done
> w.r.t actual hardware (voltage control).
>
> Also, hook up the AM33XX voltage domain to OMAP framework.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Data looks OK, but why the dummy voltage domains?   Does this device not
support voltage scaling? 

Also, I think it was my idea in an earlier review to add the 
'.scalable = false', but it's not really necessary since the default is
false.  Sorry 'bout that.

Kevin
