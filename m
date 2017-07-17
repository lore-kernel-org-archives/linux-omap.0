From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4 boot failure due to 422580c3cea7 (mm/oom_kill.c: add
 tracepoints for oom reaper-related events)
Date: Mon, 17 Jul 2017 03:19:28 -0700
Message-ID: <20170717101927.GJ10026@atomide.com>
References: <20170714134330.bsdoopceecuk5yem@earth>
 <B9634541-43B8-45FD-8DD2-38FB4F0FAD14@fb.com>
 <20170714172343.szrjbeob5alpgzpe@earth>
 <20170716125354.GA20017@castle>
 <20170717055942.GA10026@atomide.com>
 <20170717095139.gv3dmh7mhyzmh7bn@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717095139.gv3dmh7mhyzmh7bn@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170717 02:52]:
> On Sun, Jul 16, 2017 at 10:59:42PM -0700, Tony Lindgren wrote:
> > Sebastian, for me droid 4 boots just fine with v4.13-rc1 +
> > 19d39a3810e if that helps. So that's with commit 422580c3cea7.
> 
> v4.13-rc1 + 19d39a3810e was also broken for me. I just disabled
> some unused bits in my .config and now the kernel boots with
> (with 422580c3cea7 that is). Maybe I hit some maximum image size
> limit for Droid 4?
> 
> Anyways it looks like 422580c3cea7 is not the actual problem
> and merely reveals some other problem.

OK. Maybe check kexec --image-size configuration if you have
a huge static kernel?

Tony
