From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: tidspbridge compilation broken
Date: Sat, 09 Oct 2010 13:49:57 +0300
Message-ID: <1286621397.10205.25.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:44203 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab0JIL22 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Oct 2010 07:28:28 -0400
Received: from [10.0.1.162] (196-98-odb-svnet.titannet.ro [77.81.196.98])
	(authenticated bits=0)
	by ns.mindbit.ro (8.13.8/8.13.8) with ESMTP id o99AnvNn008285
	for <linux-omap@vger.kernel.org>; Sat, 9 Oct 2010 13:49:58 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm trying to compile the tidspbridge driver from the dspbridge branch
of the linux-omap git tree and I stumbled upon a few compilation
problems:

1. First is related to the missing header plat/dsp.h added by the
following patch which was not applied to this branch:

http://marc.info/?l=linux-omap&m=128620861805925&w=2

2. The second one is related to the missing header plat/control.h which
was moved by a recent commit (81bb9b6) from plat to mach-omap2. The
dspbridge driver requires a few defines from that header but as far as I
understand, that header file is no longer supposed to be accessible by
drivers. Any suggestion on how to fix that in dspbridge?

3. There's a link error triggered by the new iommu dependency. It's
fairly trivial to fix. I will submit a patch for this.

Thanks,
Ionut.

