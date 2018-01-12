From: Tony Lindgren <tony@atomide.com>
Subject: PM regression in next
Date: Thu, 11 Jan 2018 16:01:13 -0800
Message-ID: <20180112000037.GA3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

I'm seeing a considerable idle power consumption regression in
Linux next, with power consumption for my idle test system going
to 17.5mW compared to the usual 8mW on my test device.

Git bisect points to merge commit e130bc1d00a4 ("Merge branch
'akpm-current/current'") being the first bad commit.

I have also verified that commit 70286688e5ad ("ipc/mqueue.c:
have RT tasks queue in by priority in wq_add()") is good, and
commit e2d7fe89e8ae ("Merge remote-tracking branch
'init_task/init_task'") is good.

Any ideas?

Regards,

Tony
