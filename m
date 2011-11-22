From: Will Deacon <will.deacon@arm.com>
Subject: Inclusion of ARM perf tree in linux-next
Date: Tue, 22 Nov 2011 10:04:35 +0000
Message-ID: <20111122100435.GC20518@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39757 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753000Ab1KVKFP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 05:05:15 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sfr@canb.auug.org.au
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, linux@arm.linux.org.uk, tony@atomide.com, a.p.zijlstra@chello.nl, arnd@arndb.de

Hi Stephen,

I maintain the ARM perf backend and would be very grateful if you could
please include this branch in linux-next:

git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf

This request has arisen specifically from some work with the OMAP guys
where it would be useful to spot any conflicts for 3.3, however I think it's
generally a good idea for me to give some of the perf changes an airing
before they get merged anyway.

The merge path for these patches into mainline is usually via Russell, but
platform updates may go via arm-soc (Arnd).

Thanks,

Will
