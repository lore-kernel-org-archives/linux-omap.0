From: Russ Dill <russ.dill@gmail.com>
Subject: Latest tmlid/linux-omap-2.6.git changes
Date: Tue, 7 Apr 2009 15:41:23 -0700
Message-ID: <f9d2a5e10904071541k3c7c233x82c303e50cafc7a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:3979 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbZDGWlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 18:41:24 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2958332rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Apr 2009 15:41:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

f64f3007, "omap_hsmmc: Flush posted write to IRQ" doesn't change any files.

It appears that the patch in question is here:

http://patchwork.kernel.org/patch/16515/

But it looks like it would have created a conflict with b420f201,
"MMC: OMAP: flush posted write to IRQ". The f64f3007 patch adds a read
in two places, but the b420f201 patch only adds a read in one place.

It also apears that e6cb736 "Initial import of extra code in
arch/arm/*omap* into omap-pool branch", sets arch/arm/plat-omap/dma.c
to mode 755, and the merge a01c39f, "Merge branch 'omap-fixes'" keeps
that mode.
