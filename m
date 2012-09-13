From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: PM debug: trace the functional power
 domains states
Date: Thu, 13 Sep 2012 09:31:39 +0200
Message-ID: <CAORVsuXMw7dMVZOSk-XSE8_D+qDfuYO3LyXStwC4hARTgb7j4Q@mail.gmail.com>
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
	<1347443732-7411-6-git-send-email-j-pihet@ti.com>
	<874nn2st0m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51358 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756667Ab2IMHbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 03:31:41 -0400
Received: by lagy9 with SMTP id y9so1712395lag.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 00:31:39 -0700 (PDT)
In-Reply-To: <874nn2st0m.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <j-pihet@ti.com>

On Thu, Sep 13, 2012 at 1:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Use of smp_processor_id() here will require the same care as pointed out
> by Roger Quadros in [PATCH] perf: Use raw_smp_processor_id insted of
> smp_processor_id.
BTW it looks like get_cpu and put_cpu is the way to go, as pointed out
by Russell.

Jean
