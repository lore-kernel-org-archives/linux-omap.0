From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4 boot failure due to 422580c3cea7 (mm/oom_kill.c: add
 tracepoints for oom reaper-related events)
Date: Sun, 16 Jul 2017 22:59:42 -0700
Message-ID: <20170717055942.GA10026@atomide.com>
References: <20170714134330.bsdoopceecuk5yem@earth>
 <B9634541-43B8-45FD-8DD2-38FB4F0FAD14@fb.com>
 <20170714172343.szrjbeob5alpgzpe@earth>
 <20170716125354.GA20017@castle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170716125354.GA20017@castle>
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Gushchin <guro@fb.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roman Gushchin <guro@fb.com> [170716 05:55]:
> On Fri, Jul 14, 2017 at 07:23:43PM +0200, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Fri, Jul 14, 2017 at 02:12:21PM +0000, Roman Gushchin wrote:
> > > > On 14 Jul 2017, at 14:43, Sebastian Reichel <sebastian.reichel@collabora.co.uk> wrote:
> > > > I just bisected another issue breaking boot on Droid 4. My
> > > > bisect points to 422580c3cea7 (mm/oom_kill.c: add tracepoints
> > > > for oom reaper-related events). It do not see any message
> > > > printed to UART (with earlyprintk) once that commit is part
> > > > of my image. Kernel config is below.
> > 
> > > This is really interesting, because this patch adds few
> > > tracepoints and all of them are called from the oom code, which is
> > > hopefully not a part of the boot process.
> > > 
> > > Can you, please, confirm, that it can be reproduced with some
> > > confidence? If so, can you, please, eliminate the tracepoints
> > > calls and try to reproduce the boot failure?
> > 
> > I can boot 9967468c0a10 ("Merge branch 'akpm' (patches from
> > Andrew)") after adding
> > 
> >  - http://git.kernel.org/tip/19d39a3810e7032f311ef83effdac40339b9d022
> >    (another issue, that breaks Droid 4 boot)
> >  - a git revert of 422580c3cea7
> > 
> > OTOH there are strange problems. Using da16dd9785f8 + above
> > two commits also works. Using b5e16170f59b + above commits
> > does not work and bisection ended up in the merge commit.
> 
> Hi, Sebastian!
> 
> As commit 422580c3cea7 hasn't added any code, which is executed
> during the boot process, I could imagine only two options:
> 1) Added code/data occasionally broke some alignment/size contraints.
> 2) There is another instable bug, which compromised bisect results.
> 
> Unfortunately, I can't help you with reproducing, because I haven't
> necessary hardware.
> 
> Can you, please, try some older known to be good revision with
> the 422580c3cea7 patch applied?

Sebastian, for me droid 4 boots just fine with v4.13-rc1 +
19d39a3810e if that helps. So that's with commit 422580c3cea7.

Regards,

Tony
