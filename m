From: Tony Lindgren <tony@atomide.com>
Subject: Re: (Bug report) the kernel crash when I run cyclictest on
 AM3715/DM3730
Date: Wed, 1 Jun 2011 03:35:52 -0700
Message-ID: <20110601103552.GY11352@atomide.com>
References: <4DE450FE.1050402@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13738 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933384Ab1FAKfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 06:35:55 -0400
Content-Disposition: inline
In-Reply-To: <4DE450FE.1050402@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* stanley.miao <stanley.miao@windriver.com> [110530 19:19]:
> The test command :
> 
> # cyclictest -l100000000 -m -a0 -t1 -n -p99 -i200 -h200 -q
> I run the following command to increase cpu's burden at the same time.
> # while true; do hackbench; sleep 1;done
> 
> cyclictest and hackbench can be get in
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
> 
> The linux kernel version :
> 
> the kernel I used is windriver linux kernel. but this bug can also
> be reproduced on the branch OMAPPSP_03.00.01.06 in
> git://arago-project.org/git/projects/linux-omap3.git.
> The kernel in linux-omap-2.6 git tree hung and didn't give any
> useful Oops messages when I ran this cyclictest.

Started these tests on zoom3 on current devel-fixes branch
at commit 1704bf15deb6de20f8f4272c8d8232b36bbc7484. So far
no issues here, so maybe try git bisect between the mainline
version you have and v3.0-rc1?

Regards,

Tony
