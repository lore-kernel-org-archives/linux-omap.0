From: Kevin Hilman <khilman@ti.com>
Subject: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Fri, 30 Sep 2011 06:57:35 -0700
Message-ID: <87aa9mm8ts.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43932 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751351Ab1I3N5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 09:57:42 -0400
Received: by mail-yw0-f43.google.com with SMTP id 21so1916710ywm.2
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 06:57:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Arnd,

The upcoming OMAP4 PM series from Santosh[1] that we're planning to
queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
in the irq/core branch of Thomas' tip tree[3].

In the past, I noticed you merged external trees like this to solve
dependencies.

Could you pull the irq/core branch into your tree to meet this
dependency?

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&m=131684489920440&w=2
[2] http://marc.info/?l=linux-omap&m=131581416908252&w=2
[3] currently here: git://tesla.tglx.de/git/linux-2.6-tip
