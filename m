From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Fri, 18 May 2012 07:03:18 -0700
Message-ID: <87d361powp.fsf@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
	<1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
	<87y5oqtpnw.fsf@ti.com> <20120517232755.EF4383E062C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:50931 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967303Ab2ERODT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 10:03:19 -0400
Received: by dadv2 with SMTP id v2so4120149dad.32
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 07:03:18 -0700 (PDT)
In-Reply-To: <20120517232755.EF4383E062C@localhost> (Grant Likely's message of
	"Thu, 17 May 2012 17:27:55 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>

Grant Likely <grant.likely@secretlab.ca> writes:

>> Grant, after Tarun/Santosh have a chance to review/ack this, can you
>> still get this in for 3.5?  If not, getting it into -rc should be fine.
>
> Yes.  Do you have any other omap patches?  Do you want to send me a
> pull req?

We just found one more fix needed.

I'm collecting the acks/tested-bys and will have a branch for you
shortly.

Kevin
