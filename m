From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v8 01/11] OMAP: GPIO: prepare for platform driver
Date: Thu, 09 Dec 2010 15:19:04 -0800
Message-ID: <87aake5yc7.fsf@deeprootsystems.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<1290689318-10191-2-git-send-email-charu@ti.com>
	<8762v292ld.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47405 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab0LIXTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 18:19:08 -0500
Received: by pva4 with SMTP id 4so624919pva.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 15:19:07 -0800 (PST)
In-Reply-To: <8762v292ld.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Thu, 09 Dec 2010 11:18:54 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

Hi Charu,

I owe you an apology.

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

> I just noticed while testing on 36xx/Zoom3 that GPIO wakeups are no
> longer working after this series.
>
> The problem seems to be that for OMAP2+, this series removed manual
> SYSCONFIG register setting in favor of using omap_hwmod (which is good),
> however some of the SYSCONFIG values, specifically, in the current code,
> the ENAWAKEUP bit was set in each bank, but this is no longer the
> default with omap_hwmod.

I was wrong here.  The enable wakeup mode was supposed to be enabled by
default in the hwmod, but due to a bug[1], it was not.  This problem was
not directly related to your series.

[...]

> ... but it shows that GPIO wakeups were not fully
> tested with this series.  In the future, along with reporting what
> platforms it was testing on, it would be very helpful to include a
> summary of how the series was tested.

I apologize for accusing you of not testing GPIO wakeups.  I now know
that this functionality was broken by patches independent of your
series, so I deeply regret the accusation.

Kevin

[1] http://marc.info/?l=linux-omap&m=129193625420446&w=2
