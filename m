From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] scheduler: Extract cgroups_cpuaccount code from
 sched.c into own file
Date: Wed, 19 May 2010 11:37:36 +0200
Message-ID: <1274261856.5605.10439.camel@twins>
References: <1274232620-23003-1-git-send-email-mike@android.com>
	 <1274232620-23003-4-git-send-email-mike@android.com>
	 <201005191130.42851.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57686 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab0ESJiO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 05:38:14 -0400
In-Reply-To: <201005191130.42851.trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Mike Chan <mike@android.com>, khilman@deeprootsystems.com, menage@google.com, balbir@in.ibm.com, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mingo@elte.hu, lizf@cn.fujitsu.com, containers@lists.linux-foundation.org

On Wed, 2010-05-19 at 11:30 +0200, Thomas Renninger wrote:
> 
> This is a cleanup against current linux-2.6 Linus tree.
>     
> Having CONFIG_CGROUP_CPUACCT code in kernel/sched.c looks wrong.
> Move this out to kernel/cgroup_cpuaccount.c
>     
> Test compiled with and without CONFIG_CGROUP_CPUACCT set on x86_64.

Sure, works for me, less code to look at :-)


