From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 12:29:15 +0530
Message-ID: <4FE80C43.6090802@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>	 <1340372890-10091-6-git-send-email-rnayak@ti.com> <1340604478.12683.25.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57245 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754678Ab2FYG7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 02:59:39 -0400
Received: by pbbrp8 with SMTP id rp8so6148426pbb.19
        for <linux-omap@vger.kernel.org>; Sun, 24 Jun 2012 23:59:38 -0700 (PDT)
In-Reply-To: <1340604478.12683.25.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

On Monday 25 June 2012 11:37 AM, Tomi Valkeinen wrote:
> Hi,
>
> On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the omapdss clocks.
>
> You used clk_prepare and clk_unprepare instead of clk_prepare_enable and
> clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
> is that the clocks are normally not enabled/disabled from atomic
> context.
>
> What does the prepare/unprepare actually do? Is there any benefit in
> delaying preparing, i.e. is there a difference between prepare right
> after clk_get, or prepare right before clk_enable? (And similarly for
> unprepare)

clk_prepare/unprepare are useful for clocks which need the 'enable'
logic to be implemented as a slow part (which can sleep) and a fast part
(which does not sleep). For all the dss clocks in question we don't need
a slow part and hence they do not have a .clk_prepare/unprepare
platform hook.

The framework however still does prepare usecounting (it has a prepare
count and an enable count, and prepare count is expected to be non-zero
while the clock is being enabled) and uses a mutex around to guard it.
So while the dss driver would do multiple clk_enable/disable while its
active, it seems fair to just prepare/unprepare the clocks once just
after clk_get() and before clk_put() in this particular case.

>
>   Tom
>

