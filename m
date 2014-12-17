From: Kevin Hilman <khilman@kernel.org>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Wed, 17 Dec 2014 11:11:39 -0800
Message-ID: <CAMAWPa-Y2f-NKXT1B9Y1O5BLvDTzQFE++pxWYg3BVc93Q_HSRQ@mail.gmail.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
	<CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
	<54909E30.4040300@ti.com>
	<CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
	<CAMAWPa-_OZC3ynKYxbtXK4=z-z720JxXigT23umscMTm8VWAzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50900 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbaLQTLn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Dec 2014 14:11:43 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 15F4120A14
	for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2014 19:11:43 +0000 (UTC)
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com [209.85.212.172])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3079720A28
	for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2014 19:11:42 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id n3so16818762wiv.11
        for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2014 11:11:39 -0800 (PST)
In-Reply-To: <CAMAWPa-_OZC3ynKYxbtXK4=z-z720JxXigT23umscMTm8VWAzA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

On Wed, Dec 17, 2014 at 9:16 AM, Kevin Hilman <khilman@kernel.org> wrote:

[...]

> So the BUG() itself isn't the problem with this regression.  There's
> been a fair amount of changes in the OMAP clk driver (including some
> other regressions), so I suspect the culprit to be lying somewhere in
> the recent OMAP clock changes.

So I attempted to bisect this down, and while it's pinpointing the
problem to the clk-next branch, it's not that simple  I bisected this
on next-20141216, which is where it first showed up, and the bisect
reported: e03f3bb62ca8a1124bc408046c50aed7629b24cc is the first bad
commit.

That commit is where clk-next is merged into linux-next.  What's
intersting is that testing clk-next by itself was just fine, and
linux-next before merging clk-next was just fine.  The bisection here
is complicated because OMAP clock-related changes when in through
drivers/clk and through arch/arm/mach-omap2, so debugging this down
further is going to be a more manual effort.  And one I will leave for
someone else.

Kevin
