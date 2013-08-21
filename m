From: Kyle McMartin <kyle@redhat.com>
Subject: 3.11-rc1+ multiplatform kernel+dtb pandaboard issues
Date: Wed, 21 Aug 2013 11:43:21 -0400
Message-ID: <20130821154321.GA26531@redacted.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab3HUPnY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 11:43:24 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7LFhNm1019775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 11:43:24 -0400
Received: from redacted.bos.redhat.com ([10.18.17.143])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r7LFhMWw004131
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 11:43:23 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hey,

We've been trying to get booting with a detached DTB working in Fedora
rawhide for a while, with no luck, the kernel keeps hanging after
"Starting kernel ..." with no output.

I've suspected there might be a config issue, as omap2_defconfig
works alright, as does booting a uImage with an appended
omap4-panda.dtb, but there's no love with a zImage + initrd + dtb
(or even just zImage without initrd + dtb.)

I guess for 3.11 we could just use a legacy uImage in the interim until
the OMAP dtb stuff is a bit more baked, but we're willing to try to
debug the issue.

Our .config is available at [1] in case it's something obvious that
I'm just missing that anyone can hint at, but I've futzed a lot of
the options from omap2_defconfig in with little luck.

Thanks in advance!

regards, Kyle 

1: http://kyle.fedorapeople.org/config-3.11.0-0.rc6.git0.1.fc20.armv7hl
