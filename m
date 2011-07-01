From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [GIT PULL] omap iommu fixes for v3.0-rc
Date: Fri, 1 Jul 2011 10:51:06 +0300
Message-ID: <BANLkTikhZhUzyk=31cUOcV3Ygj=BHUrbew@mail.gmail.com>
References: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com> <20110701070056.GZ23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60778 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab1GAHv1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:51:27 -0400
Received: by wwe5 with SMTP id 5so2979248wwe.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 00:51:26 -0700 (PDT)
In-Reply-To: <20110701070056.GZ23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 1, 2011 at 10:00 AM, Tony Lindgren <tony@atomide.com> wrote:
> These look like real fixes, but can you please update the commits
> with something like "This fixes an issue with foo when doing bar".

Done, please tell me if it's OK now.

> Otherwise it's easy to claim that these are "fixes for features that
> never worked" and it might be hard to justify them this late into
> the -rc cycle.

It seems we did have these issues for quite some time, and these are not
explicit 3.0 regressions. So they might vaguely fall into the "fixes
for features that never worked" definition too in a sense.

If you prefer to take them into 3.1, that's OK too.

Thanks,
Ohad.
